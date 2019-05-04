#!/usr/bin/env bash

# This file is part of KSP-Hacks, © 2018 LisiasT, and it's double licensed as follows
#	SKL 1.0
#	GPL 2.0
# Pick the license that better suits yout needs.
#
# https://github.com/net-lisias-ksp/KSP-Hacks
#
# This file use HARD TABS.

do_local() {
	local PLUGIN=$1
	local DATADIR=$2

	if [ ! -e ./$PLUGIN/ ] ; then
		echo $PLUGIN not found. Ignoring it.
		return 0
	fi

	if [ ! -e ./$PLUGIN/$DATADIR ] ; then
		echo Datadir not found for $PLUGIN. Possible /L fork?
		return 0
	fi

	if [ -L ./$PLUGIN/$DATADIR ] ; then
		echo Nothing to do for $PLUGIN/$DATADIR.
		return 0
	fi

	if [ ! -e ./__LOCAL/$PLUGIN/$DATADIR ] ; then
		mkdir --parents ./__LOCAL/$PLUGIN/$DATADIR
	fi

	if [ -d ./$PLUGIN/$DATADIR ] ; then
		mv ./$PLUGIN/$DATADIR ./$PLUGIN/$DATADIR.bkp
		ln -s ./__LOCAL/$PLUGIN/$DATADIR ./$PLUGIN/$DATADIR 
		echo Relinked $PLUGIN/$DATADIR to ../PluginData.
		return 0
	fi
}

do_it() {
	local T=$1
	local PLUGIN=$2
	local DATADIR=$3

	if [ ! -e ./$PLUGIN/ ] ; then
		echo $PLUGIN not found. Ignoring it.
		return 0
	fi

	if [ ! -e ./$PLUGIN/$DATADIR ] ; then
		echo Datadir not found for $PLUGIN. Possible /L fork?
		return 0
	fi

	if [ -L ./$PLUGIN/$DATADIR ] ; then
		echo Nothing to do for $PLUGIN/$DATADIR.
		return 0
	fi

	if [ -d ../PluginData/$PLUGIN ] ; then
		if [ -e ./$PLUGIN/$DATADIR ] ; then
			mv ./$PLUGIN/$DATADIR ./$PLUGIN/$DATADIR.bkp
		fi
		ln -s $T/PluginData/$PLUGIN ../$PLUGIN/$DATADIR 
		echo Relinked $PLUGIN to ../PluginData.
		return 0
	fi

	mv ./$PLUGIN/$DATADIR ./$PLUGIN/$DATADIR.bkp
	mkdir -p ../PluginData/$PLUGIN
	cp -r ./$PLUGIN/$DATADIR.bkp/* ../PluginData/$PLUGIN
	ln -s $T/PluginData/$PLUGIN ./$PLUGIN/$DATADIR 
	echo Moved and linked  $PLUGIN. Check messages for errors.
}

do_it_2() {
	do_it "../.." $1 $2
}

do_it_3() {
	do_it "../../.." $1 $2
}
do_it_4() {
	do_it "../../../.." $1 $2
}

do_it_5() {
	do_it "../../../../.." $1 $2
}

# Decluttering
find . -name MiniAVC.dll -delete &
clean_pid=$!

do_it_3 000_AT_Utils Plugins/PluginData
do_it_2 AnyRes PluginData
do_it_2 BetterBurnTime PluginData
do_it_2 BetterTimeWarp PluginData
do_it_3 BonVoyage PluginData/BonVoyage
do_it_4 Chatterer Plugins/PluginData/Chatterer
do_it_4 CorrectCOL Plugins/PluginData/CorrectCoL
do_it_3 DavonTCsystemsMod Plugins/Profiles
do_it_2 DistantObject PluginData
do_it_2 EVAEnhancementsContinued PluginData
do_it_3 EasyVesselSwitch Plugins/PluginData
do_it_4 Hangar Plugins/PluginData/Hangar
# HullCameraVDS
# KAS
# KSPWheel
do_it_2 KerbalEngineer Settings
do_it_4 KJR Plugin/PluginData/KerbalJointReinforcement
do_it_4 KerbalJointReinforcement Plugin/PluginData/KerbalJointReinforcement
do_it_3 KerbalKonstructs PluginData/KerbalKonstructs
do_local KerbalKonstructs NewInstances
# KerbalStats
do_it_3 Kerbaltek/HyperEdit HyperEdit
do_it_4 MechJeb2 Plugins/PluginData/MechJeb2
# MOARdv - Checar com cuidado
do_it_3 MPUtils Plugins/PluginData
do_it_4 MechJeb2 Plugins/PluginData/MechJeb2
do_it_4 MemGraph Plugins/PluginData/MemGraph
do_it_4 NavBallDockingAlignmentIndicatorCE Plugins/PluginData/NavBallDockingAlignmentIndicatorCE
do_it_4 PartAngleDisplay Plugins/PluginData/PartAngleDisplay
do_it_2 PartCommanderContinued PluginData
do_it_2 PartWizard PluginData
do_it_2 PersistentRotation PluginData
# PhysicsRangeExtender
do_it_2 RCSBuildAid PluginData
do_it_4 REPOSoftTech/AmpYear Plugins/PluginData
# RoverScience
do_it_2 SCANsat PluginData
# ScienceAlert
# SeriousBusiness
# ShipEffects
do_it_3 ShipManifest Plugins/PluginData
do_it_4 SmartStage Plugins/PluginData/SmartStage
# SmokeScreen
do_it_4 SolverEngines Plugins/PluginData/SolverEngines
# SpeedUnitChanger
do_it_2 StageRecovery PluginData
# StationScience
do_it_3 TacFuelBalancer PluginData/TacFuelBalancer
do_it_4 TacStickyControls PluginData/TacStickControls
# TacStickyControls
# ThrottleControlledAvionics Ver oque fazer.
do_it_4 Trajectories Plugin/PluginData/Trajectories
do_it_2 ThroughTheEyes PluginData
do_it_2 TimeControl PluginData
do_it_4 Trajectories Plugin/PluginData/Trajectories
# TriggerTech  Ver que fazer com isso - talvez unfficial?
do_it_2 WasdEditorCamera PluginData
do_it_2 kRPC PluginData
do_it_4 kOS Plugins/PluginData/kOS

# wait for the background jobs to finish...
echo Waiting for jobs...
wait $clean_pid
echo Finished.
