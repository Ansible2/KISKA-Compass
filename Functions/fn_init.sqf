
params[ "_init" ];

if ( _init == "postInit" ) exitWith {
	if ( hasInterface ) then {
		[ "INIT" ] spawn ( missionNamespace getVariable _fnc_scriptName );
	};
};

waitUntil{ !isNull findDisplay 46 };

LARs_compass_icons = [];
KISKA_compass_show = true;
LARs_compass_iconColor = [ getArray( missionConfigFile >> "KISKA_compass_uiLayer_settings" >> "iconColor" ) ] param[ 0, [0,1,0,1], [ [] ], [ 4 ] ];

"KISKA_compass_uiLayer" call BIS_fnc_rscLayer cutRsc [ "KISKA_compass_uiLayer", "PLAIN", -1, false ];

{
	_icon = _x getVariable "LARs_compass_icon";
	if ( !isNil "_icon" ) then {
		_iconIndex = [ "ADD", [ _icon, _x ] ] call LARs_compass_fnc_icon;
		_x setVariable[ "LARs_compass_iconIndex", _iconIndex ];
	};
}forEach ( allMissionObjects "" );
