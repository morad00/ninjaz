part of 'bottom_navigation_bloc.dart';

class BottomNavigationState extends Equatable {
  final int currentTabIndex;
  final PageController tabsController;

  const BottomNavigationState({
    required this.currentTabIndex,
    required this.tabsController,
  });

  factory BottomNavigationState.initial() => BottomNavigationState(
        currentTabIndex: 0,
        tabsController: PageController(),
      );

  @override
  List<Object> get props => [
        currentTabIndex,
        tabsController,
      ];

  BottomNavigationState copyWith({
    int? currentTabIndex,
    PageController? tabsController,
  }) {
    return BottomNavigationState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      tabsController: tabsController ?? this.tabsController,
    );
  }
}
