/* ----------------------------------------------------------------------------
Function: KISKA_fnc_compass_updateConstants

Description:
    Updates a number of constant global variables used for the KISKA compass.

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
		call KISKA_fnc_compass_updateConstants;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_compass_updateConstants";


missionNamespace setVariable ["KISKA_compass_iconW",KISKA_compass_iconPixelSize * pixelW * KISKA_compass_scale];
missionNamespace setVariable ["KISKA_compass_iconH",KISKA_compass_iconPixelSize * pixelH * KISKA_compass_scale];

missionNamespace setVariable ["KISKA_compass_iconWidth_active",KISKA_compass_iconW * KISKA_compass_activeIconMultiplier];
missionNamespace setVariable ["KISKA_compass_iconHeight_active",KISKA_compass_iconH * KISKA_compass_activeIconMultiplier];

missionNamespace setVariable ["KISKA_compass_iconWidth_inactive",KISKA_compass_iconW * KISKA_compass_inactiveIconMultiplier];
missionNamespace setVariable ["KISKA_compass_iconHeight_inactive",KISKA_compass_iconH * KISKA_compass_inactiveIconMultiplier];
