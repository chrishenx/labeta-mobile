Iterable<int> generateIntegers(int stop, {int start = 0, int step = 1}) sync* {
  assert(step != 0);
  if (step > 0) {
    assert(start <= stop);
    for (int i = start; i <= stop; i += step) {
      yield i;
    }
  }
  if (step < 0) {
    assert(start >= stop);
    for (int i = start; i >= stop; i += step) {
      yield i;
    }
  }
}

Iterable<int> generateNaturals(int stop, {int start = 1, int step = 1}) {
  assert(step > 0 && start > 0 && stop > start);
  return generateIntegers(stop, start: start, step: step);
}
