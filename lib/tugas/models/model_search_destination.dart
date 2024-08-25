class ModelSearchDestination {
  String name;
  String address;

  ModelSearchDestination(
    {
      required this.name, required this.address
    }
  );
}

List<ModelSearchDestination> listDestinations() {
  List<ModelSearchDestination> list = [];

  list.add(ModelSearchDestination(name: 'Monas', address: 'Jakarta Pusat, 12345'));
  list.add(ModelSearchDestination(name: 'Senayan', address: 'Jakarta Selatan,12345'));
  list.add(ModelSearchDestination(name: 'Blok M', address: 'Jakarta Selatan,12345'));

  return list;

}