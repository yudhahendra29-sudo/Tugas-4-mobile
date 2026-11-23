import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: Katalog()));
}

class Katalog extends StatefulWidget {
  const Katalog({super.key});

  static const List<Map<String, String>> items = [
    {
      'nama': 'Tas Ransel Laptop',
      'kategori': 'Tas',
      'harga': 'Rp 350.000',
      'rating': '4.5',
      'gambar': 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png',
      'deskripsi': 'Tas ransel muat laptop hingga 15 inci, cocok untuk kuliah dan kerja.',
    },
    {
      'nama': 'Kaos Slim Fit Pria',
      'kategori': 'Pakaian',
      'harga': 'Rp 120.000',
      'rating': '4.2',
      'gambar': 'https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_t.png',
      'deskripsi': 'Kaos bahan katun lembut, nyaman dipakai sehari-hari.',
    },
    {
      'nama': 'Jaket Katun Pria',
      'kategori': 'Pakaian',
      'harga': 'Rp 425.000',
      'rating': '4.4',
      'gambar': 'https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_t.png',
      'deskripsi': 'Jaket hangat untuk musim hujan dan perjalanan jauh.',
    },
    {
      'nama': 'Kemeja Casual',
      'kategori': 'Pakaian',
      'harga': 'Rp 180.000',
      'rating': '4.3',
      'gambar': 'https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_t.png',
      'deskripsi': 'Kemeja casual slim fit, cocok untuk acara santai.',
    },
    {
      'nama': 'Gelang Rantai Perak',
      'kategori': 'Aksesoris',
      'harga': 'Rp 275.000',
      'rating': '4.6',
      'gambar':
          'https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_t.png',
      'deskripsi': 'Gelang rantai model naga, bahan perak berkualitas.',
    },
    {
      'nama': 'Hardisk Eksternal 2TB',
      'kategori': 'Elektronik',
      'harga': 'Rp 950.000',
      'rating': '4.7',
      'gambar': 'https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_t.png',
      'deskripsi': 'Penyimpanan portable USB 3.0, cepat dan ringkas.',
    },
    // ---------- Produk baru (Tugas 1) ----------
    {
      'nama': 'SSD SanDisk 1TB',
      'kategori': 'Elektronik',
      'harga': 'Rp 1.100.000',
      'rating': '4.8',
      'gambar': 'https://fakestoreapi.com/img/61U7T1koQqL._AC_SX679_t.png',
      'deskripsi': 'SSD internal 1TB, booting dan transfer data lebih cepat.',
    },
    {
      'nama': 'Figure Zero Two',
      'kategori': 'Figure',
      'harga': 'Rp 700.000',
      'rating': '4.5',
      'gambar': 'assets/images/zero two.jpeg',
      'deskripsi': 'Untuk kalian pecinta mayat yang sudah lumutan nunggu season 2 selama 8 tahun.',
    },
    {
      'nama': 'Figure Naruto',
      'kategori': 'Figure',
      'harga': 'Rp 650.000',
      'rating': '4.4',
      'gambar':
          'assets/images/naruto.jpeg',
      'deskripsi': 'Figure untuk kalangan pecinta Naruto Khususnya MC nya.',
    },
    {
      'nama': 'Figure sasuke',
      'kategori': 'Figures',
      'harga': 'Rp 650.000',
      'rating': '4.1',
      'gambar':
          'assets/images/sasuke.jpeg',
      'deskripsi': 'Figure untuk yang ngehusbuin carakter ganteng.',
    },
  ];

  
  static Widget _gambar(String url, {double? size}) {
    return Image.network(
      url,
      width: size,
      height: size,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return SizedBox(
          width: size,
          height: size,
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        );
      },
      errorBuilder: (context, error, stack) => SizedBox(
        width: size,
        height: size,
        child: const Icon(Icons.image_not_supported, color: Colors.grey),
      ),
    );
  }

  @override
  State<Katalog> createState() => _KatalogState();
}

class _KatalogState extends State<Katalog> {
  
  List<String> favorit = [];

  
  Widget _judul(String teks, IconData ikon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: Row(
        children: [
          Icon(ikon, color: Colors.deepPurple),
          const SizedBox(width: 8),
          Text(
            teks,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  
  Widget _rating(String nilai) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 16),
        const SizedBox(width: 2),
        Text(nilai, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  
  void _ubahFavorit(BuildContext context, String nama) {
    setState(() {
      if (favorit.contains(nama)) {
        favorit.remove(nama);
      } else {
        favorit.add(nama);
      }
    });

    final pesan = favorit.contains(nama)
        ? '$nama ditambahkan ke Favorit'
        : '$nama dihapus dari Favorit';

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(pesan), duration: const Duration(seconds: 2)),
    );
  }

  
  Widget _tombolFavorit(BuildContext context, String nama) {
    final aktif = favorit.contains(nama);
    return IconButton(
      onPressed: () => _ubahFavorit(context, nama),
      icon: Icon(
        aktif ? Icons.favorite : Icons.favorite_border,
        color: aktif ? Colors.red : Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const items = Katalog.items;

    
    final lebar = MediaQuery.of(context).size.width;
    final jumlahKolom = lebar >= 600 ? 3 : 2;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Katalog Produk",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple, 
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.shopping_cart, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _judul('Daftar Produk', Icons.list),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Card(
                        color: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          onTap: () => _bukaDetail(context, item),
                          contentPadding: const EdgeInsets.all(8),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Katalog._gambar(item['gambar']!, size: 60),
                          ),
                          title: Text(
                            item['nama']!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['deskripsi']!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    item['harga']!,
                                    style: const TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  _rating(item['rating']!),
                                ],
                              ),
                            ],
                          ),
                          trailing: _tombolFavorit(context, item['nama']!),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Setengah bawah: judul + GridView
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _judul('Galeri Produk', Icons.grid_view),
                Expanded(
                  child: GridView.count(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    crossAxisCount: jumlahKolom,
                    childAspectRatio: 0.85,
                    children: List.generate(items.length, (index) {
                      final item = items[index];
                      return Card(
                        color: Colors.white,
                        elevation: 2,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () => _bukaDetail(context, item),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      color: Colors.white,
                                      padding: const EdgeInsets.all(8),
                                      child: Katalog._gambar(item['gambar']!),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: _tombolFavorit(
                                        context,
                                        item['nama']!,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['nama']!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item['harga']!,
                                          style: const TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        _rating(item['rating']!),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  
  void _bukaDetail(BuildContext context, Map<String, String> item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailProduk(produk: item)),
    );
  }
}


class DetailProduk extends StatelessWidget {
  final Map<String, String> produk;

  const DetailProduk({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          produk['nama']!,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          // Gambar besar
          Container(
            color: Colors.white,
            height: 300,
            padding: const EdgeInsets.all(24),
            child: Katalog._gambar(produk['gambar']!),
          ),
          // Informasi produk
          Container(
            color: Colors.white,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Chip(
                  label: Text(produk['kategori']!),
                  backgroundColor: Colors.deepPurple[50],
                ),
                const SizedBox(height: 8),
                Text(
                  produk['nama']!,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  produk['harga']!,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      produk['rating']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(height: 32),
                const Text(
                  'Deskripsi Produk',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  produk['deskripsi']!,
                  style: const TextStyle(fontSize: 14, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
      
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Tambah ke Keranjang'),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${produk['nama']} ditambahkan ke keranjang'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
