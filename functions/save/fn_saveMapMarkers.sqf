if (!isServer) exitWith {};

_missionTag = [] call grad_persistence_fnc_getMissionTag;
_markersTag = _missionTag + "_markers";
_markersData = [_markersTag] call grad_persistence_fnc_getSaveData;
_markersData resize 0;

_allMarkers = allMapMarkers select { (_x != "fpsmarkerServer") && (_x != "respawn_civilian") };


{
    _thisMarkerHash = [] call CBA_fnc_hashCreate;

    [_thisMarkerHash,"name",_x] call CBA_fnc_hashSet;
    [_thisMarkerHash,"pos",getMarkerPos _x] call CBA_fnc_hashSet;
    [_thisMarkerHash,"color",getMarkerColor _x] call CBA_fnc_hashSet;
    [_thisMarkerHash,"icon",getMarkerType _x] call CBA_fnc_hashSet;
    [_thisMarkerHash,"text",markerText _x] call CBA_fnc_hashSet;
    [_thisMarkerHash,"dir",markerDir _x] call CBA_fnc_hashSet;

    _markersData pushBack _thisMarkerHash;

    false
} count _allMarkers;

saveProfileNamespace;
