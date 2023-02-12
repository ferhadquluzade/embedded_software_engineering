
#include <iostream>
#include <unistd.h>
#include <vector>
#include <stdlib.h>

using namespace std;


enum Lights{
    GREEN,
    YELLOW,
    RED
};

void print(vector<enum Lights> &v){
    
    for (auto i = v.begin(); i != v.end(); ++i){
        if (*i==0){
            cout << "\x1b[32m GREEN";
        }
        else if (*i==1){
            cout << "\x1b[33m YELLOW";
        }
        else {
            cout << "\x1b[31m RED";
        }
        cout<<endl;
    }
    cout<<endl;

};

int main(int argc, const char * argv[]) {
    
    vector<enum Lights> trafficLight;
    
    sleep(3);
    trafficLight.push_back(RED);
    int t= 20;
    while (t>0) {
        switch ( trafficLight.back()) {
            case 0:
                print(trafficLight);
                sleep(3);
                trafficLight[0]=YELLOW;
                break;
            case 1:
                print(trafficLight);
                sleep(1);
                if(trafficLight.size()==2){
                    trafficLight[0]=GREEN;
                    trafficLight.pop_back();
                }
                else{
                    trafficLight[0]=RED;
                }

                break;
            case 2:
                print(trafficLight);
                sleep(3);
                trafficLight.push_back(YELLOW);
                break;
            default:
                trafficLight[0]=RED;
                break;
        }
        t--;
    }
    
    return 0;
}
