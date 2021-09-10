/* ----------------------------------------------------------------------------
Function: KISKA_fnc_compass_mainLoop

Description:
	Resets the config global of the compass and then restarts the cutRSC for it.

Parameters:
	NONE

Returns:
	<BOOL> - true if compass restarted

Examples:
    (begin example)
		call KISKA_fnc_compass_mainLoop;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_compass_refresh";


private _display = localNamespace getVariable ["KISKA_compass_display",displayNull];
if (isNull _display) exitWith {
    ["The display is null",true] call KISKA_fnc_log;
    false;
};


if (_display getVariable ["KISKA_compass_configed",false]) then {
    _display setVariable ["KISKA_compass_configed",false];
    ("KISKA_compass_uiLayer" call BIS_fnc_rscLayer) cutText [ "", "PLAIN", -1, false ];
    ("KISKA_compass_uiLayer" call BIS_fnc_rscLayer) cutRsc [ "KISKA_compass_uiLayer", "PLAIN", -1, false ];
    true

} else {
    ["KISKA Compass has already been stopped",true] call KISKA_fnc_log;
    false

};
