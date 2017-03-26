/*

Author/Contact: ajha@wustl.edu, mcalero@wustl.edu

RoboHomeBase is the application that should be installed on end motes which interact with vents and motion sensor.
The various main component of application and flow are as listed below --

1. In Boot.booted() the application calls StdControl.start().
2. Once started successfully, ADC6_PIN1 and ADC3_PIN10 are set as high.
3. ADC6_PIN2 is set as Input to read readings from motion Sensor.
4. Periodic timer PIRInput is started to sample the sensor input every 1 second.
5. The component uses ActiveMessageC to communicate over radio with BaseStationMote.
6. In function Receive.receive() post message validation and verification that current mote is intended recipient of the message; open or close functions are called to either open or close the AC vent.
7. In event PIRInput.fired() the sensor reading is read. Based on the reading and current value of opencloseflag which tracks the current status of vent, appropriate function is called as applicable (open or close).
8. Function open – To open the vent the motor needs to be rotated counter clockwise. Relevant pins are handled in Open function for it and PWM Timer for 200 ms is fired at the end.
9. Function close – To close the vent the mote needs to be rotate clockwise. Relevant pins are handled in Close function for it and PWM Timer for 200 ms is fired at the end.
10. The component users mote_status_msg which is MIG related struct which is used to pass around messages between motes over the radio communication
*/




#include "Timer.h"
#include "MoteStatus.h"
#include <stdlib.h>

module RoboHomeBaseC 
{

  uses {
    interface SplitControl as Control;
    interface Leds;
    interface Boot;
    interface Receive;
    //interface AMSend;
    interface Timer<TMilli> as MilliTimer;
    interface Packet;
    interface Timer<TMilli> as PWMTimer;
    //interface Timer<TMilli> as TimerD;
 
    interface HplMsp430GeneralIO as ADC0_PIN3;
    interface HplMsp430GeneralIO as ADC1_PIN5;
    interface HplMsp430GeneralIO as ADC2_PIN7;
    interface HplMsp430GeneralIO as ADC3_PIN10;
    interface HplMsp430GeneralIO as ADC6_PIN1;
 
     interface HplMsp430GeneralIO as ADC6_PIN2;
    interface Timer<TMilli> as PIRInput; 
   
 }  
 
}
implementation
{
  int statusArray[] = {0,1,2};
  bool locked = FALSE;
  int INTERVAL = 5000;
  uint16_t flag = 1;
  //uint16_t MOTE_ID = 10;
  message_t packet;
  uint16_t  opencloseflag = 0;
  uint16_t offCounter = 0;
  uint16_t OFF_THRESHOLD = 10;
  uint16_t MOTE_ID=20;
  event void MilliTimer.fired() {
   
  }
  
     
  event void Boot.booted()
  {
	call Control.start();
  }



  event message_t* Receive.receive(message_t* bufPtr,
                                   void* payload, uint8_t len) {

/*	
      if (len != sizeof(mote_status_msg_t)) {return bufPtr;}
	else {

		mote_status_msg_t* rcm = (mote_status_msg_t*)payload;
		

               
                 if( (rcm->status)/MOTE_ID == 1){
		       //commented for motion sensor test
		       if(rcm->status%10 == 0){
         	        call Leds.led0On();
                	call Leds.led1Off();
	                call Leds.led2Off();
        		}else if (rcm->status%10 == 1){
                		call Leds.led0Off();
	        	        call Leds.led1On();
	        	        call Leds.led2Off();
        		}else if(rcm->status%10 == 2){
                		call Leds.led0Off();
	        	        call Leds.led1Off();
        		        call Leds.led2On();
        		}else{
				 call Leds.led0Toggle();
     				 call Leds.led1Toggle();
				 call Leds.led2Toggle();

			}
  			

		     if(rcm->status%MOTE_ID == 1 && opencloseflag == 0){
				open();		
				opencloseflag = 1;
			
			}else if(rcm->status%MOTE_ID == 0 && opencloseflag == 1){
				close();			
				opencloseflag = 0;
			}
		}	
	
	}

	//send the message to PC
	
		 if (call AMSend.send(AM_BROADCAST_ADDR, bufPtr, sizeof(mote_status_msg_t)) == SUCCESS) {
        		locked = TRUE;

      		}else{
		call Leds.led0On();
                call Leds.led1On();
                call Leds.led2On();
		}


	return 	bufPtr;
*/
  }

 /* event void AMSend.sendDone(message_t* bufPtr, error_t error) {
	if (&packet == bufPtr) {
     	 locked = FALSE;
	 if(error != SUCCESS){
//		call Leds.led0On();
//		call Leds.led1On();
//		call Leds.led2On();
	 }
    	}


*/
  event void Control.startDone(error_t err) {
    if (err == SUCCESS) {
      //call MilliTimer.startPeriodic(INTERVAL);
      // call ADC3_PIN10.selectModuleFunc();
      // call ADC3_PIN10.makeInput();
     //  call HplMsp430GeneralIOC.Port63.makeInput();
      //pull standby to high to enable bridge		
      call ADC6_PIN2.makeInput();
      call PIRInput.startPeriodic(1000);

    }
  }
  event void Control.stopDone(error_t err) {}

  event void PWMTimer.fired()
	{
		/*if(flag == 1){
			call ADC0_PIN3.set();
 			flag = 0;
		}else if(flag == 0){
			call ADC0_PIN3.clr();
			flag = 1;
		}*/
	}

   bool reading;
   event void PIRInput.fired(){
   //....
    atomic {
     reading = call ADC6_PIN2.get();
     if(reading)
 	call Leds.led2On();
         else
       call Leds.led2Off();
     }
    }

}
