class WriteOff {
  String name;
  String category;
  int amount;
  String assetIcon;
  int daysBeforeCancel;
  int maxDays;

  WriteOff({
    required this.name,
    required this.category,
    required this.amount,
    required this.assetIcon,
    required this.daysBeforeCancel,
    this.maxDays = 30,
  });
}
