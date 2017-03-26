README for RoboHomeBase
Author/Contact: ajha@wustl.edu, mcalero@wustl.edu

Description:


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

Tools:

Known bugs/limitations:

None.



