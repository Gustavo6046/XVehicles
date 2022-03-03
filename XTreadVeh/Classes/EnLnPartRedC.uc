﻿class EnLnPartRedC expands EnLnPartics;

//Energy Line Particles mesh import
#exec MESH IMPORT MESH=EnLnPartRedC ANIVFILE=MODELS\EnLnPartics_a.3d DATAFILE=MODELS\EnLnPartics_d.3d X=0 Y=0 Z=0
#exec MESH LODPARAMS MESH=EnLnPartRedC STRENGTH=0.5
#exec MESH ORIGIN MESH=EnLnPartRedC X=0 Y=0 Z=0


//Energy Line Particles animations
#exec MESH SEQUENCE MESH=EnLnPartRedC SEQ=All STARTFRAME=0 NUMFRAMES=15
#exec MESH SEQUENCE MESH=EnLnPartRedC SEQ=Still STARTFRAME=0 NUMFRAMES=1
#exec MESH SEQUENCE MESH=EnLnPartRedC SEQ=Impl00 STARTFRAME=0 NUMFRAMES=2 RATE=1.0	//Straight implode
#exec MESH SEQUENCE MESH=EnLnPartRedC SEQ=Expl00 STARTFRAME=1 NUMFRAMES=2 RATE=1.0	//Straight explode
#exec MESH SEQUENCE MESH=EnLnPartRedC SEQ=ImplP30 STARTFRAME=3 NUMFRAMES=2 RATE=1.0	//Positive spiral 30є implode
#exec MESH SEQUENCE MESH=EnLnPartRedC SEQ=ExplP30 STARTFRAME=4 NUMFRAMES=2 RATE=1.0	//Positive spiral 30є explode
#exec MESH SEQUENCE MESH=EnLnPartRedC SEQ=ImplN30 STARTFRAME=6 NUMFRAMES=2 RATE=1.0	//Negative spiral 30є implode
#exec MESH SEQUENCE MESH=EnLnPartRedC SEQ=ExplN30 STARTFRAME=7 NUMFRAMES=2 RATE=1.0	//Negative spiral 30є explode
#exec MESH SEQUENCE MESH=EnLnPartRedC SEQ=ImplP60 STARTFRAME=9 NUMFRAMES=2 RATE=1.0	//Positive spiral 60є implode
#exec MESH SEQUENCE MESH=EnLnPartRedC SEQ=ExplP60 STARTFRAME=10 NUMFRAMES=2 RATE=1.0	//Positive spiral 60є explode
#exec MESH SEQUENCE MESH=EnLnPartRedC SEQ=ImplN60 STARTFRAME=12 NUMFRAMES=2 RATE=1.0	//Negative spiral 60є implode
#exec MESH SEQUENCE MESH=EnLnPartRedC SEQ=ExplN60 STARTFRAME=13 NUMFRAMES=2 RATE=1.0	//Negative spiral 60є explode

//Energy Line Particles animation
#exec MESHMAP NEW MESHMAP=EnLnPartRedC MESH=EnLnPartRedC
#exec MESHMAP SCALE MESHMAP=EnLnPartRedC X=0.2 Y=0.1 Z=0.2


//Basic texture skinning
#exec TEXTURE IMPORT NAME=RedEnLn FILE=EFFECTS\RedEnLn.bmp GROUP=Effects LODSET=2

#exec MESHMAP SETTEXTURE MESHMAP=EnLnPartRedC NUM=1 TEXTURE=RedEnLn
#exec MESHMAP SETTEXTURE MESHMAP=EnLnPartRedC NUM=2 TEXTURE=RedEnLn
#exec MESHMAP SETTEXTURE MESHMAP=EnLnPartRedC NUM=3 TEXTURE=RedEnLn
#exec MESHMAP SETTEXTURE MESHMAP=EnLnPartRedC NUM=4 TEXTURE=RedEnLn
#exec MESHMAP SETTEXTURE MESHMAP=EnLnPartRedC NUM=5 TEXTURE=RedEnLn
#exec MESHMAP SETTEXTURE MESHMAP=EnLnPartRedC NUM=6 TEXTURE=RedEnLn

defaultproperties
{
      FXSpeed=50.000000
      ProgressiveFXSpeed=25.000000
      bExtInitialized=True
      Mesh=LodMesh'XTreadVeh.EnLnPartRedC'
      DrawScale=2.500000
      ScaleGlow=1.400000
}
