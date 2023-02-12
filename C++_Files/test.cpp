#include "gtest/gtest.h"
#include "../Project1/main.cpp"

TEST(CheckPositiveValue, UnitTest) {
	int sampleArray[] = { -3, -2, -1, 1 };
	int expected = 1;
	int result = checkPositive(sampleArray);
	EXPECT_EQ(expected, result);
}


TEST(CountPositive, UnitTest) {
	int sampleArray[] = { -3, 1, 2, 3 };
	int expected = 3;
	int result = countPositive(sampleArray);
	EXPECT_EQ(expected, result);
}

TEST(DefineEmptyIndex, UnitTest) {
	int sampleArray[] = { -3, 1, 2, 3 };
	int expected = 0;
	int result = getEmptyIndex(sampleArray);
	EXPECT_EQ(expected, result);
}

TEST(CharFinder, UnitTest) {
	string str  = "road1";
	string el = "1";
	int result = findChar(str, el);
	EXPECT_TRUE(result);
}

TEST(RoadCounter, UnitTest) {
	Road* road1 = new Road(1, 2, 0, "road1");
	Road* EMPTY = new Road(0, 0, 0, "");

	Road* roads[4] = {EMPTY, road1, EMPTY, EMPTY};
	int expected = 1;
	int result = countRoads(roads);
	EXPECT_EQ(expected, result);
}

TEST(CheckPositiveValue, DefectTest) {
	int sampleArray[] = { -3, -2, -1, -4 };
	int expected = -1;
	int result = checkPositive(sampleArray);
	EXPECT_EQ(expected, result);
}

TEST(CountPositive, DefectTest) {
	int sampleArray[] = { -3, -4, -5, -6 };
	int expected = 0;
	int result = countPositive(sampleArray);
	EXPECT_EQ(expected, result);
}

TEST(DefineEmptyIndex, DefectTest) {
	int sampleArray[] = { 4, 1, 2, 3 };
	int expected = 0;
	int result = getEmptyIndex(sampleArray);
	EXPECT_EQ(expected, result);
}

TEST(CharFinder, DefectTest) {
	string str = "road0";
	string el = "1";
	int result = findChar(str, el);
	EXPECT_FALSE(result);
}

TEST(RoadCounter, DefectTest) {
	Road* EMPTY = new Road(0, 0, 0, "");

	Road* roads[4] = { EMPTY, EMPTY, EMPTY, EMPTY };
	int expected = 0;
	int result = countRoads(roads);
	EXPECT_EQ(expected, result);
}



int main() {
	testing::InitGoogleTest();
	RUN_ALL_TESTS();
}