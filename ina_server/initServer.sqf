/*
    File: initServer.sqf
    ====================
    Author: Joaquine
    ====================
    Description :

*/
private _timeSt = diag_tickTime;
i_ready = false;
waitUntil {["inaliferp","SQL_CUSTOM","inalife.ini"] call DB_fnc_extDBInit};
diag_log "-------------------------------------------------------------";
diag_log "-------------------- InaLife Serveur ------------------------";
diag_log "-------------------------------------------------------------";

diag_log "-------------------------------------------------------------";
diag_log format["Total Execution Time %1 seconds", (diag_tickTime - _timeSt)];
diag_log "-------------------------------------------------------------";

i_ready = true;
publicVariable "i_ready";