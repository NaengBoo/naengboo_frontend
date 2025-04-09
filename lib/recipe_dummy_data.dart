class RecipeDummyData {
  final String name;
  final List<String> ingredients;
  final String instructions;
  bool isFavorited;

  RecipeDummyData({
    required this.name,
    required this.ingredients,
    required this.instructions,
    this.isFavorited = false,
  });
}

List<RecipeDummyData> dummyRecipes = [
  RecipeDummyData(
    name: '김치볶음밥',
    ingredients: ['밥', '김치', '대파', '참기름'],
    instructions: '1. 팬에 기름을 두르고 대파를 볶다가\n2. 김치를 넣고 볶은 후\n3. 밥을 넣고 잘 비빈다.\n4. 마지막에 참기름을 둘러 완성.',
  ),
  RecipeDummyData(
    name: '계란찜',
    ingredients: ['계란', '물', '소금'],
    instructions: '1. 계란을 풀고 물과 소금을 섞는다.\n2. 약한 불에서 중탕으로 익힌다.\n3. 부드럽게 익으면 완성.',
  ),
  // 추가적인 더미 데이터들...
];
