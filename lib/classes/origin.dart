class Origin{
    final int id;
    String name;
    Location location;

    Origin({
      required this.id,
      required this.name,
      required this.location
    });
}

class Location{
  String type;
  List<dynamic> coordinates;

  Location({required this.type,required this.coordinates});
}