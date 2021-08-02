/* ----------------------------------------------------------------------------
Function: KISKA_fnc_compass_updateColors

Description:
    Updates the color of the ctrls for the KISKA compass

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
		call KISKA_fnc_compass_updateColors;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_compass_updateColors";

private _display = localNamespace getVariable ["KISKA_compass_display",displayNull];
if (isNull _display) exitWith {};

private _compassImageCtrl = _display getVariable ["KISKA_compass_imageCtrl",controlNull];
if !(isNull _compassImageCtrl) then {
    _compassImageCtrl ctrlSetTextColor KISKA_compass_mainColor;
};

private _compassBackgroundCtrl = _display getVariable ["KISKA_compass_backgroundCtrl",controlNull];
if !(isNull _compassBackgroundCtrl) then {
    _compassBackgroundCtrl ctrlSetTextColor KISKA_compass_backgroundColor;
};

private _compassCenterMarkersCtrl = _display getVariable ["KISKA_compass_centerMarkersCtrl",controlNull];
if !(isNull _compassCenterMarkersCtrl) then {
    _compassCenterMarkersCtrl ctrlSetTextColor KISKA_compass_centerColor;
};
