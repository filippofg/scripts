#!/bin/bash

PACKAGES=(
	"com.google.android.apps.subscriptions.red"
	"com.google.android.youtube"
	"com.google.android.apps.googleassistant"
	"com.google.android.apps.docs.editors.docs"
	"com.google.android.apps.podcasts"
	"com.google.android.apps.docs.editors.sheets"
	"com.google.android.apps.docs.editors.slides"
	"com.google.ar.core"
	"com.android.hotwordenrollment.xgoogle"
	"com.android.hotwordenrollment.okgoogle"
	"com.google.android.partnersetup"
	"com.google.android.videos"
	"com.google.android.feedback"
	"com.google.android.printservice.recommendation"
	"com.google.android.apps.photos"
	"com.google.android.calendar"
	"com.google.android.apps.chromecast.app"
	"com.google.android.gms.location.history"
	"com.google.android.apps.youtube.music"
	"com.google.android.apps.magazines"
	"com.google.android.apps.restore"
	"com.google.android.apps.docs"
	"com.facebook.system"
	"com.facebook.appmanager"
	"com.facebook.services"
	"com.facebook.katana"
	"com.android.chrome"
	"com.motorola.gamemode"
	"com.google.android.projection.gearhead"
	"com.google.android.apps.tachyon"
	"com.google.android.apps.nbu.files"
	"com.google.android.googlequicksearchbox"
	"com.google.android.gm"
	"com.google.android.apps.youtube.music.setupwizard"
	"com.zhiliaoapp.musically"
)
for i in ${PACKAGES[*]}; do
	adb shell "pm uninstall -k --user 0 $i"
	echo $i
done

