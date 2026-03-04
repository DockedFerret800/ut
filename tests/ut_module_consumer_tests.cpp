import ut;

using namespace ut;

suite filter_tests = [] {
   "alpha"_test = [] { expect(true); };

   "beta"_test = [] { expect(true); };

   "gamma"_test = [] { expect(true); };

   test("delta test") = [] { expect(true); };

   test("epsilon test") = [] { expect(true); };
};
int main() {}
