class Answer {
  final int id;
  final String answer;
  int? selected;
  bool? isSelected;

  Answer(
      {required this.id,
      required this.answer,
      this.selected,
      this.isSelected = false});

  void setSelected(int newSelected) {
    selected = newSelected;
  }

  void setIsSelected(bool newIsSelected) {
    isSelected = newIsSelected;
  }
}
