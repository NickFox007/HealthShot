#pragma semicolon 1

#include <sdktools>

public Plugin myinfo =
{
	name = "Healthshot [For ALL]",
	author = "R1KO & Eneanuch & NF",
	version = "1.4"
};


ConVar CVAR;

int g_iCount;

public void OnPluginStart() 
{	
	(CVAR = CreateConVar("healthshot_give_quantity", "1", "Количество выдаваемых шприцов.", _, true, 0.0)).AddChangeHook(ChangeCvar);

	HookEvent("player_spawn", OnPlayerSpawn); 
	
	AutoExecConfig(true, "healthshot", "sourcemod");	
	
	Autoexec();	
}

void Autoexec(){
	g_iCount = CVAR.IntValue;
}

public void ChangeCvar(ConVar convar, const char[] oldValue, const char[] newValue)
{
	g_iCount = convar.IntValue;	
}

public void OnPluginEnd() 
{
	UnhookEvent("player_spawn", OnPlayerSpawn); 
}

public void OnPlayerSpawn(Event hEvent, const char[] sEvName, bool bDontBroadcast) 

{
	new iClient = GetClientOfUserId(GetEventInt(hEvent,"userid"));
	new a = GetEntProp(iClient, Prop_Data, "m_iAmmo", _, 21);	
	
	for(int i = 0; i < g_iCount - a; i++){
		GivePlayerItem(iClient, "weapon_healthshot");
	}
	
}

public void OnMapStart()
{
	int iFlags;

	ConVar hCvar = FindConVar("ammo_item_limit_healthshot");
	if (hCvar != null)
	{
		iFlags = hCvar.Flags;
		iFlags &= ~FCVAR_CHEAT;
		hCvar.Flags = iFlags;
	}

	hCvar = FindConVar("healthshot_health");
	if (hCvar != null)
	{
		iFlags = hCvar.Flags;
		iFlags &= ~FCVAR_CHEAT;
		hCvar.Flags = iFlags;
	}
	
}