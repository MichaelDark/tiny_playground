import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImseaSearchPage extends StatefulWidget {
  const ImseaSearchPage({Key? key}) : super(key: key);

  @override
  State<ImseaSearchPage> createState() => _ImseaSearchPageState();
}

class _ImseaSearchPageState extends State<ImseaSearchPage> {
  final _debouncer = Debouncer(duration: const Duration(milliseconds: 500));
  final _client = ImseaClient();
  late final TextEditingController _controller;
  Future<ImseaResponse>? _request;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(_onChanged);
  }

  void _onChanged() {
    final value = _controller.text;
    if (value.isEmpty) {
      if (!mounted) return;
      _debouncer.cancel();
      setState(() {
        _request = null;
      });
    } else {
      _debouncer.run(() {
        if (!mounted) return;
        setState(() {
          _request = _client.makeRequest(value);
        });
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imsea'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(controller: _controller),
              ),
              Expanded(
                child: _request == null ? _buildEmptySearch() : _buildImages(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptySearch() {
    return const Center(child: Text('Enter search query'));
  }

  Widget _buildError(dynamic error) {
    return Center(child: Text('$error'));
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildImages() {
    final borderRadius = BorderRadius.circular(16);

    return FutureBuilder<ImseaResponse>(
      key: ValueKey(_request),
      future: _request,
      builder: (context, snapshot) {
        if (snapshot.hasError) return _buildError(snapshot.error);
        if (!snapshot.hasData) return _buildLoading();

        final images = snapshot.data?.results ?? [];
        return ListView.builder(
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(16),
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius,
              ),
              child: ClipRRect(
                borderRadius: borderRadius,
                child: Image.network(
                  images[index],
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class Debouncer {
  final Duration duration;
  Timer? _timer;

  Debouncer({required this.duration});

  void cancel() {
    _timer?.cancel();
  }

  void run(VoidCallback action) {
    cancel();
    _timer = Timer(duration, action);
  }
}

class ImseaResponse {
  final String imageName;
  final DateTime requestedAt;
  final List<String> results;

  const ImseaResponse({
    required this.imageName,
    required this.requestedAt,
    required this.results,
  });

  bool get isOutdated {
    return requestedAt.difference(DateTime.now()).abs() >
        const Duration(minutes: 5);
  }
}

class ImseaClient {
  final Map<String, ImseaResponse> cachedResponses = {};

  ImseaClient();

  Future<ImseaResponse> makeRequest(String query) async {
    ImseaResponse? cachedResponse = cachedResponses[query];
    if (cachedResponse == null || cachedResponse.isOutdated) {
      cachedResponse = await _makeRequest(query);
      cachedResponses[query] = cachedResponse;
    }
    return cachedResponse;
  }

  Future<ImseaResponse> _makeRequest(String query) async {
    try {
      final response = await http.get(
        Uri(
          scheme: 'https',
          host: 'imsea.herokuapp.com',
          path: 'api/1',
          queryParameters: {
            'q': query,
          },
        ),
      );

      if (response.statusCode != 200) throw 'Smth went wrong :(';
      final responseJson = json.decode(response.body) as Map<String, dynamic>;

      final parsedResponse = ImseaResponse(
        imageName: responseJson['image_name'],
        requestedAt: DateTime.now(),
        results:
            (responseJson['results'] as List).cast<String>().toSet().toList(),
      );

      return parsedResponse;
    } catch (error) {
      throw 'Smth went wrong :(';
    }
  }
}
