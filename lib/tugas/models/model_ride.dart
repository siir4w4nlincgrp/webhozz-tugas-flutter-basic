class ModelRide {
  int id;
  String title;
  String subTitle;
  String cost;
  String time;
  bool? isPromo;
  String? image;

  ModelRide(
    {
      required this.id,
      required this.title,
      required this.subTitle,
      required this.cost,
      required this.time,
      this.isPromo,
      required this.image,
    }
  );
}

List<ModelRide> listRides() {
  List<ModelRide> list = [];

  list.add(ModelRide(
      id: 1,
      title: 'Mobil tipe A',
      subTitle: '4 Penumpang',
      cost: 'Rp 40.000',
      time: '10-20 min',
      image: 'assets/images/truck-front.png',
    isPromo: true
  ));

  list.add(ModelRide(
      id: 2,
      title: 'Mobil tipe B',
      subTitle: '4 Penumpang',
      cost: 'Rp 60.000',
      time: '5-10 min',
      image: 'assets/images/truck-front.png',
      isPromo: false
  ));

  list.add(ModelRide(
      id: 3,
      title: 'Mobil tipe C',
      subTitle: '4 Penumpang',
      cost: 'Rp 100.000',
      time: '5-10 min',
      image: 'assets/images/truck-front.png',
      isPromo: false
  ));


  return list;
}