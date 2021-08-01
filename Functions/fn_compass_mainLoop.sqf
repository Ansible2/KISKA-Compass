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

	//hint "draw";
	private _cameraPos = (getPosWorldVisual player) vectorAdd (getCameraViewDirection player);
	private _dirTo = (getPosWorldVisual player) getDir _cameraPos;
	private _posX = linearConversion[ 0, 360, _dirTo, 1536 * KISKA_compass_scale, 3072 * KISKA_compass_scale, true ];

	(ctrlPosition _compass) params[ "_ctrlX", "_ctrlY" ];
	_compass ctrlSetPosition[ -( _posX * pixelW ), _ctrlY ];
	_compass ctrlCommit 0;


	// draw icons
	if (count (localNamespace getVariable ["KISKA_compass_iconHashMap",createHashMap]) > 0) then {
		//_iconW = KISKA_compass_iconW;
		//_iconH = KISKA_compass_iconH;
		(ctrlPosition _ctrlGrp) params[ "", "", "_grpW", "_grpH" ];

		private ["_iconWidth","_iconHeight","_iconControl","_iconColor","_iconText","_relativeDir","_iconPos"];
		private _grpWDivided = _grpW / 2;
		private _iconWidthDivided = _iconWidth / 2;

		KISKA_compass_iconHashMap apply {

			_iconPos = _y select ICON_POS;
			_relativeDir = call {
				if (_iconPos isEqualType []) exitWith {
					player getRelDir _iconPos
				};

				if (_iconPos isEqualType objNull AND {!( isNull _iconPos )}) exitWith {
					player getRelDir _iconPos
				};

				if (_iconPos isEqualType locationNull AND {!( isNull _iconPos )}) exitWith {
					player getRelDir (locationPosition _iconPos)
				};

				if (_iconPos isEqualType "") exitWith {
					private _markerPos = getMarkerPos _iconPos;
					if ( _markerPos isNotEqualTo [0,0,0] ) then {
						player getRelDir _markerPos
					};
				};

				-1
			};

			// only update if actually visible on compass range
			if (
				_relativeDir isNotEqualTo -1 AND
				{
					((360 - _relativeDir) > 300) OR
					{(0 + _relativeDir) < 60}
				}
			) then {

				_iconWidth = [KISKA_compass_iconWidth_inactive,KISKA_compass_iconWidth_active] select ICON_ACTIVE;
				_iconHeight = [KISKA_compass_iconHeight_inactive,KISKA_compass_iconHeight_active] select ICON_ACTIVE;

				_iconControl = _y select ICON_CTRL;
				_iconText = _y select ICON_TEXT; // this is the icon's picture path
				_iconColor = _y select ICON_COLOR;

				if (isNull _iconControl) then {
					_iconControl = _display ctrlCreate [ "ctrlActivePicture", INACTIVE_IDC, _ctrlGrp ];
					_iconControl ctrlSetPosition [_grpWDivided - ( _iconWidth / 2 ), _grpH - _iconHeight, _iconWidth, _iconHeight];

					_iconControl ctrlSetText _iconText;
					_iconControl ctrlSetTextColor _iconColor;

					_iconControl ctrlCommit 0;
					_y set [ ICON_CTRL, _iconControl ];

				} else {
					if ( (ctrlText _iconControl) isNotEqualTo _iconText) then {
						_ctrl ctrlSetText _iconText;
					};

					if ( (ctrlTextColor _iconControl) isNotEqualTo _iconColor) then {
						_ctrl ctrlSetText _iconText;
					};
				};

				_relativeDir = (( _relativeDir + 180 ) % 360 );
				_posX = linearConversion[ 90, 270, _relativeDir, 0, _grpW ];
				//ctrlPosition _ctrl params[ "_ctrlX", "_ctrlY" ];
				_iconControl ctrlSetPosition[ _posX - _iconWidthDivided, _grpH - _iconHeight, _iconWidth, _iconHeight ];
				_iconControl ctrlCommit 0;
			};

		};

	};
/*
	{
		if ( _x isEqualType [] ) then {
			_x params [
				"_icon",
				"_pos",
				"_iconColor",
				[ "_ctrl", controlNull ],
				[ "_active", false ],
				[ "_flashData", [] ]
			];

			_flashData params [
				[ "_colorTo", [] ],
				[ "_duration", 0 ],
				[ "_pingPong", 0 ]
			];

			_iconWidth = _iconW * ( [ 1, KISKA_compass_activeIconMultiplier ] select _active );
			_iconHeight = _iconH * ( [ 1, KISKA_compass_activeIconMultiplier ] select _active );

			if ( isNull _ctrl ) then {
				_ctrl = _display ctrlCreate [ "ctrlActivePicture", COMPASS_ICONS + _forEachIndex, _ctrlGrp ];
				_ctrl ctrlSetPosition[ 0 + ( _grpW / 2 ) - ( _iconWidth / 2 ), _grpH - _iconHeight, _iconWidth, _iconHeight ];
				_ctrl ctrlSetText _icon;
				_ctrl ctrlSetTextColor _iconColor;
				_ctrl ctrlCommit 0;
				LARs_compass_icons select _forEachIndex set[ 3, _ctrl ];
			};

			if ( ctrlText _ctrl != _icon ) then {
				_ctrl ctrlSetText _icon;
			};

			if !( _colorTo isEqualTo [] || _duration <= 0 ) then {
				_time = time % ( [ _duration, _duration * 2 ] select _pingPong );

				_newColor = if ( _time <= _duration ) then {
					_color = vectorLinearConversion[ 0, _duration, _time, _iconColor select[ 0, 3 ], _colorTo select[ 0, 3 ], true ];
					_alpha = linearConversion[ 0, _duration, _time, _iconColor select 3, _colorTo select 3, true ];
					_color + [ _alpha ];
				}else{
					_color = vectorLinearConversion[ _duration, _duration * 2, _time, _colorTo select[ 0, 3 ], _iconColor select[ 0, 3 ], true ];
					_alpha = linearConversion[ _duration, _duration * 2, _time, _colorTo select 3, _iconColor select 3, true ];
					_color + [ _alpha ];
				};

				_ctrl ctrlSetTextColor _newColor;
			};

			_posDir = switch ( true ) do {
				case ( _pos isEqualType [] ) : {
					player getRelDir _pos
				};
				case ( _pos isEqualType objNull ) : {
					if !( isNull _pos ) then {
						player getRelDir getPosATLVisual _pos
					};
				};
				case ( _pos isEqualType locationNull ) : {
					if !( isNull _pos ) then {
						player getRelDir locationPosition _pos
					};
				};
				case ( _pos isEqualType "" ) : {
					if !( getMarkerPos _pos isEqualTo [0,0,0] ) then {
						player getRelDir getMarkerPos _pos
					};
				};
			};

			if !( isNil "_posDir" || isNull _ctrl ) then {
				_posDir = (( _posDir +180 ) % 360 );
				_posX = linearConversion[ 90, 270, _posDir, 0, _grpW ];
				//ctrlPosition _ctrl params[ "_ctrlX", "_ctrlY" ];
				_ctrl ctrlSetPosition[ _posX - ( _iconWidth / 2 ), _grpH - _iconHeight, _iconWidth, _iconHeight ];
				_ctrl ctrlCommit 0;
			}else{
				if !( isNull _ctrl ) then {
					ctrlDelete _ctrl;
				};
				LARs_compass_icons set[ _forEachIndex, objNull ];
			};
		};
	}forEach LARs_compass_icons;
*/
};

//Clear any deleted compass icons
//LARs_compass_icons = LARs_compass_icons - [ objNull ];
