#include "iostream"
#include<string>
#include "gtest/gtest.h"

using namespace std;

class Road {
public:
    int numberOfCars = 0;
    int remainingMeters = 0;
    int isEmergencyCar = 0;
    int isActive = 0;
    string name = "";

    Road();
    ~Road();

    Road(int num, int meter, int emergency, string name) {
        numberOfCars = num;
        remainingMeters = meter;
        isEmergencyCar = emergency;
        this->name = name;


    };
};
//unsigned long started, ended, timeInterval;

Road* EMPTY = new Road(0, 0, 0, "");


void printWithPriority(string label, int number) {
    cout << label << " " << number << endl;

}

int checkPositive(int array[]) {
    for (int i = 0; i < 4; i++) {
        if (array[i] > -1) { return array[i]; }
    }
    return -1;
    
}

int countPositive(int array[]) {
    int counter = 0;
    for (int i = 0; i < 4; i++) {
        if (array[i] > -1)
            counter = counter + 1;
    }
    return counter;
}

int getEmptyIndex(int array[]) {
    int ii = 0;
    for (int i = 0; i < 4; i++) {
        if (array[i] == -1)
            ii = i;
    }
    return ii;
}

int getEmptyRoadIndex(Road** array) {
    int ii = 0;
    for (int i = 0; i < 4; i++) {
        if (array[i]->numberOfCars == 0)
            ii = i;
    }
    return ii;
}

int countRoads(Road** array) {
    int counter = 0;
    for (int i = 0; i < 4; i++) {
        if (array[i]->numberOfCars != 0)
            counter = counter + 1;
    }
    return counter;
}

bool findChar(string s, string el) {
    return s.find(el) < s.length();
}

bool checkParallelism(Road** temp) {
    bool state = false;
    int cur = temp[0]->isActive;
    int size = countRoads(temp);
    for (int i = 0; i < size; i++) {
        if (i < size-1) {
            if ((findChar(temp[i]->name, "1") && findChar(temp[i + 1]->name, "3")) || (findChar(temp[i]->name, "3") && findChar(temp[i + 1]->name, "1")) || (findChar(temp[i]->name, "2") && findChar(temp[i + 1]->name, "4")) || (findChar(temp[i]->name, "4") && findChar(temp[i + 1]->name, "2"))) {
                if (temp[i]->isActive > 1) {
                    temp[i]->isActive = cur;
                }
                temp[i + 1]->isActive = temp[i]->isActive;
                state = true;
            }
            else {
                cur += 1;
            }
        }
        else {
            temp[i]->isActive = cur;
        }
    }
    return state;
}


int main() {

    Road* intersection[4] = { EMPTY, EMPTY, EMPTY, EMPTY };
    int number, meter;
    int emergency;
    int priority = 1;
    Road* temp[4] = { EMPTY, EMPTY, EMPTY, EMPTY };

    testing::InitGoogleTest();
    RUN_ALL_TESTS();


    for (int i = 0; i < 4; i++) {
        string name = "Road " + to_string(i + 1);
        cout << name << endl;
        cout << "------------------" << endl;
        cout << "cars: ";
        cin >> number;
        cout << "time: ";
        cin >> meter;
        cout << "emergency cars num: ";
        cin >> emergency;
        intersection[i] = new Road(number, meter, emergency, name);

    }




    for (int j = 0; j < 4; j++) {

        int emergencyRoadIndex[4] = { -1, -1, -1, -1 };
        int busiestRoadIndex[4] = { -1, -1, -1, -1 };
        int nearestIndex[4] = { -1, -1, -1, -1 };
        int numberOfCars = 4;
        int remainingMeters = 1000;

        int countOfRoads = countRoads(intersection);



        for (int i = 0; i < countOfRoads; i++) {

            if (intersection[i]->isEmergencyCar == 1) {
                emergencyRoadIndex[getEmptyIndex(emergencyRoadIndex)] = i;
            }

            if (intersection[i]->numberOfCars >= numberOfCars) {
                if (intersection[i]->numberOfCars != numberOfCars) {
                    for (int i = 0; i < 4; i++) {
                        busiestRoadIndex[i] = -1;
                    }
                }
                busiestRoadIndex[getEmptyIndex(busiestRoadIndex)] = i;
                numberOfCars = intersection[i]->numberOfCars;
            }

            if (intersection[i]->remainingMeters <= remainingMeters) {
                if (intersection[i]->remainingMeters != remainingMeters) {
                    for (int i = 0; i < 4; i++) {
                        nearestIndex[i] = -1;
                    }
                }
                nearestIndex[getEmptyIndex(nearestIndex)] = i;
                remainingMeters = intersection[i]->remainingMeters;
            }
        }


        if (countPositive(emergencyRoadIndex) == 1) {
            intersection[checkPositive(emergencyRoadIndex)]->isActive = priority;
            priority = priority + 1;
        }
        else if (countPositive(emergencyRoadIndex) > 1) {
            int minDistanceIndex = checkPositive(emergencyRoadIndex);
            for (int i = 0; i < 4; i++) {

                if (emergencyRoadIndex[i] > -1)
                {
                    if (intersection[emergencyRoadIndex[i]]->remainingMeters < intersection[emergencyRoadIndex[minDistanceIndex]]->remainingMeters) {

                        minDistanceIndex = i;
                    }
                }
            }
            intersection[emergencyRoadIndex[minDistanceIndex]]->isActive = priority;
            priority = priority + 1;
        }
        else {
            if (countPositive(busiestRoadIndex) == 1) {
                intersection[checkPositive(busiestRoadIndex)]->isActive = priority;
                priority = priority + 1;
            }
            else if (countPositive(busiestRoadIndex) > 1) {
                int minDistanceIndex = checkPositive(busiestRoadIndex);
                for (int i = 0; i < (sizeof(busiestRoadIndex) / sizeof(busiestRoadIndex[0])); i++) {
                    if (busiestRoadIndex[i] > -1) {
                        if (intersection[busiestRoadIndex[i]]->remainingMeters < intersection[busiestRoadIndex[minDistanceIndex]]->remainingMeters) {
                            minDistanceIndex = i;
                        }
                    }

                }
                intersection[busiestRoadIndex[minDistanceIndex]]->isActive = priority;
                priority = priority + 1;

            }
            else {
                intersection[checkPositive(nearestIndex)]->isActive = priority;
                priority = priority + 1;
            }

        }

        for (int i = 0; i < 4; i++) {
            if (intersection[i]->numberOfCars != 0) {
                if (intersection[i]->isActive != 0) {
                    int emptyIndex = getEmptyRoadIndex(temp);
                    temp[emptyIndex] = intersection[i];
                    for (int x = i; x < 3; x++) {
                        intersection[x] = intersection[x + 1];
                    }
                    intersection[3] = new Road(0, 0, 0, "");
                }
            }
        }
        //checkParallelism(temp);

    }


    cout << "==================================" << endl;



    for (int i = 0; i < 4; i++) {
        cout << "Name: " << temp[i]->name << endl;
        printWithPriority("Number of cars: ", temp[i]->numberOfCars);
        printWithPriority("Remaining time: ", temp[i]->remainingMeters);
        printWithPriority("Emergency car: ", temp[i]->isEmergencyCar);
        printWithPriority("Activity:", temp[i]->isActive);
        //        Serial.println("Activity:");
        //        Serial.println(temp[i]->isActive);
        //        Serial.println("");
    }
    //  ended = millis();
    //  timeInterval = ended - started;
    //  Serial.println("<<<ended");
    // Serial.print(ended/1000+":"+(ended%1000/100));
    //  Serial.print(timeInterval);

    /*  Serial.println("execution time:::");
     // Serial.write(ended-started);
     */
}
//
//int serialRead(String label){
//    int readValue;
//    Serial.println("\nEnter " + label);
//    while (Serial.available() == 0){}
//    readValue = Serial.read();
//    Serial.write(readValue);
//    return readValue;
//}
