import 'package:flutter/material.dart';
import 'package:softbenzproduct/screens/product_detail_response.dart';
class ProductImageGallery extends StatefulWidget {
  final List<Images> images;

  const ProductImageGallery({Key? key, required this.images}) : super(key: key);

  @override
  _ProductImageGalleryState createState() => _ProductImageGalleryState();
}

class _ProductImageGalleryState extends State<ProductImageGallery> {
  late List<Images> _displayImages;
  late Images _featureImage;

  @override
  void initState() {
    super.initState();

    _displayImages = List.from(widget.images);
    while (_displayImages.length < 5) {
      _displayImages.add(Images(path: 'https://via.placeholder.com/150'));
    }

    _featureImage = _displayImages[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.5,
          child: Image.network(
            _featureImage.path ?? "",
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Icon(Icons.error));
            },
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _displayImages.take(5).map((image) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _featureImage = image;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _featureImage == image ? Colors.blue : Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.network(
                      image.path ?? "",
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error, size: 40);
                      },
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
