// $Id: BlinkAppC.nc,v 1.6 2010-06-29 22:07:14 scipio Exp $

/*									tab:4
 * Copyright (c) 2000-2005 The Regents of the University  of California.  
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the University of California nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Copyright (c) 2002-2005 Intel Corporation
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached INTEL-LICENSE     
 * file. If you do not find these files, copies can be found by writing to
 * Intel Research Berkeley, 2150 Shattuck Avenue, Suite 1300, Berkeley, CA, 
 * 94704.  Attention:  Intel License Inquiry.
 */

/**
 * Blink is a basic application that toggles a mote's LED periodically.
 * It does so by starting a Timer that fires every second. It uses the
 * OSKI TimerMilli service to achieve this goal.
 *
 * @author tinyos-help@millennium.berkeley.edu
 **/


configuration RoboHomeBaseAppC
{
}
implementation
{
  components MainC, RoboHomeBaseC as App , LedsC;
  //components SerialActiveMessageC as AM;
  components ActiveMessageC as AMsg;
  components new TimerMilliC();
  components new TimerMilliC() as PWMTimer;
  components new TimerMilliC() as TimerD;
  components new TimerMilliC() as PIRInput;
  components HplMsp430GeneralIOC;
  //components HplMsp430GeneralIOC as PIR;

  App.ADC0_PIN3  -> HplMsp430GeneralIOC.Port60;
  App.ADC1_PIN5  -> HplMsp430GeneralIOC.Port61;
  App.ADC2_PIN7  -> HplMsp430GeneralIOC.Port62;
  App.ADC3_PIN10 -> HplMsp430GeneralIOC.Port63;
  App.ADC6_PIN1  -> HplMsp430GeneralIOC.Port66; 

  //temp change for pin test
  App.ADC6_PIN2  -> HplMsp430GeneralIOC.Port67;
  App.Boot -> MainC.Boot;

  //App.PIR -> HplMsp430GeneralIOC.Port21; 
  //App.PIRInput -> HplMsp430InterruptC.Port21;
  App.Control -> AMsg;
  //App.Control -> AM;
  //App.Receive -> AMsg.Receive[AM_MOTE_STATUS_MSG];
  //App.Receive -> AM.Receive[AM_MOTE_STATUS_MSG];
  //App.AMSend -> AM.AMSend[AM_MOTE_STATUS_MSG];
  //App.AMsgRcv -> AMsg.Receive[AM_MOTE_STATUS_MSG];
  App.Leds -> LedsC;
  App.MilliTimer -> TimerMilliC;
  App.PIRInput -> PIRInput;
  App.PWMTimer -> PWMTimer;
  //App.TimerD->TimerD;
  //App.TimerD->TimerD;
  //App.Packet -> AMsg;
  //App.Packet -> AM;
}

