enableSaving [false, false];
enableSentences false;
sleep 1;
gameonscript = [startB, startO, leadB, leadO, [ofheli, bftruck1, bftruck2]] execVM "gameon.sqf";


if (side player == west) then {
	Alpha addGroupIcon ["b_inf",[0,0]];
	Alpha setGroupIconParams [[0,.25,1,1],"A",1,true];
	Bravo addGroupIcon ["b_inf",[0,0]];
	Bravo setGroupIconParams [[0,.25,1,1],"B",1,true];
	Lead addGroupIcon ["b_inf",[0,0]];
	Lead setGroupIconParams [[0,.25,1,1],"SL",1,true];
	setGroupIconsVisible [true,false];
	
	player addItem "AGM_CableTie";
	player addItem "AGM_CableTie";

	/*{
		_x addAction [
			"Take Captive",
			{
				(_this select 0) setCaptive true;
				(_this select 0) forceWalk true;
				systemChat format["You have taken %1 captive.", (name (_this select 0))];
				removeallactions (_this select 0);
			},
			nil,
			0,
			false,
			true,
			"",
			"(_target distance _this) < 2"
		]; // "GroundWeaponHolder" createVehicle getpos(_this select 0)

	} foreach [fug1,fug2,fug3];*/
};

if (side player == east) then {
	Pilot addGroupIcon ["b_air",[0,0]];
	Pilot setGroupIconParams [[0,.25,1,1],"Rook",1,true];
	Ground addGroupIcon ["b_recon",[0,0]];
	Ground setGroupIconParams [[0,.25,1,1],"Knight",1,true];
	setGroupIconsVisible [true,false];
};

if (side player == independent) then {

};

if (true) then {

	waituntil{scriptDone gameonscript};
	{_x setMarkerAlpha .2} foreach ["marker_fug1", "marker_fug2", "marker_fug3"];

	[] spawn {
		_cutterarray = [];
		{
			if (typeOf _x == "ClutterCutter_EP1") then {
			_cutterarray = _cutterarray + [_x];
			};
		}foreach list trig1;

		_crashpos = getpos (_cutterarray select random count _cutterarray);
		helis setpos _crashpos;
		helis setdir random 360;
		helis setDamage 1;

		{
			_safe = false;
			while {!_safe} do {
				_startPos = [_crashpos, 50, 75, 1, 0, 1, 0, [], [[1,1,1],[1,1,1]]] call BIS_fnc_findSafePos;
			
				if ((_startPos select 0) != 1) then {
					_safe=true;
					_x setpos _startPos;
					_x setDir random 360;
				};
			};
		} foreach [fug1, fug2, fug3];

		
		waituntil {
			(
				({(side _x == civilian)&&(_x in [fug1,fug2,fug3])}count list goalB)
				+ 
				({(side _x == independent)&&(_x in [fug1,fug2,fug3])}count list goalO)
				== {alive _x}count [fug1,fug2,fug3]
			) || (
				{alive _x}count [fug1,fug2,fug3] == 0
			);
			
			sleep 5;
		};
		
		if ({alive _x}count [fug1,fug2,fug3] == 0) then {
		
			[["End1"], "BIS_fnc_endMission", true, false, false] call BIS_fnc_MP;
			
		} else {
		
			[ "All living fugitives are secured!", "systemChat", true, false, true ] call BIS_fnc_MP;
			sleep 1;
			[ 
				(format [
					"BLUFOR captured %1, OPFOR rescued %2.", 
					({(side _x == civilian)&&(_x in [fug1,fug2,fug3])}count list goalB),
					({(side _x == independent)&&(_x in [fug1,fug2,fug3])}count list goalO)
				]),
			"systemChat", true, false, true ] call BIS_fnc_MP;
			sleep 3;
			
			//ending conditions here
		};
		
		
	};

	[] spawn {
		_prevpos1 = getpos fug1;
		_rad1 = 500;
		while {!isnull fug1} do {
			sleep 30;
			_disp1 = _prevpos1 distance fug1;
			switch (true) do {
				case (_disp1 > 200): {_rad1 = 90};
				case (_disp1 > 160): {_rad1 = 150};
				case (_disp1 > 120): {_rad1 = 300};
				case (_disp1 > 100): {_rad1 = 400};
				case (_disp1 > 60): {_rad1 = 450};
				default {_rad1 = 500};
			};
			_ranDis1 = random (_rad1*.3);
			_ranDir1 = random 360;
			"marker_fug1" setmarkerpos [(getpos fug1 select 0) + _ranDis1 * (sin (_ranDir1 + 180)),(getpos fug1 select 1) + _ranDis1 * (cos (_ranDir1 + 180))];
			"marker_fug1" setMarkerSize [_rad1,_rad1];
			_prevpos1 = getpos fug1;
		};
	};

	[] spawn {
		_prevpos2 = getpos fug2;
		_rad2 = 500;
		while {!isnull fug2} do {
			sleep 30;
			_disp2 = _prevpos2 distance fug2;
			switch (true) do {
				case (_disp2 > 200): {_rad2 = 60};
				case (_disp2 > 160): {_rad2 = 150};
				case (_disp2 > 120): {_rad2 = 300};
				case (_disp2 > 100): {_rad2 = 400};
				case (_disp2 > 60): {_rad2 = 450};
				default {_rad2 = 500};
			};
			_ranDis2 = random (_rad2*.3);
			_ranDir2 = random 360;
			"marker_fug2" setmarkerpos [(getpos fug2 select 0) + _ranDis2 * (sin (_ranDir2 + 180)),(getpos fug2 select 1) + _ranDis2 * (cos (_ranDir2 + 180))];
			"marker_fug2" setMarkerSize [_rad2,_rad2];
			_prevpos2 = getpos fug2;
		};
	};

	[] spawn {
		_prevpos3 = getpos fug3;
		_rad3 = 500;
		while {!isnull fug3} do {
			sleep 30;
			_disp3 = _prevpos3 distance fug3;
			switch (true) do {
				case (_disp3 > 200): {_rad3 = 60};
				case (_disp3 > 160): {_rad3 = 150};
				case (_disp3 > 120): {_rad3 = 300};
				case (_disp3 > 100): {_rad3 = 400};
				case (_disp3 > 60): {_rad3 = 450};
				default {_rad3 = 500};
			};
			_ranDis3 = random (_rad3*.3);
			_ranDir3 = random 360;
			"marker_fug3" setmarkerpos [(getpos fug3 select 0) + _ranDis3 * (sin (_ranDir3 + 180)),(getpos fug3 select 1) + _ranDis3 * (cos (_ranDir3 + 180))];
			"marker_fug3" setMarkerSize [_rad3,_rad3];
			_prevpos3 = getpos fug3;
		};
	};
};
