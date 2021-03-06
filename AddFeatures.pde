void CreateNodes() {
  nodes[0] = new Node(0, 200, 200, NODE_WIDTH, NODE_HEIGHT, "MOTORS & ENCODERS SYSTEM");
  nodes[0].AddLink("https://www.servocity.com/118-rpm-hd-premium-planetary-gear-motor-w-encoder");
  nodes[0].AddLink("https://learn.sparkfun.com/tutorials/pro-micro--fio-v3-hookup-guide/hardware-overview-pro-micro");
  nodes[0].AddImage("schematics/Encoders.png");
  nodes[0].CONTENTS_SIZE = 15;
  nodes[0].AddContents("This system emcompasses the motors which drive the wheels of the rover, as well as the encoder chips used to obtain feedback from the wheels.\n\nThe motors receive regulated power from the motor drivers to rotate the wheels at the speed set by the user, with a maximum speed of 118 RPM.\n\nThe encoders attached to each motor permit the measurement and calculation of the wheel’s respective speed. Hall Effect sensors measure the polarity of a section of a magnetic disk attached to the motor shaft and correspondingly output a HIGH or LOW signal.\n\nThese signals are read by an Arduino Pro Micro, which uses the number of pulses over a period of time to calculate how fast the magnetic disk is moving and, therefore, the speed of the shaft and connected wheel. The RPM calculations are then shared to the Raspberry Pi using ROS.");
  
  nodes[1] = new Node(1, 600, 400, NODE_WIDTH, NODE_HEIGHT, "RASPBERRY PI");
  nodes[1].AddLink("https://i.stack.imgur.com/sVvsB.jpg");
  nodes[1].AddImage("schematics/RaspberryPi.png");
  nodes[1].CONTENTS_SIZE = 15;
  nodes[1].AddContents("The Raspberry Pi is a minature computer that serves as the main processor of the rover, equating it to something similar to a “brain” for the system. The Pi’s balance between portability, cost, power consumption, processing power and available documentation distininguish the board as the superior choice for onboard processing.\n\nThe Pi is connected to every component on the rover in some manner and is able to use various communication mediums to retrieve data or send commands to them, including GPIO pins, UART and i2c. The Pi also serves as the entry point for bi-directional communcation with the base station, broadcasting and receiving information via an on-board radio.\n\nIn addition, the Pi uses ROS (Robot Operating System) to facilitate inter-component communications. ROS establishes a modular and robust framework primarily used for inter-component communcation.");
  
  nodes[2] = new Node(2, 1000, 200, NODE_WIDTH, NODE_HEIGHT, "GPS MODULE");
  nodes[2].AddLink("https://www.robotshop.com/en/uart-neo-7m-c-gps-module.html");
  nodes[2].ShareImage(nodes[1]);
  nodes[2].AddContents("The GPS module uses transmissions from satellites orbiting Earth to obtain the latitude and longitude coordinates of the component.\n\nThe module receives power from the Raspberry Pi and sends coordinate data to it via UART. If the module is unable to obtain position data, the red LED on the module will remain solid. On the other hand, the red LED will blink at 1 Hz if data is available.");
  
  nodes[3] = new Node(3, 600, 600, NODE_WIDTH, NODE_HEIGHT, "16-CHANNEL PWM DRIVER");
  nodes[3].AddLink("https://www.adafruit.com/product/815");
  nodes[3].ShareImage(nodes[1]);
  nodes[3].AddContents("The Pulse Width Modulation (PWM) driver receives desired PWM signals to be generated and outputs the required signals to a maximum of 16 channels.\n\nOnly 4 PWM channels are presently used on the rover – one channel for each wheel. The PWM signals to be generated is communicated from the Raspberry Pi via i2c and the PWM signals are generated depending on the desired speed of the wheels, with higher duty cycles corresponding to higher speeds.\n\nFinally, the generated PWM signals are output to the motor drivers for each corresponding motor.");
  
  nodes[4] = new Node(4, 200, 400, NODE_WIDTH, NODE_HEIGHT, "MOTOR DRIVERS");
  nodes[4].AddLink("https://www.robotshop.com/en/cytron-30a-5-30v-single-brushed-dc-motor-driver.html");
  nodes[4].AddLink("https://docs.google.com/document/d/178uDa3dmoG0ZX859rWUOS2Xyafkd8hSsSET5-ZLXMYQ/edit");
  nodes[4].AddLink("https://www.ebay.com.au/itm/DC-DC-15A-Buck-4-32V-12V-to-1-2-32V-5V-Converter-Step-Down-Module-Adjustable-Hot/202129187829?hash=item2f0fd6a3f5%3Ag%3AnEAAAOSw9N1V0vFq");
  nodes[4].AddImage("schematics/MotorDrivers.png");
  nodes[4].AddContents("Motor drivers are used to supply motors with sufficient driving power. They act as current amplifiers – taking in small current signals and converting them into large current signals which are able to drive motors. The motor drivers used in the rover also include inputs to set the direction of motor rotation (controlled by Raspberry Pi via GPIO pins) and a PWM input to set the motor speed (from PWM driver).\n\nThe motor drivers are connected to Buck Converters, which step down voltage from the LiPo power supply, while stepping up output current to the motor drivers.");
  
  nodes[5] = new Node(5, 1000, 600, NODE_WIDTH, NODE_HEIGHT, "360 DEGREE CAMERA");
  nodes[5].AddLink("https://theta360.com/en/about/theta/s.html");
  nodes[5].AddContents("The Ricoh Theta S is a 360 degree camera which is attached to the top of the rover, permitting the user at the base station a clear view of the area surrouding the rover.\n\nThe camera is connected to the Raspberry Pi via USB, from which it is powered and communicates data. However, the Pi does not do any image processing with the camera image. Instead, a particular program is used to redirect the USB data to other users on the network which, in this case, is the base station. Thus, assuming that the base station is able to communicate with the rover via the onboard radio, the base station is able to see the camera image - irregardless of distance.");
  nodes[5].kicad_enabled = false;
  
  nodes[6] = new Node(6, 1400, 400, NODE_WIDTH, NODE_HEIGHT, "ONBOARD RADIO");
  nodes[6].kicad_enabled = false;
  nodes[6].AddLink("https://www.ubnt.com/airmax/rocketm/");
  nodes[6].AddContents("The rover uses the Rocket M5 radio to establish communication between the base station and the rover.");
  
  nodes[7] = new Node(7, 600, -200, NODE_WIDTH, NODE_HEIGHT, "ARM CONTROLLER");
  nodes[7].AddLink("http://www.pighixxx.com/test/wp-content/uploads/2014/11/nano.png");
  nodes[7].AddImage("schematics/ArmController.png");
  nodes[7].AddContents("An Arduino is used to control the arm. It communicates with the Raspberry Pi over USB via ROS.\n\nThe Arduino controls the PWM signals for each servo/actuator by sending the desired PWM via i2c to the PWM driver and controls motor direction using GPIO output to the motor drivers.");
  
  nodes[8] = new Node(8, 1000, -200, NODE_WIDTH, NODE_HEIGHT, "ARM MOTOR & PWM DRIVERS");
  nodes[8].AddLink("https://www.robotshop.com/en/cytron-13a-5-30v-single-dc-motor-controller.html");
  nodes[8].AddLink("https://www.robotshop.com/media/files/pdf2/cyt-132-v2.3.pdf");
  nodes[8].AddLink("https://www.ebay.com.au/itm/DC-DC-15A-Buck-4-32V-12V-to-1-2-32V-5V-Converter-Step-Down-Module-Adjustable-Hot/202129187829?hash=item2f0fd6a3f5%3Ag%3AnEAAAOSw9N1V0vFq");
  nodes[8].AddImage("schematics/ArmMotorDrivers.png");
  nodes[8].AddContents("The motor drivers are responsible for supply the arm servo and actuators with sufficient driving power. They act as current amplififers - taking in small current signals and converting them into large current signals which are able to drive motors.\n\nThe motor drivers receive direction control signals from the Arduino board and PWM signals from the Arduino-controlled PWM driver.\n\nThe drivers are connected to Buck Converters, which step down voltage from the LiPo power supply, while stepping up output current to the drivers.");
  
  nodes[9] = new Node(9, 1400, -200, NODE_WIDTH, NODE_HEIGHT, "ARM SERVOS & ACTUATORS");
  nodes[9].kicad_enabled = false;
  nodes[9].AddContents("The servos and actuators move the arm to the set position by apply rotational and linear force.\n\n");
}

void CreateConnectors() {
  connectors[0] = new Connector(0, nodes[0],nodes[1],1,0,0, "USB", 0, 2);
  connectors[1] = new Connector(1, nodes[1],nodes[2],1,3,0, "UART", 0, 3);
  connectors[2] = new Connector(2, nodes[1],nodes[3],2,0,0, "i2c", 1, 1);
  connectors[3] = new Connector(3, nodes[4],nodes[3],2,3,2, "PWM", 1, 2);
  connectors[4] = new Connector(4, nodes[0],nodes[4],2,0,1, "PWR", 0, 1);
  connectors[5] = new Connector(5, nodes[4],nodes[1],1,3,0, "GPIO", 0, 1);
  connectors[6] = new Connector(6, nodes[1],nodes[5],1,3,0, "USB", 0, 3);
  connectors[7] = new Connector(7, nodes[1],nodes[6],1,3,0, "ETHERNET", 0, 1);
  connectors[8] = new Connector(8, nodes[1],nodes[7],0,2,0, "USB", 0, 1);
  connectors[9] = new Connector(9, nodes[7],nodes[8],1,3,0, "i2c", 0, 1);
  connectors[10] = new Connector(10, nodes[8],nodes[9],1,3,1, "PWR", 0, 1);
  connectors[11] = new Connector(11, nodes[7],nodes[8],1,3,0, "GPIO", 1, 1);
}