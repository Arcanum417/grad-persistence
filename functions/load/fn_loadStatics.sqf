if (!isServer) exitWith {};

_missionTag = [] call grad_persistence_fnc_getMissionTag;
_staticsTag = _missionTag + "_statics";
_staticsData = [_staticsTag] call grad_persistence_fnc_getSaveData;

{
    _thisStaticHash = _x;
    _type = [_thisStaticHash,"type"] call CBA_fnc_hashGet;
    _thisStatic = createVehicle [_type,[0,0,0],[],0,"CAN_COLLIDE"];

    [{!isNull (_this select 0)}, {
        params ["_thisStatic","_thisStaticHash"];

        _posASL = [_thisStaticHash,"posASL"] call CBA_fnc_hashGet;
        _vectorDirAndUp = [_thisStaticHash,"vectorDirAndUp"] call CBA_fnc_hashGet;
        _damage = [_thisStaticHash,"damage"] call CBA_fnc_hashGet;
        _isGradFort = [_thisStaticHash,"isGradFort"] call CBA_fnc_hashGet;

        _thisStatic setVectorDirAndUp _vectorDirAndUp;
        _thisStatic setPosASL _posASL;
        _thisStatic setDamage _damage;

        if (_isGradFort && {isClass (missionConfigFile >> "CfgFunctions" >> "GRAD_fortifications")}) then {
          _all_players = allPlayers - entities "HeadlessClient_F";
          _blufor_player = _all_players[0];

          {
            if (side _x == WEST) then {_blufor_player = _x};
          } forEach _all_players;

          _log_it = [_thisStatic,_blufor_player] remoteExec ["grad_fortifications_fnc_initFort",0,true];
          diag_log "Inicializacia FOrt";
          diag_log _blufor_player;
          diag_log _log_it;
          diag_log _thisStatic;
        };
        diag_log "Is FOrt ?";
        diag_log _isGradFort;

    }, [_thisStatic,_thisStaticHash]] call CBA_fnc_waitUntilAndExecute;

    false
} count _staticsData;
