if (!isServer) exitWith {};

_missionTag = [] call grad_persistence_fnc_getMissionTag;
_vehiclesTag = _missionTag + "_vehicles";
_vehiclesData = [_vehiclesTag] call grad_persistence_fnc_getSaveData;

{

    _thisVehicleHash = _x;
    _type = [_thisVehicleHash,"type"] call CBA_fnc_hashGet;
    _side = [_thisVehicleHash,"side"] call CBA_fnc_hashGet;
    _hasCrew = [_thisVehicleHash,"hasCrew"] call CBA_fnc_hashGet;

    //idk, weird shit happens when you use createVehicle and add crew
    _thisVehicle = if (!_hasCrew) then {
        createVehicle [_type, [0,0,0], [], 0, "CAN_COLLIDE"]
    } else {
        ([[0,0,0],0,_type,_side] call BIS_fnc_spawnVehicle) select 0
    };

    [{!isNull (_this select 0)}, {
        params ["_thisVehicle","_thisVehicleHash"];

        _posASL = [_thisVehicleHash,"posASL"] call CBA_fnc_hashGet;
        _vectorDirAndUp = [_thisVehicleHash,"vectorDirAndUp"] call CBA_fnc_hashGet;
        _hitPointDamage = [_thisVehicleHash,"hitpointDamage"] call CBA_fnc_hashGet;
        _turretMagazines = [_thisVehicleHash,"turretMagazines"] call CBA_fnc_hashGet;
        _inventory = [_thisVehicleHash,"inventory"] call CBA_fnc_hashGet;
        _isGradFort = [_thisVehicleHash,"isGradFort"] call CBA_fnc_hashGet;
        _invGradFort = [_thisVehicleHash,"invGradFort"] call CBA_fnc_hashGet;
        _fuel = [_thisVehicleHash,"fuel"] call CBA_fnc_hashGet;
        _fuelCargo = [_thisVehicleHash,"fuelCargo"] call CBA_fnc_hashGet;
        _ammoCargo = [_thisVehicleHash,"ammoCargo"] call CBA_fnc_hashGet;

        _thisVehicle setVariable ["grad_fortifications_myFortsHash",_invGradFort,true];
        [_thisVehicle,_invGradFort] remoteExec ["grad_fortifications_fnc_updateItemList",0,false];

        _thisVehicle setVectorDirAndUp _vectorDirAndUp;
        _thisVehicle setPosASL _posASL;
        _thisVehicle setFuel _fuel;
        [_thisVehicle, _fuelCargo] call ace_refuel_fnc_setFuel;
        [_thisVehicle, _ammoCargo] call ace_rearm_fnc_setSupplyCount;

        [_thisVehicle,_turretMagazines] call grad_persistence_fnc_loadTurretMagazines;
        [_thisVehicle,_hitPointDamage] call grad_persistence_fnc_loadVehicleHits;
        [_thisVehicle,_inventory] call grad_persistence_fnc_loadVehicleInventory;

        if (_isGradFort && {isClass (missionConfigFile >> "CfgFunctions" >> "GRAD_fortifications")}) then {
            [_thisVehicle,WEST] remoteExec ["grad_fortifications_fnc_initFort",0,true];
        };

    }, [_thisVehicle,_thisVehicleHash]] call CBA_fnc_waitUntilAndExecute;

    false
} count _vehiclesData;
