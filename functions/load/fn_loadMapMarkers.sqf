if (!isServer) exitWith {};

_missionTag = [] call grad_persistence_fnc_getMissionTag;
_markersTag = _missionTag + "_markers";
_markersData = [_markersTag] call grad_persistence_fnc_getSaveData;

{

    _thisMarkerHash = _x;
    _name = [_thisMarkerHash,"name"] call CBA_fnc_hashGet;
    _pos = [_thisMarkerHash,"pos"] call CBA_fnc_hashGet;
    _color = [_thisMarkerHash,"color"] call CBA_fnc_hashGet;
    _icon = [_thisMarkerHash,"icon"] call CBA_fnc_hashGet;
    _text = [_thisMarkerHash,"text"] call CBA_fnc_hashGet;
    _dir = [_thisMarkerHash,"dir"] call CBA_fnc_hashGet;

    if (_name select [ 0, 13 ] != "_USER_DEFINED") then {
								_mrk = createMarker [ format[ "%1%2_%3", "_USER_DEFINED ", _name, floor (random(4520)) ], _pos ];
							}
							else {
								_mrk = createMarker [ format[ "%1_%2", _name, floor (random(4520)) ], _pos ];
    };
    _mrk setMarkerType _icon;
		_mrk setMarkerColor _color;
		_mrk setMarkerText _text;
		_mrk setMarkerDir _dir;

    false
} count _markersData;
