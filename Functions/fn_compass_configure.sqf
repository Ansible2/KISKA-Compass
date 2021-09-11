#include "..\Headers\Compass IDCs.hpp"
#include "..\Headers\gridMacros.hpp"
#include "..\Headers\Compass Globals.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_compass_configure

Description:
	Initializes several display namespace variables for the compass and sets
	 up their images for the compass.

Parameters:
	0: _display <DISPLAY> - The display of the compass

Returns:
	NOTHING

Examples:
    (begin example)
		call KISKA_fnc_compass_configure;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_compass_configure";

disableSerialization;

params [
	["_display",displayNull]
];
if (isNull _display) exitWith {};


localNamespace setVariable [COMPASS_DISPLAY_VAR_STR,_display];

private _mainCompassCtrlGroup = _display displayCtrl COMPASS_GRP;
_display setVariable [COMPASS_MAIN_CTRL_GRP_VAR_STR,_mainCompassCtrlGroup];

private _compassImageCtrl = _mainCompassCtrlGroup controlsGroupCtrl COMPASS_IMG;
_display setVariable [COMPASS_IMAGE_CTRL_VAR_STR,_compassImageCtrl];

private _compassBackgroundCtrl = _mainCompassCtrlGroup controlsGroupCtrl COMPASS_BACK;
_display setVariable [COMPASS_BACKGROUND_CTRL_VAR_STR,_compassBackgroundCtrl];

private _compassCenterMarkersCtrl = _mainCompassCtrlGroup controlsGroupCtrl COMPASS_CENTER;
_display setVariable [COMPASS_CENTER_MARKERS_CTRL_VAR_STR,_compassCenterMarkersCtrl];



[
	[ _mainCompassCtrlGroup, [ true, true, true ] ],
	[ _compassImageCtrl, [ false, true, true ], KISKA_compass_mainColor, "images\compass_8.paa" ],
	[ _compassBackgroundCtrl, [ false, true, true ], KISKA_compass_backgroundColor, "#(rgb,8,8,3)color(1,1,1,1)" ],
	[ _compassCenterMarkersCtrl, [ false, true, true ], KISKA_compass_centerColor, "images\center.paa" ]
] apply {
	_x params [
		"_ctrl",
		"_changePos",
		[ "_color", [1,1,1,1] ],
		[ "_image", "" ]
	];

	_changePos params [
		"_effectX",
		"_effectW",
		"_effectH"
	];

	(ctrlPosition _ctrl) params[ "_ctrlX", "_ctrlY", "_ctrlW", "_ctrlH" ];

	if ( _effectW ) then {
		_ctrlW = _ctrlW * KISKA_compass_scale;
	};
	if ( _effectH ) then {
		_ctrlH = _ctrlH * KISKA_compass_scale;
	};
	if ( _effectX ) then {
		_ctrlX = ( safeZoneX + ( safeZoneW / 2 ) - ( _ctrlW / 2 ) );
	};

	_ctrl ctrlSetPosition[ _ctrlX, _ctrlY, _ctrlW, _ctrlH ];
	_ctrl ctrlCommit 0;

	if ( _image isNotEqualTo "" ) then {
		_ctrl ctrlSetText _image;
		_ctrl ctrlSetTextColor _color;
	};

};

private _mainCtrlGrp_pos = ctrlPosition _mainCompassCtrlGroup;
_display setVariable [COMPASS_MAIN_CTRL_GRP_POS_VAR_STR,_mainCtrlGrp_pos];

(ctrlPosition _compassCenterMarkersCtrl) params[ "", "_ctrlY", "_ctrlW", "" ];
_compassCenterMarkersCtrl ctrlSetPosition[ ( (_mainCtrlGrp_pos select 2) / 2 ) - ( _ctrlW / 2 ), _ctrlY  ];
_compassCenterMarkersCtrl ctrlCommit 0;


_display setVariable [COMPASS_CONFIGED_VAR_STR,true];
