--  UPSMAN-MIB { iso org(3) dod(6) internet(1) private(4)
--   enterprises(1) generex(1356) }
--
-- Title: Enterprise Specific UPSMAN Top Level MIB
-- By: Quazar GmbH
--
-- (C) Copyright 1995-2003 GENEREX GmbH
-- All Rights Reserved.
--
-- 
-- Last Edit: 23.01.2003 (KFRIELER: klaus@generex.de)
-- State    : green
--
--

UPSMAN DEFINITIONS ::= BEGIN

IMPORTS
      enterprises,Counter, Gauge, TimeTicks
         FROM RFC1155-SMI
      DisplayString
         FROM RFC1213-MIB
      OBJECT-TYPE
         FROM RFC-1212
      TRAP-TYPE
         FROM RFC-1215;

--  This MIB module uses the extended OBJECT-TYPE macro as
--  defined in [14];


upsman         OBJECT IDENTIFIER ::=  { enterprises 1356 }

ups            OBJECT IDENTIFIER ::=  { upsman 1 }
mgmt           OBJECT IDENTIFIER ::=  { upsman 2 }

upsIdent       OBJECT IDENTIFIER ::=  { ups 1 }
upsBattery     OBJECT IDENTIFIER ::=  { ups 2 }
upsInput       OBJECT IDENTIFIER ::=  { ups 3 }
upsOutput      OBJECT IDENTIFIER ::=  { ups 4 }
upsTest        OBJECT IDENTIFIER ::=  { ups 5 }
upsControl     OBJECT IDENTIFIER ::=  { ups 6 }
upsAlarms      OBJECT IDENTIFIER ::=  { ups 7 }
upsTempMan     OBJECT IDENTIFIER ::=  { ups 8 }

   NonNegativeInteger ::= TEXTUAL-CONVENTION
       DISPLAY-HINT "d"
       STATUS       current
       DESCRIPTION
               "This data type is a non-negative value."
       SYNTAX       INTEGER (0..2147483647)

--  
-- the ups group
-- the upsIdent group

upsIdentModelName OBJECT-TYPE
   SYNTAX DisplayString
   ACCESS read-only
   STATUS mandatory
   DESCRIPTION
      "The UPS model name (e.g. 'O1000S')."
   ::= { upsIdent 1 }

upsIdentUpsIDName OBJECT-TYPE
   SYNTAX DisplayString
   ACCESS read-write
   STATUS mandatory
   DESCRIPTION
      "An ID string identifying the UPS.  This object
       can be set by the administrator."
   ::= { upsIdent 2 }


-- the upsBattery group

upsBatteryStatus OBJECT-TYPE
   SYNTAX INTEGER  {
      unknown(1),
      batteryNormal(2),
      batteryLow(3)
   }
   ACCESS read-only
   STATUS mandatory
   DESCRIPTION
      "The status of the UPS batteries.  A batteryLow(3)
       value indicates the UPS will be unable to sustain the
       current load, and its services will be lost if power is
       not restored."
   ::= { upsBattery 1 }

upsBatteryCapacity OBJECT-TYPE
   SYNTAX INTEGER
   ACCESS read-only
   STATUS mandatory
   DESCRIPTION
      "The remaining battery capacity expressed in
       percent of full capacity."
   ::= { upsBattery 2 }

upsBatteryVoltage OBJECT-TYPE
   SYNTAX INTEGER
   ACCESS read-only
   STATUS mandatory
   DESCRIPTION
      "The current battery voltage expressed in VDC."
   ::= { upsBattery 3 }

upsBatteryTemperature OBJECT-TYPE
   SYNTAX INTEGER
   ACCESS read-only
   STATUS mandatory
   DESCRIPTION
      "The current internal UPS temperature expressed in
       Celsius."
   ::= { upsBattery 4 }

upsBatteryRunTimeRemaining OBJECT-TYPE
   SYNTAX INTEGER
   ACCESS read-only
   STATUS mandatory
   DESCRIPTION
      "The UPS battery run time remaining before battery
       exhaustion, in seconds."
   ::= { upsBattery 5 }

upsBatteryLifeTimeRemaining OBJECT-TYPE
   SYNTAX     NonNegativeInteger
   UNITS      "month"
   MAX-ACCESS read-only
   STATUS     current
   DESCRIPTION  
   
      "Forecast of the battery lifetime, replacement recommended in x month. Format: month"
   ::= { upsBattery 6 }


-- the upsInput group

upsInputLineVoltage OBJECT-TYPE
   SYNTAX INTEGER
   ACCESS read-only
   STATUS mandatory
   DESCRIPTION
      "The current utility line voltage in VAC."
   ::= { upsInput 1 }

upsInputLineFrequence OBJECT-TYPE
   SYNTAX INTEGER
   ACCESS read-only
   STATUS mandatory
   DESCRIPTION
      "The current utility line frequence in Hz."
   ::= { upsInput 2 }


-- the upsBasicOutput group


upsOutputStatus OBJECT-TYPE
   SYNTAX INTEGER  {
      unknown(1),
      onLine(2),
      onBattery(3),
      onBypass(4),
      shutdown(5)
   }
   ACCESS read-only
   STATUS mandatory
   DESCRIPTION
      "The current state of the UPS.  If the UPS is unable
       to determine the state of the UPS this variable is set
       to unknown(1)."
   ::= { upsOutput 1 }

upsOutputLoad OBJECT-TYPE
   SYNTAX INTEGER
   ACCESS read-only
   STATUS mandatory
   DESCRIPTION
      "The current UPS load expressed in percent
       of rated capacity."
   ::= { upsOutput 2 }

upsOutputFrequency OBJECT-TYPE
   SYNTAX     NonNegativeInteger
   UNITS      "Hertz"
   MAX-ACCESS read-only
   STATUS     current
   DESCRIPTION
   "The present output frequency, format: Hertz. Note: Several UPS models display this value in 0.1 Hertz."
   ::= { upsOutput 3 }

upsOutputVoltage OBJECT-TYPE
    SYNTAX     NonNegativeInteger
    UNITS      "RMS Volts"
    MAX-ACCESS read-only
    STATUS     current
    DESCRIPTION
      "The present output voltage, format: RMS Volts."
   ::= { upsOutput 4 }



-- the upsTest group

upsRunTest OBJECT-TYPE

   SYNTAX INTEGER  {
      noTest(0),
      batteryTest(1),
      batteryCustomTest(2),
      batteryFullTest(3),
      selfTest(4)
   }
   ACCESS read-write
   STATUS mandatory
   DESCRIPTION
      "Set this value to run a test. If this this variable is set
       to NoTest(0) no test will be initiated."
   ::= { upsTest 1 }

upsLastTestPerformed OBJECT-TYPE

   SYNTAX INTEGER  {
      noTest(0),
      batteryTest(1),
      batteryCustomTest(2),
      batteryFullTest(3),
      selfTest(4)
   }
   ACCESS read-only
   STATUS mandatory
   DESCRIPTION
      "This value shows which last test was performed. If this value is
       set to noTest(0) no test has been run since startup."
   ::= { upsTest 2 }

upsLastTestResult OBJECT-TYPE
   SYNTAX INTEGER  {
      undefined(0),
      success(1),
      failed(2),
      notSupported(3)
   }
   ACCESS read-only
   STATUS mandatory
   DESCRIPTION
      "The current UPS Test Result. If this value is undefined(0) no
       test has been run since startup."
   ::= { upsTest 3 }

upsLastTestedBackupTime OBJECT-TYPE
   SYNTAX INTEGER
   ACCESS read-only
   STATUS mandatory
   DESCRIPTION
      "This value shows the last tested backup time in minutes.
       To acquire a new value perform one of battery test's."
   ::= { upsTest 4 }

-- the upsControl group

upsRunShutdownRestore OBJECT-TYPE

   SYNTAX INTEGER  {
      undefined(0),
      shutdown(1),
      restore(2),
      shutdownRestore(3)
   }
   ACCESS read-write
   STATUS mandatory
   DESCRIPTION
      "Set this value to run a shutdown procedure. If this this variable is set
       to (0) nothing happens."
   ::= { upsControl 1 }

upsShutdownSecs OBJECT-TYPE
   SYNTAX INTEGER
   ACCESS read-write
   STATUS mandatory
   DESCRIPTION
      "This value indicates the time in seconds after which a ups
       shutdown will be performed. If this value is (0) shutdown
       executes immediately."
   ::= { upsControl 2 }

upsRestoreSecs OBJECT-TYPE
   SYNTAX INTEGER
   ACCESS read-write
   STATUS mandatory
   DESCRIPTION
      "This value indicates the time in seconds after which a ups
       restore will be performed. If this value is (0) restore
       executes immediately."
   ::= { upsControl 3 }


-- the upsAlarm group

upsAlarmFatalFaultStatus OBJECT-TYPE

   SYNTAX INTEGER  {
      fatalFaultNone(0),       
      fatalFaultOccurred(1)
   }
   MAX-ACCESS read-only
   STATUS current
   DESCRIPTION
      "CRITICAL ALARM : A fatal fault in the UPS has been detected. Detailed information by referring to UpsAlarmFatalFaultDetail
      Possible causes: Fatal Fault none (0), Fatal Fault occurred (1)."

   ::= { upsAlarms 1 } 


upsAlarmWarningStatus OBJECT-TYPE
       SYNTAX     INTEGER {
           none(0),
           occurred(1)
       }
       MAX-ACCESS read-only
       STATUS     current
       DESCRIPTION

    "WARNING : The UPS has detect a minor fault, warning level. Detailed information by referring to UpsAlarmWarningDetail."

  ::= { upsAlarms 2 }
 

upsAlarmInputBadStatus OBJECT-TYPE
       SYNTAX     INTEGER {
           none(0),
           occurred(1)
       }
       MAX-ACCESS read-only
       STATUS     current
       DESCRIPTION
      
      "An abnormal condition of the input in the UPS has been detected. Detailed information by referring to UpsAlarmInputBadDetail."
      
  ::= { upsAlarms 3 } 


upsAlarmOutputOverloadStatus OBJECT-TYPE
      SYNTAX     INTEGER {
           none(0),
           occurred(1)
       }
       MAX-ACCESS read-only
       STATUS     current
       DESCRIPTION
      
   "An abnormal output overload in the UPS has been detected."
      
  ::= { upsAlarms 4 } 

upsAlarmBatteryBadStatus OBJECT-TYPE
       SYNTAX     INTEGER {
           none(0),
           occurred(1)
       }
       MAX-ACCESS read-only
       STATUS     current
       DESCRIPTION
      
     "An abnormal condition of the battery in the UPS has been detected. Detailed information by referring to UpsAlarmBatteryBadDetail."
 
  ::= { upsAlarms 5 } 
 

upsAlarmTempBadStatus OBJECT-TYPE
       SYNTAX     INTEGER {
           none(0),
           occurred(1)
       }
       MAX-ACCESS read-only
       STATUS     current
       DESCRIPTION
      
    "An abnormal condition of the temperature in the UPS has been detected. Detailed information by referring to UpsAlarmTempBadDetail."

  ::= { upsAlarms 6 } 

-- the upsTempMan group

upsAlarmTempmanSensorValue1 OBJECT-TYPE
       SYNTAX INTEGER	
       MAX-ACCESS read-only
       STATUS     current
       DESCRIPTION
      
    "Tempman extension sensor 1 value expressed in 0.1 Degrees Celsius."

  ::= { upsTempMan 1 } 

upsAlarmTempmanSensorValue2 OBJECT-TYPE
       SYNTAX INTEGER	
       MAX-ACCESS read-only
       STATUS     current
       DESCRIPTION
      
    "Tempman extension sensor 2 value expressed in 0.1 Degrees Celsius."

  ::= { upsTempMan 2 } 

upsAlarmTempmanSensorValue3 OBJECT-TYPE
       SYNTAX INTEGER	
       MAX-ACCESS read-only
       STATUS     current
       DESCRIPTION
      
    "Tempman extension sensor 3 value expressed in 0.1 Degrees Celsius."

  ::= { upsTempMan 3 } 

upsAlarmTempmanSensorValue4 OBJECT-TYPE
       SYNTAX INTEGER	
       MAX-ACCESS read-only
       STATUS     current
       DESCRIPTION
      
    "Tempman extension sensor 4 value expressed in 0.1 Degrees Celsius."

  ::= { upsTempMan 4 } 

upsAlarmTempmanSensorStatus1 OBJECT-TYPE
       SYNTAX     INTEGER {
           unused(-1),
           failure(0),
           low(1),
           normal(2),
           high(3)
       }
       MAX-ACCESS read-only
       STATUS     current
       DESCRIPTION
      
    "Tempman extension sensor 1 status."

  ::= { upsTempMan 5 } 

upsAlarmTempmanSensorStatus2 OBJECT-TYPE
       SYNTAX     INTEGER {
           unused(-1),
           failure(0),
           low(1),
           normal(2),
           high(3)
       }
       MAX-ACCESS read-only
       STATUS     current
       DESCRIPTION
      
    "Tempman extension sensor 2 status."

  ::= { upsTempMan 6 } 

upsAlarmTempmanSensorStatus3 OBJECT-TYPE
       SYNTAX     INTEGER {
           unused(-1),
           failure(0),
           low(1),
           normal(2),
           high(3)
       }
       MAX-ACCESS read-only
       STATUS     current
       DESCRIPTION
      
    "Tempman extension sensor 3 status."

  ::= { upsTempMan 7 } 

upsAlarmTempmanSensorStatus4 OBJECT-TYPE
       SYNTAX     INTEGER {
           unused(-1),
           failure(0),
           low(1),
           normal(2),
           high(3)
       }
       MAX-ACCESS read-only
       STATUS     current
       DESCRIPTION
      
    "Tempman extension sensor 4 status."

  ::= { upsTempMan 8 } 


-- Here's a trap definition for the UPSMAN mib
-- Annotations are provided for Novell's NMS product

communicationLost TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
       "SEVERE: Communication to the UPS has been lost. Check cable or network
        connections, steps to reestablish communication are in progress."
   --#TYPE "UPS: Communication failure"
   --#SUMMARY "Communication with the UPS has been lost."
   --#ARGUMENTS { }
   --#SEVERITY CRITICAL
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE DEGRADED
   ::= 1

upsOverload TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "SEVERE: The UPS has sensed a load greater than 100 percent
       of its rated capcity."
   --#TYPE "UPS: UPS overload"
   --#SUMMARY "The UPS has sensed a load greater than 100 percent of its rated capacity."
   --#ARGUMENTS { }
   --#SEVERITY CRITICAL
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE DEGRADED
   ::= 2

upsTurnedOff TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "WARNING: The UPS has been turned 'off' by the management station."
   --#TYPE "UPS: Switching off"
   --#SUMMARY "The UPS is being switched off by a management station."
   --#ARGUMENTS { }
   --#SEVERITY MAJOR
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE NONOPERATIONAL
   ::= 3

communicationEstablished TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "INFORMATION: Communication with the UPS has been established."
   --#TYPE "UPS: Communication established"
   --#SUMMARY "Communication with the UPS has been established."
   --#ARGUMENTS { }
   --#SEVERITY INFORMATIONAL
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 4

powerRestored TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "INFORMATION: Utility power has been restored."
   --#TYPE "UPS: power restored"
   --#SUMMARY "Normal power has been restored to the UPS."
   --#ARGUMENTS { }
   --#SEVERITY INFORMATIONAL
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 5

upsOnBattery TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "WARNING: The UPS has switched to battery backup power."
   --#TYPE "UPS: On battery"
   --#SUMMARY "The UPS system has switched to battery backup power."
   --#ARGUMENTS { }
   --#SEVERITY MAJOR
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 6

testStarted TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "INFORMATION: A UPS test was started."
   --#TYPE "UPS: Test started"
   --#SUMMARY "UPS test has been started."
   --#ARGUMENTS { }
   --#SEVERITY INFORMATIONAL
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 7

testCompleted TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "INFORMATION: A UPS test is completed. Now a test result should be
       available in upsTest.lastTestResult."
   --#TYPE "UPS: Test completed"
   --#SUMMARY "UPS test has been completed."
   --#ARGUMENTS { }
   --#SEVERITY INFORMATIONAL
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 8

upsBatteryLow TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "WARNING: Battery Low."
   --#TYPE "UPS: Battery Low"
   --#SUMMARY "UPS Battery Low."
   --#ARGUMENTS { }
   --#SEVERITY MAJOR
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 9
   
upsShutdownImminent TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "INFORMATION: Server Shutdown imminent."
   --#TYPE "UPS: Shutdown Imminent"
   --#SUMMARY "UPS Shutdown Imminent."
   --#ARGUMENTS { }
   --#SEVERITY INFORMATIONAL
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 10

upsmanStarted TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "INFORMATION: The UpsMan service has been started."
   --#TYPE "UPS: UpsMan service started"
   --#SUMMARY "UpsMan service started."
   --#ARGUMENTS { }
   --#SEVERITY INFORMATIONAL
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 11


upsmanTrapInputBad TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "An abnormal condition of input UPS has been detected."
   --#TYPE "UPS: Abnormal input condition"
   --#SUMMARY "Abnormal input condition"
   --#ARGUMENTS { }
   --#SEVERITY MAJOR
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 12


upsmanTrapOutputOverloadRemoved TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "The UPS has returned from an overload situation to normal operation."
   --#TYPE "UPS: Overload Removed"
   --#SUMMARY "Overload Removed"
   --#ARGUMENTS { }
   --#SEVERITY INFORMATIONAL
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 13


upsmanTrapBatteryBad TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "An abnormal condition of the UPS batteries has been detected."
   --#TYPE "UPS: Bad battery"
   --#SUMMARY "Bad battery"
   --#ARGUMENTS { }
   --#SEVERITY MAJOR
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 14

upsmanTrapTempBad TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "An abnormal UPS temperature has been detected."
   --#TYPE "UPS: Bad temperature"
   --#SUMMARY "Bad temperature"
   --#ARGUMENTS { }
   --#SEVERITY MAJOR
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 15


upsmanTrapTempBadRemoved TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "The abnormal UPS temperature is back to normal level."
   --#TYPE "UPS: Bad temperatureRemove"
   --#SUMMARY "Bad temperatureRemove"
   --#ARGUMENTS { }
   --#SEVERITY INFORMATIONAL
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 16


upsmanTrapFatalFault TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "A fatal fault in the UPS has been detected. The UPS can not backup, contact your UPS
      service team."
   --#TYPE "UPS: Fatal fault"
   --#SUMMARY "Fatal fault"
   --#ARGUMENTS { }
   --#SEVERITY CRITICAL
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 17

upsmanTrapTempmanTempHigh1 TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "Tempman sensor 1 exceeds  upper limit."
   --#TYPE "Tempman: Temperature 1 high"
   --#SUMMARY "Temperature 1 high"
   --#ARGUMENTS { }
   --#SEVERITY MAJOR
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 18

upsmanTrapTempmanTempHigh2 TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "Tempman sensor 2 exceeds  upper limit."
   --#TYPE "Tempman: Temperature 2 high"
   --#SUMMARY "Temperature 2 high"
   --#ARGUMENTS { }
   --#SEVERITY MAJOR
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 19
   
upsmanTrapTempmanTempHigh3 TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "Tempman sensor 3 exceeds  upper limit."
   --#TYPE "Tempman: Temperature 3 high"
   --#SUMMARY "Temperature 3 high"
   --#ARGUMENTS { }
   --#SEVERITY MAJOR
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 20

upsmanTrapTempmanTempHigh4 TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "Tempman sensor 4 exceeds  upper limit."
   --#TYPE "Tempman: Temperature 4 high"
   --#SUMMARY "Temperature 4 high"
   --#ARGUMENTS { }
   --#SEVERITY MAJOR
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 21

upsmanTrapTempmanTempLow1 TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "Tempman sensor 1 below lower limit."
   --#TYPE "Tempman: Temperature 1 low"
   --#SUMMARY "Temperature 1 low"
   --#ARGUMENTS { }
   --#SEVERITY MAJOR
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 22

upsmanTrapTempmanTempLow2 TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "Tempman sensor 2 below lower limit."
   --#TYPE "Tempman: Temperature 2 low"
   --#SUMMARY "Temperature 2 low"
   --#ARGUMENTS { }
   --#SEVERITY MAJOR
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 23

upsmanTrapTempmanTempLow3 TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "Tempman sensor 3 below lower limit."
   --#TYPE "Tempman: Temperature 3 low"
   --#SUMMARY "Temperature 3 low"
   --#ARGUMENTS { }
   --#SEVERITY MAJOR
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 24

upsmanTrapTempmanTempLow4 TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "Tempman sensor 4 below lower limit."
   --#TYPE "Tempman: Temperature 4 low"
   --#SUMMARY "Temperature 4 low"
   --#ARGUMENTS { }
   --#SEVERITY MAJOR
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 25


upsmanTrapTempmanSensorFailure1 TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "Tempman sensor 1 failure."
   --#TYPE "Tempman: Sensor 1 failure"
   --#SUMMARY "Sensor 1 failure"
   --#ARGUMENTS { }
   --#SEVERITY MAJOR
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 26

upsmanTrapTempmanSensorFailure2 TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "Tempman sensor 2 failure."
   --#TYPE "Tempman: Sensor 2 failure"
   --#SUMMARY "Sensor 2 failure"
   --#ARGUMENTS { }
   --#SEVERITY MAJOR
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 27

upsmanTrapTempmanSensorFailure3 TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "Tempman sensor 3 failure."
   --#TYPE "Tempman: Sensor 3 failure"
   --#SUMMARY "Sensor 3 failure"
   --#ARGUMENTS { }
   --#SEVERITY MAJOR
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 28

upsmanTrapTempmanSensorFailure4 TRAP-TYPE
   ENTERPRISE upsman
   DESCRIPTION
      "Tempman sensor 4 failure."
   --#TYPE "Tempman: Sensor 4 failure"
   --#SUMMARY "Sensor 4 failure"
   --#ARGUMENTS { }
   --#SEVERITY MAJOR
   --#TIMEINDEX 1
   --#HELP ""
   --#HELPTAG 0
   --#STATE OPERATIONAL
   ::= 29



END

