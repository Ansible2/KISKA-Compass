#include "..\Headers\Compass IDCs.hpp"
#include "..\Headers\Icon Info Indexes.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_compass_mainLoop

Description:
	Acts as the onDraw event for the compass, so this executes each frame.

Parameters:
	0: _compassMapCtrl <CONTROL> - The ctrl for the compass map

Returns:
	NOTHING

Examples:
    (begin example)
		[_compassMapCtrl] call KISKA_fnc_compass_mainLoop;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_compass_mainLoop";

#define INACTIVE_IDC -1
#define SIMPLIFY_ANGLE(angle) (((angle) % 360) + 360) % 360;

disableSerialization;

params [
	["_compassMapCtrl",controlNull,[controlNull]]
];

if ( KISKA_compass_show ) then {
	if !( localNamespace getVariable ["KISKA_compass_configed",false] ) then {
		[ _compassMapCtrl ] call KISKA_fnc_compass_configure;
	};

	private _ctrlGrp = localNamespace getVariable "KISKA_compass_mainCtrlGroup";
	private _display = localNamespace getVariable "KISKA_compass_display";
	private _compass = localNamespace getVariable "KISKA_compass_imageCtrl";

/*
	private _cameraPos = (getPosWorldVisual player) vectorAdd (getCameraViewDirection player);
	private _dirTo = (getPosWorldVisual player) getDir _cameraPos;
	private _posX = linearConversion[ 0, 360, _dirTo, 1536 * KISKA_compass_scale, 3072 * KISKA_compass_scale, true ];
*/


	private _cameraVectorDir = getCameraViewDirection player;
	private _cameraHeading = SIMPLIFY_ANGLE((_cameraVectorDir select 0) atan2 (_cameraVectorDir select 1));
	private _posX = linearConversion[ 0, 360, _cameraHeading, 1536 * KISKA_compass_scale, 3072 * KISKA_compass_scale, true ];

	_compass ctrlSetPositionX -( _posX * pixelW );
	_compass ctrlCommit 0;


	// draw icons
	private _iconMap = localNamespace getVariable ["KISKA_compass_iconHashMap",[]];
	if (count _iconMap > 0) then {
		private _ctrlPos = localNamespace getVariable "KISKA_compass_mainCtrlGroup_pos";
		private _grpW = _ctrlPos select 2;
		private _grpWDivided = _grpW / 2;

		private ["_iconWidth","_iconHeight","_iconControl","_iconColor","_iconText","_iconPos","_iconWidthDivided","_camDirTo","_opposite"];

		_iconMap apply {

			_iconPos = _y select ICON_POS;
			call {
				if (_iconPos isEqualType []) exitWith {
					_camDirTo = SIMPLIFY_ANGLE(_cameraHeading - (player getDir _iconPos));
				};

				if (_iconPos isEqualType objNull AND {!( isNull _iconPos )}) exitWith {
					_camDirTo = SIMPLIFY_ANGLE(_cameraHeading - (player getDir _iconPos));
				};

				if (_iconPos isEqualType locationNull AND {!( isNull _iconPos )}) exitWith {
					private _locationPos = locationPosition _iconPos;
					_camDirTo = SIMPLIFY_ANGLE(_cameraHeading - (player getDir _locationPos));
				};

				if (_iconPos isEqualType "") exitWith {
					private _markerPos = getMarkerPos _iconPos;
					if ( _markerPos isNotEqualTo [0,0,0] ) then {
						_camDirTo = SIMPLIFY_ANGLE(_cameraHeading - (player getDir _markerPos));
					};
				};

				_camDirTo = nil;
			};


			// only update if actually visible on compass range
			if (
				!(isNil "_camDirTo") AND
				{
					(_camDirTo >= 270) OR
					{_camDirTo <= 90}
				}
			) then {
				private _iconActive = _y select ICON_ACTIVE;
				_iconWidth = [KISKA_compass_iconWidth_inactive,KISKA_compass_iconWidth_active] select _iconActive;
				_iconWidthDivided = _iconWidth / 2;


				_iconControl = _y select ICON_CTRL;
				_iconText = _y select ICON_TEXT; // this is the icon's picture path
				_iconColor = _y select ICON_COLOR;

				if (isNull _iconControl) then {
					_iconControl = _display ctrlCreate [ "ctrlActivePicture", INACTIVE_IDC, _ctrlGrp ];

					_iconHeight = [KISKA_compass_iconHeight_inactive,KISKA_compass_iconHeight_active] select _iconActive;
					private _grpH = _ctrlPos select 3;
					_iconControl ctrlSetPosition [_grpWDivided - _iconWidthDivided, _grpH - _iconHeight, _iconWidth, _iconHeight];

					_iconControl ctrlSetText _iconText;
					_iconControl ctrlSetTextColor _iconColor;

					_iconControl ctrlCommit 0;
					_y set [ ICON_CTRL, _iconControl ];

				} else {
					if ( (ctrlText _iconControl) isNotEqualTo _iconText) then {
						_iconControl ctrlSetText _iconText;
					};

					if ( (ctrlTextColor _iconControl) isNotEqualTo _iconColor) then {
						_iconControl ctrlSetTextColor _iconColor;
					};

					// get the opposite angle
					_opposite = SIMPLIFY_ANGLE(-_camDirTo + 180);
					_posX = linearConversion[ 90, 270, _opposite, 0, _grpW ];
					//hintSilent ([_camDirTo,_opposite,_posX] joinString "\n");
					_iconControl ctrlSetPositionX (_posX - _iconWidthDivided);
					_iconControl ctrlCommit 0;
				};
			};

		};

	};
};