//
//  EventManager.cpp
//  visualization
//
//  Created by Robby on 1/18/17.
//
//

#include "EventManager.h"

void EventManager::setup(unsigned int port){
	PORT = port;
	receiver.setup(PORT);
}

void EventManager::update(){
	
	while(receiver.hasWaitingMessages()){
		ofxOscMessage m;
		receiver.getNextMessage(m);

//		m.getArgAsInt32()
//		m.getArgAsFloat()
//		m.getArgAsString()

		if(m.getAddress() == "/note"){
			int notePitch = m.getArgAsInt32(0);
			int noteVelocity = m.getArgAsInt32(1);
			int noteChannel = m.getArgAsInt32(2);
		}
		else if(m.getAddress() == "/pedal"){
			float pedalPosition = m.getArgAsFloat(0);
		}
		else{
			// store unrecognized message
			msg_string = "";
			msg_string = m.getAddress();
			msg_string += ": ";
			for(int i = 0; i < m.getNumArgs(); i++){
				// get the argument type
				msg_string += m.getArgTypeName(i);
				msg_string += ":";
				// display the argument - make sure we get the right type
				if(m.getArgType(i) == OFXOSC_TYPE_INT32){
					msg_string += ofToString(m.getArgAsInt32(i));
				}
				else if(m.getArgType(i) == OFXOSC_TYPE_FLOAT){
					msg_string += ofToString(m.getArgAsFloat(i));
				}
				else if(m.getArgType(i) == OFXOSC_TYPE_STRING){
					msg_string += m.getArgAsString(i);
				}
				else{
					msg_string += "unknown";
				}
			}
		}
	}
}

