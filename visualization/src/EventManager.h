//
//  EventManager.h
//  visualization
//
//  Created by Robby on 1/18/17.
//
//

#ifndef EventManager_h
#define EventManager_h

#include "ofMain.h"
#include "ofxOsc.h"

class EventManager : public ofBaseApp{
	
public:
	void setup(unsigned int port);
	void update();

	string msg_string;

private:
	unsigned int PORT;
	ofxOscReceiver receiver;
};

#endif /* EventManager_h */
