if (!isServer) exitWith {};

_missionTag = [] call grad_persistence_fnc_getMissionTag;
_staticsTag = _missionTag + "_teamAccounts";
_teamAccountHash = [_staticsTag,true,0] call grad_persistence_fnc_getSaveData;

_date = [_teamAccountHash,"date"] call CBA_fnc_hashGet;
setDate _date;

_overcastData = [_teamAccountHash,"overcast"] call CBA_fnc_hashGet;
_rainData = [_teamAccountHash,"rain"] call CBA_fnc_hashGet;
_lightningsData = [_teamAccountHash,"lightnings"] call CBA_fnc_hashGet;
_fogData = [_teamAccountHash,"fog"] call CBA_fnc_hashGet;
_rainbowData = [_teamAccountHash,"rainbow"] call CBA_fnc_hashGet;
_windData = [_teamAccountHash,"wind"] call CBA_fnc_hashGet;
_wavesData = [_teamAccountHash,"waves"] call CBA_fnc_hashGet;

0 setOvercast _overcastData;
0 setRain _rainData;
0 setLightnings _lightningsData;
0 setFog _fogData;
0 setRainbow _rainbowData;
setWind _windData;
0 setWaves _wavesData;

missionNamespace setVariable ["grad_lbm_teamFunds_WEST",[_teamAccountHash,"WEST"] call CBA_fnc_hashGet, true];
missionNamespace setVariable ["grad_lbm_teamFunds_EAST",[_teamAccountHash,"EAST"] call CBA_fnc_hashGet, true];
missionNamespace setVariable ["grad_lbm_teamFunds_INDEPENDENT",[_teamAccountHash,"INDEPENDENT"] call CBA_fnc_hashGet, true];
missionNamespace setVariable ["grad_lbm_teamFunds_CIVILIAN",[_teamAccountHash,"CIVILIAN"] call CBA_fnc_hashGet, true];
