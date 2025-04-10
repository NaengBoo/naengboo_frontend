class RecipeDummyData {
  final String name;
  final String imageUrl;
  final List<String> requiredIngredients;
  final String instructions;
  bool isFavorite;

  final bool isLowCalorie;
  final bool isVegetarian;
  final bool isHighProtein;

  final bool isLowCarbHighFat;       // 저탄고지
  final bool isQuickToMake;          // 금방 만들 수 있는
  final bool isHighCalorie;          // 고칼로리

  RecipeDummyData({
    required this.name,
    this.imageUrl = " ",
    required this.requiredIngredients,
    required this.instructions,
    this.isFavorite = false,
    this.isLowCalorie = false,
    this.isVegetarian = false,
    this.isHighProtein = false,
    this.isLowCarbHighFat = false,     // 추가: 저탄고지
    this.isQuickToMake = false,        // 추가: 금방 만들 수 있는
    this.isHighCalorie = false,        // 추가: 고칼로리
  });
}



List<RecipeDummyData> dummyRecipes = [
  RecipeDummyData(
    name: '김치볶음밥',
    requiredIngredients: ['밥', '김치', '대파', '참기름'],
    instructions: '1. 팬에 기름을 두르고 대파를 볶다가\n2. 김치를 넣고 볶은 후\n3. 밥을 넣고 잘 비빈다.\n4. 마지막에 참기름을 둘러 완성.',
    isLowCalorie: true,
    isVegetarian: true,
    isQuickToMake: true,
  ),
  RecipeDummyData(
    name: '계란찜',
    requiredIngredients: ['계란', '물', '소금'],
    instructions: '1. 계란을 풀고 물과 소금을 섞는다.\n2. 약한 불에서 중탕으로 익힌다.\n3. 부드럽게 익으면 완성.',
    isLowCalorie: true,
    isHighProtein: true,
    isQuickToMake: true,
  ),
  // 추가적인 더미 데이터들...
];
