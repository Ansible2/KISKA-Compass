[
    "KISKA_compass_show",
    "CHECKBOX",
    "Show Compass",
    "KISKA Compass",
    true,
    nil,
    {
        params ["_show"];

        localNamespace setVariable ["KISKA_compass_configed",false];
        if ( _show ) then {
            //KISKA_compass_configed = nil;
            ("KISKA_compass_uiLayer" call BIS_fnc_rscLayer) cutRsc [ "KISKA_compass_uiLayer", "PLAIN", -1, false ];
            KISKA_compass_show = true;

        } else {
            //localNamespace setVariable ["KISKA_compass_configed",false];
            ("KISKA_compass_uiLayer" call BIS_fnc_rscLayer) cutText [ "", "PLAIN", -1, false ];
            KISKA_compass_show = false;

        };
    }
] call CBA_fnc_addSetting;




[
    "KISKA_compass_scale",
    "SLIDER",
    "Compass Scale",
    ["KISKA Compass", "Scaling"],
    [0.01, 3, 0.4, 2],
    nil,
    {
        call KISKA_fnc_compass_updateConstants;
    }
] call CBA_fnc_addSetting;
[
    "KISKA_compass_iconPixelSize",
    "SLIDER",
    "Icon Size",
    ["KISKA Compass", "Scaling"],
    [10, 50, 25, 0],
    nil,
    {
        call KISKA_fnc_compass_updateConstants;
    }
] call CBA_fnc_addSetting;
[
    "KISKA_compass_activeIconMultiplier",
    "SLIDER",
    "Active Icon Size Multiplier",
    ["KISKA Compass", "Scaling"],
    [1, 2, 1.5, 2],
    nil,
    {
        call KISKA_fnc_compass_updateConstants;
    }
] call CBA_fnc_addSetting;
[
    "KISKA_compass_inactiveIconMultiplier",
    "SLIDER",
    "Inactive Icon Size Multiplier",
    ["KISKA Compass", "Scaling"],
    [1, 2, 1, 2],
    nil,
    {
        call KISKA_fnc_compass_updateColors;
    }
] call CBA_fnc_addSetting;





[
    "KISKA_compass_mainColor",
    "COLOR",
    "Main Compass Color",
    ["KISKA Compass","Colors"],
    [1,1,1,1],
    nil,
    {
        call KISKA_fnc_compass_updateColors;
    }
] call CBA_fnc_addSetting;
[
    "KISKA_compass_centerColor",
    "COLOR",
    "Center Markers Color",
    ["KISKA Compass","Colors"],
    [0,1,0,1],
    nil,
    {
        call KISKA_fnc_compass_updateColors;
    }
] call CBA_fnc_addSetting;
[
    "KISKA_compass_backgroundColor",
    "COLOR",
    "Background Color",
    ["KISKA Compass","Colors"],
    [0,0,0,0], // transparent
    nil,
    {
        call KISKA_fnc_compass_updateColors;
    }
] call CBA_fnc_addSetting;
