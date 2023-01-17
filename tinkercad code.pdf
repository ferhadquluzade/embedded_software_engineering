class Road{
public:
    int numberOfCars = 0;
    int remainingMeters = 0;
    int isEmergencyCar = 0;
    int isActive = 0;
  	String name = "";
    Road(){};
    ~Road(){};
    
    Road(int num, int meter, int emergency, String name){
        numberOfCars = num;
        remainingMeters = meter;
        isEmergencyCar = emergency;
      	this->name = name;
        
    };
};
unsigned long started, ended, timeInterval;

Road* EMPTY = new Road(0,0,0,"");


void printWithPriority(String label, int number){
    Serial.print(label);
    Serial.write(number);
    Serial.print(";");
}

void setup(){
  Serial.begin(9600);
}

int checkPositive(int array[]){
    for(int i = 0; i<4;i++){
        if(array[i]>-1) return array[i];
    }
    return array[0];
}

int countPositive(int array[]){
    int counter = 0;
    for(int i = 0; i<4;i++){
        if(array[i]>-1)
            counter = counter +1;
    }
    return counter;
}

int getEmptyIndex(int array[]){
    for(int i = 0; i<4;i++){
        if(array[i] == -1)
            return i;
    }
    return 0;
}

int getEmptyRoadIndex(Road** array){
    for(int i = 0; i<4; i++){
        if(array[i]->numberOfCars == 0 )
            return i;
    }
    return 0;
}

int countRoads(Road** array){
    int counter = 0;
    for(int i = 0; i<4; i++){
        if(array[i]->numberOfCars != 0)
            counter = counter +1;
    }
    return counter;
}


int getEmptyIndex(int array[]);
int getEmptyRoadIndex(Road** array);
int countRoads(Road** array);
int countPositive(int array[]);
int checkPositive(int array[]);
void checkParallelism(Road** temp, int size);

void loop(){
  
  
    Road* intersection[4]= {EMPTY, EMPTY, EMPTY, EMPTY};
    int number, meter;
    int emergency, activity;
    int priority = 1;
    Road* temp[4] = {EMPTY, EMPTY, EMPTY, EMPTY};
    int size = 4;
 
  
  
    
    for (int i = 0; i < 4; i++){
        Serial.println((String)"\nRoad "+i);
        Serial.println("------------------");
        number = serialRead("cars");
        //  Serial.println("Remaining time: ");
        meter = serialRead("distance");
        //    Serial.println("Emergency car: ");
        emergency = serialRead("emergency cars num");
        //activity = serialRead("activity:");
        intersection[i] = new Road(number, meter, emergency, "");
        //  Serial.println("\activity after edit::::");
        //  Serial.write(intersection[i].isActive);
        Serial.write(number);
        Serial.write(meter);
        Serial.write(emergency);
    }
    
  	started = millis();
  	Serial.println("started>>>");
  	Serial.print(started);
  
  
    for (int j = 0; j < 4; j++){

      int emergencyRoadIndex[4] = {-1, -1, -1, -1};
      int busiestRoadIndex[4] = {-1, -1, -1, -1};
      int nearestIndex[4] = {-1, -1, -1, -1};
        int numberOfCars = 4;
        int remainingMeters = 1000;

        int countOfRoads = countRoads(intersection);
  

        for (int i = 0; i < countOfRoads; i++){
            if (intersection[i]->isEmergencyCar == 1){
                 emergencyRoadIndex[getEmptyIndex(emergencyRoadIndex)] = i;
            }
            
            if (intersection[i]->numberOfCars >= numberOfCars){
                if (intersection[i]->numberOfCars != numberOfCars){
                	for (int i = 0; i < (sizeof(busiestRoadIndex) / sizeof(busiestRoadIndex[0])); i++){
                		busiestRoadIndex[i] = -1;
                    }
                }
                busiestRoadIndex[getEmptyIndex(busiestRoadIndex)] = i;
                numberOfCars = intersection[i]->numberOfCars;
            }
            
            if (intersection[i]->remainingMeters <= remainingMeters){
                if (intersection[i]->remainingMeters != remainingMeters){
                    for (int i = 0; i < (sizeof(nearestIndex) / sizeof(nearestIndex[0])); i++){
                		nearestIndex[i] = -1;
                    }
                }
                nearestIndex[getEmptyIndex(nearestIndex)] = i;
                remainingMeters = intersection[i]->remainingMeters;
            }
        }
      


        
        if (countPositive(emergencyRoadIndex) == 1){
            intersection[checkPositive(emergencyRoadIndex)]->isActive = priority;
            priority = priority + 1;
        }
        else if (countPositive(emergencyRoadIndex) > 1){
            int minDistanceIndex = checkPositive(emergencyRoadIndex);
            for (int i = 0; i < (sizeof(emergencyRoadIndex) / sizeof(emergencyRoadIndex[0])); i++){
               
              if (emergencyRoadIndex[i]>-1)
              {
              if (intersection[emergencyRoadIndex[i]]->remainingMeters < intersection[emergencyRoadIndex[minDistanceIndex]]->remainingMeters){
                   
                minDistanceIndex = i;
                }
              }
            }
            intersection[emergencyRoadIndex[minDistanceIndex]]->isActive = priority;
            priority = priority + 1;
        }
        else{
            if (countPositive(busiestRoadIndex) == 1){
                intersection[checkPositive(busiestRoadIndex)]->isActive = priority;
                priority = priority + 1;
            }
            else if (countPositive(busiestRoadIndex) > 1){
                int minDistanceIndex = checkPositive(busiestRoadIndex);
                for (int i = 0; i < (sizeof(busiestRoadIndex) / sizeof(busiestRoadIndex[0])); i++){
                  if(busiestRoadIndex[i]>-1){
                    if (intersection[busiestRoadIndex[i]]->remainingMeters < intersection[busiestRoadIndex[minDistanceIndex]]->remainingMeters){
                        minDistanceIndex = i;
                    }
                  }
                    
                }
                intersection[busiestRoadIndex[minDistanceIndex]]->isActive = priority;
                priority = priority + 1;
                
            }
            else{
                intersection[checkPositive(nearestIndex)]->isActive = priority;
                priority = priority + 1;
            }
            
        }
        
        for (int i = 0; i < 4; i++){

          if(intersection[i]->numberOfCars != 0 ){
          	if (intersection[i]->isActive > 0){

              temp[getEmptyRoadIndex(temp)] = intersection[i];

            	for(int x = i; x< 3; x++){
              		 intersection[x] = intersection[x+1];
            	}
              intersection[3] = new Road(0,0,0,"");

           	}
            //Serial.println("slmslmslmslsmslsml");

          }

        }

      //for (int i = 0; i < 4; i++){
      //Serial.println("slmslmslmslsmslsmls");
       //Serial.write(intersection[i]->numberOfCars);

      //}
      	int tempCount = countRoads(temp);
		checkParallelism(temp,tempCount);
      Serial.println(":::::::finished");
    }
 
    
    Serial.println("==================================");
    
    
    
    
    
    for (int i = 0; i < 4; i++){
        printWithPriority("Number of cars: ", temp[i]->numberOfCars);
        printWithPriority("Remaining time: ", temp[i]->remainingMeters);
        printWithPriority("Emergency car: ", temp[i]->isEmergencyCar);
        Serial.println("Activity");
    	Serial.println(temp[i]->isActive);
    }
  ended = millis();
  timeInterval = ended - started;
  Serial.println("<<<ended");
 // Serial.print(ended/1000+":"+(ended%1000/100));
  Serial.print(timeInterval);
  
/*  Serial.println("execution time:::");
 // Serial.write(ended-started);
    */
}

int serialRead(String label){
    int readValue;
    Serial.println("\nEnter " + label);
    while (Serial.available() == 0){}
    readValue = Serial.read();
    Serial.write(readValue);
    return readValue;
}

bool findChar(String s, String el)
{
  	
    //string in aurdino has no find method
    return s.indexOf(el) < s.length();
}

void checkParallelism(Road** temp, int size)
{
    int cur = temp[0]->isActive;
    for (int i = 0; i < size; i++) {
        if (i < size - 1) {
            if ((findChar(temp[i]->name, "1") && findChar(temp[i + 1]->name, "3")) || (findChar(temp[i]->name, "3") && findChar(temp[i + 1]->name, "1")) || (findChar(temp[i]->name, "2") && findChar(temp[i + 1]->name, "4")) || (findChar(temp[i]->name, "4") && findChar(temp[i + 1]->name, "2"))) {
                if (temp[i]->isActive > 1) {
                    temp[i]->isActive = cur;
                }
                temp[i + 1]->isActive = temp[i]->isActive;

            }
            else {
                cur += 1;
            }
        }
        else {
            temp[i]->isActive = cur;
        }
    }
}