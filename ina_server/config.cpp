class CfgPatches
{
	class InaServer
	{
		units[]={"C_man_1"};
		weapons[]={};
		requiredAddons[]={"extDB3"};
		fileName="ina_server.pbo";
		author[]={"Joaquine"};
	};
};

class CfgFunctions {

	class Server {
		tag = "DB";


			class Mysql {
				file = "\ina_server\mysql";
				class extDBInit;
				class extDBSync;
			};
			class Player {
				file = "\ina_server\player";
				class initNil;
				class initPhone;
				class initPlayer;
			};

	};
	class commadn {
		tag = "CMD";
			class command {
				file = "\ina_server\command";
					class commandRcon;
			};
	};
};