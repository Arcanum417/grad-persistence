if (!isServer) exitWith {};

_missionTag = [] call grad_persistence_fnc_getMissionTag;
_staticsTag = _missionTag + "_teamAccounts";
_teamAccountHash = [_staticsTag,true,0] call grad_persistence_fnc_getSaveData;

[_teamAccountHash,"date",date] call CBA_fnc_hashSet;

[_teamAccountHash,"overcast",overcast] call CBA_fnc_hashSet;
[_teamAccountHash,"rain",rain] call CBA_fnc_hashSet;
[_teamAccountHash,"lightnings",lightnings] call CBA_fnc_hashSet;
[_teamAccountHash,"fog",fog] call CBA_fnc_hashSet;
[_teamAccountHash,"rainbow",rainbow] call CBA_fnc_hashSet;
[_teamAccountHash,"wind",wind] call CBA_fnc_hashSet;
[_teamAccountHash,"waves",waves] call CBA_fnc_hashSet;

[_teamAccountHash,"WEST",(missionNamespace getVariable ["grad_lbm_teamFunds_WEST",0])] call CBA_fnc_hashSet;
[_teamAccountHash,"EAST",(missionNamespace getVariable ["grad_lbm_teamFunds_EAST",0])] call CBA_fnc_hashSet;
[_teamAccountHash,"INDEPENDENT",(missionNamespace getVariable ["grad_lbm_teamFunds_INDEPENDENT",0])] call CBA_fnc_hashSet;
[_teamAccountHash,"CIVILIAN",(missionNamespace getVariable ["grad_lbm_teamFunds_CIVILIAN",0])] call CBA_fnc_hashSet;

_allTaskData = [];
if (!isNil allTasks) then {
    {
        _texts = _x call BIS_fnc_taskDescription;
        _destination = getPos (_x call BIS_fnc_taskDestination select 0);
        _state =  _x call BIS_fnc_taskState;
        _allTaskData pushBack [_texts,_destination,_state];

    } forEach allTasks;
    [_teamAccountHash,"allTaskData",_allTaskData] call CBA_fnc_hashSet;
};

saveProfileNamespace;
