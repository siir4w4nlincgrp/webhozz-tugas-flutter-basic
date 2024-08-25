class ModelWalkthrough {
  String? title;
  String? description;
  String? image;
  ModelWalkthrough(
    {
      this.title,
      this.description,
      this.image
    }
  );
}

List walkthroughList = [
  ModelWalkthrough(
    title: "Jelajahi Berbagai Pilihan Truck untuk Kebutuhan Anda",
    description: "Jelajahi berbagai tipe truck yang kami sediakan, dari yang kecil hingga yang besar, untuk memastikan Anda menemukan kendaraan yang ideal untuk setiap pengiriman.",
    image: "assets/images/truck-orange.png"
  ),
  ModelWalkthrough(
    title: "Ketahui Estimasi Waktu dan Biaya Pengiriman Sebelum Memesan",
    description: "Ketahui estimasi waktu kedatangan dan biaya pengiriman secara akurat. Kami memberikan informasi yang Anda butuhkan untuk membuat keputusan yang lebih baik sebelum memesan.",
    image: "assets/images/truck-orange-2.png"
  ),
  ModelWalkthrough(
    title: "Atur Rute Pengiriman Anda dengan Mudah dan Fleksibel",
    description: "Dengan kemampuan untuk menentukan titik penjemputan dan tujuan yang tepat, Anda dapat mengatur perjalanan pengiriman sesuai dengan preferensi Anda, meningkatkan kontrol dan efisiensi.",
    image: "assets/images/route-orange.png"
  ),
];