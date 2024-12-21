import 'dart:async';

class KzStateManager<T> {
  T _state;
  final StreamController<T> _stateController = StreamController<T>.broadcast();

  KzStateManager(this._state);

  T get state => _state;

  Stream<T> get stateStream => _stateController.stream;

  void update(T newState) {
    _state = newState;
    _stateController.add(_state);
  }

  Future<void> updateAsync(Future<T> newFutureState) async {
    _state = await newFutureState;
    _stateController.add(_state);
  }

  void dispose() {
    _stateController.close();
  }
}