enableSaving [false, false];
enableSentences false;
sleep 1;
gameonscript = [startB, startO, leadB, leadO, [ofheli, bftruck1, bftruck2]] execVM "gameon.sqf";

if (side player == west) then {
	Bravo addGroupIcon ["b_inf",[0,0]];
	Bravo setGroupIconParams [[0,.25,1,1],"B",1,true];
	setGroupIconsVisible [true,false];
};
