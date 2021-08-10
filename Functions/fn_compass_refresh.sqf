private _display = localNamespace getVariable ["KISKA_compass_display",displayNull];
if (isNull _display) exitWith {
    false;
};

if (_display getVariable ["KISKA_compass_configed",false]) then {
    _display setVariable ["KISKA_compass_configed",false];
    ("KISKA_compass_uiLayer" call BIS_fnc_rscLayer) cutText [ "", "PLAIN", -1, false ];
    ("KISKA_compass_uiLayer" call BIS_fnc_rscLayer) cutRsc [ "KISKA_compass_uiLayer", "PLAIN", -1, false ];
    true
    
} else {
    false

};
