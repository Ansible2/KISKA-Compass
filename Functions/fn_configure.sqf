
#include "..\Headers\Compass IDCs.sqc"
#include "..\Headers\gridMacros.sqc"

disableSerialization;

params[ "_mapControl" ];

private _mainCompassCtrlGroup = ctrlParentControlsGroup _mapControl;
localNamespace setVariable ["KISKA_compass_mainCtrlGroup",_mainCompassCtrlGroup];

{
	_x params[ "_ctrl", "_changePos", [ "_color", [1,1,1,1] ], [ "_image", "" ] ];
	_changePos params[ "_effectX", "_effectY", "_effectW", "_effectH" ];

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
	if ( _effectY ) then {
		if ( _bottom ) then {
			_ctrlY = safeZoneY + safeZoneH - VERTICAL_GUTTER - _ctrlH;
		};
	};

	_ctrl ctrlSetPosition[ _ctrlX, _ctrlY, _ctrlW, _ctrlH ];
	_ctrl ctrlCommit 0;

	if !( _image isEqualTo "" ) then {
		_ctrl ctrlSetText _image;
		_ctrl ctrlSetTextColor _color;
	};

}forEach [
	[ ctrlParentControlsGroup _mapControl, [ true, true, true, true ] ],
	[ ctrlParentControlsGroup _mapControl controlsGroupCtrl COMPASS_IMG, [ false, false, true, true ], KISKA_compass_mainColor, "images\compass.paa" ],
	[ ctrlParentControlsGroup _mapControl controlsGroupCtrl COMPASS_BACK, [ false, false, true, true ], KISKA_compass_backgroundColor, "#(rgb,8,8,3)color(1,1,1,1)" ],
	[ ctrlParentControlsGroup _mapControl controlsGroupCtrl COMPASS_CENTER, [ false, false, true, true ], KISKA_compass_centerColor, "images\center.paa" ]
];

_ctrl = ctrlParentControlsGroup _mapControl controlsGroupCtrl COMPASS_CENTER;
ctrlPosition _ctrl params[ "", "_ctrlY", "_ctrlW", "" ];
_ctrlGrp = ctrlParentControlsGroup _mapControl;
ctrlPosition _ctrlGrp params[ "", "", "_ctrlGrpW" ];

_ctrl ctrlSetPosition[ ( _ctrlGrpW / 2 ) - ( _ctrlW / 2 ), _ctrlY  ];
_ctrl ctrlCommit 0;


localNamespace setVariable ["KISKA_compass_configed",true];
