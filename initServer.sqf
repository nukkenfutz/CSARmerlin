sleep 1;

ron addEventHandler ["Killed", {

	[] spawn {
		_cutterarray = [];
		{
			if (typeOf _x == "ClutterCutter_small_EP1") then {
			_cutterarray = _cutterarray + [_x];
			};
		}foreach list trig1;

		_crashpos = getpos (_cutterarray select random count _cutterarray);
		helis setpos _crashpos;
		helis setdir random 360;
		helis setDamage 1;
		sleep 3;

		{
			_safe = false;
			while {!_safe} do {
				_startPos = [_crashpos, 25, 50, 1, 1, 1, 0, [], [[1,1,1],[1,1,1]]] call BIS_fnc_findSafePos;
			
				if ((_startPos select 0) != 1) then {
					_safe=true;
					_randir = random 360;
					_x setpos _startPos;
					_x setDir _randir;
				};
			};
		} foreach [fug1, fug2, fug3];
	};

	[] spawn {
		_prevpos1 = getpos fug1;
		_rad1 = 500;
		while {!isnull fug1} do {
			sleep 30;
			_disp1 = _prevpos1 distance fug1;
			switch (true) do {
				case (_disp1 > 200): {_rad1 = 60};
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

}];
