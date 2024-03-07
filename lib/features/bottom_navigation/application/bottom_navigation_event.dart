part of 'bottom_navigation_bloc.dart';

abstract class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();
}

class NavigateToTab extends BottomNavigationEvent {
  final int tabIndex;

  @override
  List<Object> get props => [tabIndex];

  const NavigateToTab({required this.tabIndex});
}

class UpdateTabIndexWithoutNavigation extends BottomNavigationEvent {
  final int tabIndex;

  @override
  List<Object> get props => [tabIndex];

  const UpdateTabIndexWithoutNavigation({
    required this.tabIndex,
  });
}

class BottomNavigationEvents {
  static void navigateToTab(BuildContext context, {required int tabIndex}) {
    BlocProvider.of<BottomNavigationBloc>(context).add(
      NavigateToTab(tabIndex: tabIndex),
    );
  }
}
