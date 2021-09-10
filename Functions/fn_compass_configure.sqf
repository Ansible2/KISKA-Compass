
#include "..\Headers\Compass IDCs.hpp"
#include "..\Headers\gridMacros.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_compass_configure

Description:


Parameters:
	NONE

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


localNamespace setVariable ["KISKA_compass_display",_display];

private _mainCompassCtrlGroup = _display displayCtrl COMPASS_GRP;
_display setVariable ["KISKA_compass_mainCtrlGroup",_mainCompassCtrlGroup];

private _compassImageCtrl = _mainCompassCtrlGroup controlsGroupCtrl COMPASS_IMG;
_display setVariable ["KISKA_compass_imageCtrl",_compassImageCtrl];

private _compassBackgroundCtrl = _mainCompassCtrlGroup controlsGroupCtrl COMPASS_BACK;
_display setVariable ["KISKA_compass_backgroundCtrl",_compassBackgroundCtrl];

private _compassCenterMarkersCtrl = _mainCompassCtrlGroup controlsGroupCtrl COMPASS_CENTER;
_display setVariable ["KISKA_compass_centerMarkersCtrl",_compassCenterMarkersCtrl];



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
_display setVariable ["KISKA_compass_mainCtrlGroup_pos",_mainCtrlGrp_pos];

(ctrlPosition _compassCenterMarkersCtrl) params[ "", "_ctrlY", "_ctrlW", "" ];
_compassCenterMarkersCtrl ctrlSetPosition[ ( (_mainCtrlGrp_pos select 2) / 2 ) - ( _ctrlW / 2 ), _ctrlY  ];
_compassCenterMarkersCtrl ctrlCommit 0;


_display setVariable ["KISKA_compass_configed",true];
