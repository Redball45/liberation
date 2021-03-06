waitUntil { time > 1 };
waitUntil { !isNil "GRLIB_all_fobs" };
waitUntil { !isNil "save_is_loaded" };

private [ "_fobbox" ];

if ( count GRLIB_all_fobs == 0 ) then {

  if ( GRLIB_build_first_fob ) then {
    _potentialplaces = [];
    {
      _nextsector = _x;
      _acceptsector = true;
      {
        if ( ( ( markerPos _nextsector ) distance ( markerPos _x ) ) < 1600 ) then {
          _acceptsector = false;
        };
      } foreach sectors_allSectors;

      if ( _acceptsector ) then {
        _potentialplaces pushBack _nextsector;
      };
    } foreach sectors_opfor;

    _spawnplace = _potentialplaces call BIS_fnc_selectRandom;
    [ [ markerPos _spawnplace, true ] , "build_fob_remote_call" ] call BIS_fnc_MP;

  } else {
    while { count GRLIB_all_fobs == 0 } do {

      _fobbox = FOB_box_typename createVehicle (getpos base_boxspawn);
      _fobbox setpos (getpos base_boxspawn);
      _fobbox setdir 215;

      sleep 3;

      waitUntil {
        sleep 1;
        !(alive _fobbox) || count GRLIB_all_fobs > 0
      };

      sleep 15;

    };

    deleteVehicle _fobbox;
  };
};
