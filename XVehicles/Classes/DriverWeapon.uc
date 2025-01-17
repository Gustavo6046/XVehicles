class DriverWeapon expands TournamentWeapon;

var Vehicle VehicleOwner;
var DriverWNotifier MyNotifier;
var bool bPassengerGun;
var byte SeatNumber;

var() config bool UseStandardCrosshair;

/*replication
{
	// Variables the server should send to the client.
	reliable if( Role==ROLE_Authority )
		VehicleOwner,SeatNumber;
}*/

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	InventoryGroup = Charge; // hack for net
	
//	SetName();
}

function PreBeginPlay()
{
	Super.PreBeginPlay();
	VehicleOwner = Vehicle(Owner);
	MaxDesireability = VehicleOwner.AIRating*100;
	AIRating = VehicleOwner.AIRating;
	setCollisionSize(VehicleOwner.CollisionRadius + 10, CollisionHeight);
	PrePivot.Z = CollisionHeight - VehicleOwner.CollisionHeight;
}

event float BotDesireability( pawn Bot )
{
	return VehicleOwner.BotAttract.BotDesireability(Bot);
}

function float SuggestAttackStyle()
{
	if (VehicleOwner.Health < 0.5*VehicleOwner.default.Health)
		return -10.0; // cautious
	return 20.0; // aggressive	
}

function float SuggestDefenseStyle()
{
	return -10.0; // run away, vehicle override usage of this
}

simulated event RenderOverlays( canvas Canvas );

function PostBeginPlay()
{
	bOwnsCrosshair = !class'DriverWeapon'.default.UseStandardCrosshair;
	MyNotifier = Spawn(Class'DriverWNotifier');
	MyNotifier.WeaponOwner = Self;
	Inventory = MyNotifier;
	
	setTimer(1, true);
}
event TravelPostAccept()
{
	Destroy();
}

Auto State ClientActive
{
Ignores BringUp,Finish;

	function bool PutDown()
	{
		bChangeWeapon = true;
		if( bPassengerGun )
			VehicleOwner.PassengerChangeBackView(SeatNumber);
		else
			VehicleOwner.ChangeBackView();
		return true;
	}
}

function float SwitchPriority()
{
	return 340282346638528870000000000000000000000.0; // max float
}

simulated function SetName()
{
	if (ItemName == "Weapon")
	{
		if (VehicleOwner != None)
			ItemName = VehicleOwner.GetWeaponName(SeatNumber);
		else
			SetTimer(1, false);
	}
}

simulated function Timer()
{
/*	if (Role < ROLE_Authority) 
	{
		SetName();
		return;
	}*/

	if (!IsInState('ClientActive'))
		GotoState('ClientActive');
	if (Pawn(Owner) != None && Pawn(Owner).Weapon != self)
	{
		Pawn(Owner).PendingWeapon = self;
		if (Pawn(Owner).Weapon != None)
			Pawn(Owner).Weapon.GoToState('');
		Pawn(Owner).Weapon = self;
	}	
}

/* Functions used by Unreal Tournament */
function ForceFire()
{
	Fire(0);
}
function ForceAltFire()
{
	AltFire(0);
}
simulated function PlaySelect()
{
	bForceFire = false;
	bForceAltFire = false;
	bCanClientFire = false;
}

function Fire(float F)
{
	if( bPassengerGun )
		VehicleOwner.PassengerFireWeapon(False,SeatNumber);
	else
		VehicleOwner.FireWeapon(False);
}
function AltFire(float F) 
{
	if( bPassengerGun )
		VehicleOwner.PassengerFireWeapon(True,SeatNumber);
	else
		VehicleOwner.FireWeapon(True);
}
function NotifyNewDriver( Pawn NewDriver );
function NotifyDriverLeft( Pawn OldDriver );
function DropFrom(vector StartLocation)
{
	if( bPassengerGun )
		VehicleOwner.PassengerLeave(SeatNumber);
	else VehicleOwner.DriverLeft(False);
}

function Destroyed()
{
	if( MyNotifier!=None )
	{
		MyNotifier.Destroy();
		MyNotifier = None;
	}
	Super.Destroyed();
}
function Projectile ProjectileFire(class<projectile> ProjClass, float ProjSpeed, bool bWarn);
function TraceFire( float Accuracy );

function SetupWeapon(WeaponAttachment WA)
{
	if (WA == None)
		return;
	bInstantHit = WA.WeapSettings[0].bInstantHit;
	bSplashDamage = !bInstantHit;
	bRecommendSplashDamage = bSplashDamage;
	bAltWarnTarget = WA.bAltFireZooms;
}

defaultproperties
{
      VehicleOwner=None
      MyNotifier=None
      bPassengerGun=False
      SeatNumber=0
      UseStandardCrosshair=False
      bWarnTarget=True
      AIRating=1.000000
      PickupMessage="You got a vehicle"
      ItemName="Vehicle"
      PlayerViewMesh=LodMesh'Botpack.AutoML'
      PickupViewMesh=LodMesh'Botpack.MagPick'
      ThirdPersonMesh=LodMesh'Botpack.AutoHand'
      Charge=1
      MaxDesireability=10.000000
      bHidden=True
      Physics=PHYS_Trailer
      Mesh=LodMesh'Botpack.MagPick'
      bGameRelevant=True
      bCarriedItem=True
}
