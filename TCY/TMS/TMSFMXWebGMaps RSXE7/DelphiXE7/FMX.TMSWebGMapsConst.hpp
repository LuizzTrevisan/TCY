// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMX.TMSWebGMapsConst.pas' rev: 28.00 (Windows)

#ifndef Fmx_TmswebgmapsconstHPP
#define Fmx_TmswebgmapsconstHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fmx
{
namespace Tmswebgmapsconst
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
#define HTML_BLANK_PAGE L"about:blank"
#define JAVASCRIPT L"JavaScript"
#define MAP_TYPE_PREFIX L"google.maps.MapTypeId."
#define CONTROL_POSITION_TEXT L"%controlposition%"
#define CONTROL_DEFAULT L"DEFAULT"
#define CONTROL_ANDROID L"ANDROID"
#define CONTROL_SMALL L"SMALL"
#define CONTROL_ZOOMPAN L"ZOOM_PAN"
#define POSITION_BOTTOMCENTER L"BOTTOM_CENTER"
#define POSITION_BOTTOMLEFT L"BOTTOM_LEFT"
#define POSITION_BOTTOMRIGHT L"BOTTOM_RIGHT"
#define POSITION_LEFTBOTTOM L"LEFT_BOTTOM"
#define POSITION_LEFTCENTER L"LEFT_CENTER"
#define POSITION_LEFTTOP L"LEFT_TOP"
#define POSITION_RIGHTBOTTOM L"RIGHT_BOTTOM"
#define POSITION_RIGHTCENTER L"RIGHT_CENTER"
#define POSITION_RIGHTTOP L"RIGHT_TOP"
#define POSITION_TOPCENTER L"TOP_CENTER"
#define POSITION_TOPLEFT L"TOP_LEFT"
#define POSITION_TOPRIGHT L"TOP_RIGHT"
#define ZOOM_DEFAULT L"DEFAULT"
#define ZOOM_LARGE L"LARGE"
#define ZOOM_SMALL L"SMALL"
#define MAPTYPE_DEFAULT L"DEFAULT"
#define MAPTYPE_DROPDOWNMENU L"DROPDOWN_MENU"
#define MAPTYPE_HORIZONTALBAR L"HORIZONTAL_BAR"
#define MAP_DEFAULT L"ROADMAP"
#define MAP_SATELLITE L"SATELLITE"
#define MAP_HYBRID L"HYBRID"
#define MAP_TERRAIN L"TERRAIN"
#define GIF_RESSOURCE_NAME L"LOADER"
#define GIF_FORMAT L"GIF"
static const System::Int8 DEFAULT_ZOOM = System::Int8(0xa);
static const System::Extended DEFAULT_LATITUDE = 4.885904E+01;
static const System::Extended DEFAULT_LONGITUDE = 2.294297E+00;
static const System::Int8 DEFAULT_WIDTH = System::Int8(0x64);
static const System::Int8 DEFAULT_HEIGHT = System::Int8(0x64);
#define GEOCODING_BASE_URL L"http://maps.googleapis.com/maps/api/geocode/xml?"
#define GEOCODING_START_URL L"address="
#define GEOCODING_REVERSESTART_URL L"latlng="
#define GEOCODING_END_URL L"&sensor=false"
#define GEOCODING_STATUS L"status"
#define GEOCODING_LATITUDE L"lat"
#define GEOCODING_LONGITUDE L"lng"
#define GEOCODING_LOCATION_TYPE L"location_type"
#define GEOCODING_ADDRESS L"formatted_address"
#define GEOCODINF_STATUS_OK L"OK"
#define GEOCODINF_STATUS_ZERO_RESULTS L"ZERO_RESULTS"
#define GEOCODINF_STATUS_OVER_QUERY_LIMIT L"OVER_QUERY_LIMIT"
#define GEOCODINF_STATUS_REQUEST_DENIED L"REQUEST_DENIED"
#define GEOCODINF_STATUS_INVALID_REQUEST L"INVALID_REQUEST"
#define GEOCODING_LOCTYPE_ROOFTOP L"ROOFTOP"
#define GEOCODING_LOCTYPE_RANGE_INTERPOLATED L"RANGE_INTERPOLATED"
#define GEOCODING_LOCTYPE_GEOMETRIC_CENTER L"GEOMETRIC_CENTER"
#define GEOCODING_LOCTYPE_APPROXIMATE L"APPROXIMATE"
#define WEATHER_TEMPERATURE_CELSIUS L"CELSIUS"
#define WEATHER_TEMPERATURE_FAHRENHEIT L"FAHRENHEIT"
#define WEATHER_WIND_SPEED_KILOMETERS_PER_HOUR L"KILOMETERS_PER_HOUR"
#define WEATHER_WIND_SPEED_METERS_PER_SECOND L"METERS_PER_SECOND"
#define WEATHER_WIND_SPEED_MILES_PER_HOUR L"MILES_PER_HOUR"
#define WEATHER_LABEL_COLOR_BLACK L"BLACK"
#define WEATHER_LABEL_COLOR_WHITE L"WHITE"
#define HTML_FILE_1 L"<!DOCTYPE html>\r<html>\r<head>\r<meta name=\"viewport\" c"\
	L"ontent=\"initial-scale=1.0, user-scalable=yes\" /> <meta h"\
	L"ttp-equiv=\"content-type\" content=\"text/html; charset=UT"\
	L"F-8\" />\r<style type=\"text/css\">\r html, body, #map_can"\
	L"vas {\r  margin: 0;\r  padding: 0;\r  height: 100%\r }\r</"\
	L"style>\r<script type=\"text/javascript\" src=\"http://maps"\
	L".google.com/maps/api/js?%apikey%sensor=true&libraries=pano"\
	L"ramio,weather&language=%lang%\"></script>\r<script type=\""\
	L"text/javascript\">\r var map;\r var streetviewService;\r v"\
	L"ar streetviewPanorama;\r var allmarkers = [];\r var alllab"\
	L"els = [];\r var allpolylines = [];\r var allpolygons = [];"\
	L"\r var allkmllayers = [];\r var allinfowindows = [];\r var"\
	L" trafficLayer;\r var bicyclingLayer;\r var panoramioLayer;"\
	L"\r var cloudLayer;\r var weatherLayer;\r var directionsDis"\
	L"play;\r var directionsService = new google.maps.Directions"\
	L"Service();\r var mx = 0;\r var my = 0;\r function setzoomm"\
	L"ap(newzoom) {\r   var OldZoomLevel = parseFloat(map.getZoo"\
	L"m());\r   var NewzoomLevel = parseFloat(newzoom);\r   if ("\
	L"OldZoomLevel!=NewzoomLevel) {\r     map.setZoom(newzoom);\r"\
	L"   }\r }\r \r function getBounds() {\r   var result = map."\
	L"getBounds();\r   var ne = result.getNorthEast();\r   var s"\
	L"w = result.getSouthWest();\r  window.location.href = \"jse"\
	L"vent://boundsretrieved:nelat=\"+ne.lat()+\"#nelng=\"+ne.ln"\
	L"g()+\"#swlat=\"+sw.lat()+\"#swlng=\"+sw.lng(); \r }\r \r f"\
	L"unction showStreetview(lat, lng, valhead, valzm, valptch) "\
	L"{\r   var valheading = parseFloat(valhead);\r   var valzoo"\
	L"m = parseFloat(valzm);\r   var valpitch = parseFloat(valpt"\
	L"ch);\r   var point = new google.maps.LatLng(parseFloat(lat"\
	L"),parseFloat(lng));\r   streetviewPanorama.setPov({\r     "\
	L"                         heading: valheading,\r           "\
	L"                   zoom: valzoom,\r                       "\
	L"       pitch: valpitch});\r   streetviewService.getPanoram"\
	L"aByLocation(point, 100, processStreeviewData);\r }\r \r fu"\
	L"nction processStreeviewData(data, status) {\r   if (status"\
	L" == google.maps.StreetViewStatus.OK) {\r     streetviewPan"\
	L"orama.setPano(data.location.pano);\r     streetviewPanoram"\
	L"a.setVisible(true);\r   } else {\r     streetviewPanorama."\
	L"setVisible(false);\r     if (status == google.maps.StreetV"\
	L"iewStatus.UNKNOWN_ERROR) {\r  window.location.href = \"jse"\
	L"vent://error:errorid=4\"; \r     } else {\r  window.locati"\
	L"on.href = \"jsevent://error:errorid=5\"; \r     }\r   }\r "\
	L"}\r \r function calcDirections(start, end, travelmode, avo"\
	L"idhighways, avoidtolls, wp, optwp) {\r directionsDisplay ="\
	L" new google.maps.DirectionsRenderer();\r directionsDisplay"\
	L".setMap(map);\r  var request = {\r    origin: start,\r    "\
	L"destination: end,\r    travelMode: travelmode,\r    avoidH"\
	L"ighways: avoidhighways,\r    avoidTolls: avoidtolls,\r    "\
	L"waypoints: wp,\r    optimizeWaypoints: optwp\r  };\r  dire"\
	L"ctionsService.route(request, function(result, status) {\r "\
	L"   if (status == google.maps.DirectionsStatus.OK) {\r     "\
	L" directionsDisplay.setDirections(result);\r    }\r  });\r}"\
	L"\r function addKMLLayer(url, zoomtobounds) {\r   var kmlOp"\
	L"tions = {\r     clickable: true,\r     suppressInfoWindows"\
	L": false,\r     preserveViewport: zoomtobounds,\r     map: "\
	L"map\r   };\r   var kmlLayer = new google.maps.KmlLayer(url"\
	L", kmlOptions);\r   allkmllayers.push(kmlLayer);\r   google"\
	L".maps.event.addListener(kmlLayer, \"status_changed\", func"\
	L"tion() {\r     var status = kmlLayer.getStatus();\r     if"\
	L" (status != \"OK\")\r \t    alert(\"KML Layer '\" + kmlLay"\
	L"er.getUrl() + \"' status: \" + status);\r   })\r   google."\
	L"maps.event.addListener(kmlLayer, \"click\", function(event"\
	L") {\r          IdKMLLayer=-1;\r          for (var i = 0; i"\
	L" < allkmllayers.length; i++){\r            if (allkmllayer"\
	L"s[i]==kmlLayer) {\r              IdKMLLayer=i;\r          "\
	L"  }\r          }\r          lat=parseFloat(event.latLng.la"\
	L"t());\r          lng=parseFloat(event.latLng.lng());\r  wi"\
	L"ndow.location.href = \"jsevent://kmllayerclick:title=\" + "\
	L"event.featureData.name + \"#id=\"+IdKMLLayer+\"#lat=\"+lat"\
	L"+\"#lng=\"+lng; \r   });\r }\r function updateMapPolyline("\
	L"index, clickable, editable, icons, path, color, width, opa"\
	L"city, visible, geodesic, index) {\r   var polylineOptions "\
	L"= { map: map, icons: icons, clickable: clickable, editable"\
	L": editable , path: path , strokeColor: color, strokeWeight"\
	L": width, strokeOpacity: opacity, visible: visible, geodesi"\
	L"c: geodesic, zIndex: index };\r   allpolylines[index].setO"\
	L"ptions(polylineOptions);\r   }\r function createMapPolylin"\
	L"e(clickable, editable, icons, path, color, width, opacity,"\
	L" visible, geodesic, index) {\r   var polylineOptions = { m"\
	L"ap: map, icons: icons, clickable: clickable, editable: edi"\
	L"table , path: path , strokeColor: color, strokeWeight: wid"\
	L"th, strokeOpacity: opacity, visible: visible, geodesic: ge"\
	L"odesic, zIndex: index };\r   var polyline = new google.map"\
	L"s.Polyline(polylineOptions);\r   allpolylines.push(polylin"\
	L"e);\r   google.maps.event.addListener(polyline, \"click\","\
	L" function() {\r          IdMarker=-1;\r          for (var "\
	L"i = 0; i < allpolylines.length; i++){\r            if (all"\
	L"polylines[i]==polyline) {\r              IdMarker=i;\r    "\
	L"        }\r          }\r  window.location.href = \"jsevent"\
	L"://polylineclick:id=\"+IdMarker; \r   });\r   google.maps."\
	L"event.addListener(polyline, \"dblclick\", function() {\r  "\
	L"        IdMarker=-1;\r          for (var i = 0; i < allpol"\
	L"ylines.length; i++){\r            if (allpolylines[i]==pol"\
	L"yline) {\r              IdMarker=i;\r            }\r      "\
	L"    }\r  window.location.href = \"jsevent://polylinedblcli"\
	L"ck:id=\"+IdMarker; \r   });\r }\r \r function updateMapPol"\
	L"ygon(index, clickable, editable, paths, bgcolor, bordercol"\
	L"or, borderwidth, bgopacity, borderopacity, visible, geodes"\
	L"ic, zindex, ptype, centerlat, centerlng, radius, nelat, ne"\
	L"lng, swlat, swlng) {\r   if (ptype == \"circle\") {\r   va"\
	L"r center = new google.maps.LatLng(parseFloat(centerlat),pa"\
	L"rseFloat(centerlng));\r   var polygonOptions = { map: map,"\
	L" clickable: clickable, editable: editable , center: center"\
	L", radius: radius , fillColor: bgcolor , fillOpacity: bgopa"\
	L"city, strokeColor: bordercolor, strokeWeight: borderwidth,"\
	L" strokeOpacity: borderopacity, visible: visible, zIndex: z"\
	L"index };\r   } else if (ptype == \"rectangle\") {\r   var "\
	L"bounds = new google.maps.LatLngBounds(new google.maps.LatL"\
	L"ng(swlat, swlng), new google.maps.LatLng(nelat, nelng));\r"\
	L"   var polygonOptions = { map: map, clickable: clickable, "\
	L"editable: editable , bounds: bounds , fillColor: bgcolor ,"\
	L" fillOpacity: bgopacity, strokeColor: bordercolor, strokeW"\
	L"eight: borderwidth, strokeOpacity: borderopacity, visible:"\
	L" visible, zIndex: zindex };\r   } else {\r   var polygonOp"\
	L"tions = { map: map, clickable: clickable, editable: editab"\
	L"le , paths: paths , fillColor: bgcolor , fillOpacity: bgop"\
	L"acity, strokeColor: bordercolor, strokeWeight: borderwidth"\
	L", strokeOpacity: borderopacity, visible: visible, geodesic"\
	L": geodesic, zIndex: zindex };\r   }\r   allpolygons[index]"\
	L".setOptions(polygonOptions);\r}\r function createMapPolygo"\
	L"n(clickable, editable, paths, bgcolor, bordercolor, border"\
	L"width, bgopacity, borderopacity, visible, geodesic, zindex"\
	L", ptype, centerlat, centerlng, radius, nelat, nelng, swlat"\
	L", swlng) {\r   if (ptype == \"circle\") {\r   var center ="\
	L" new google.maps.LatLng(parseFloat(centerlat),parseFloat(c"\
	L"enterlng));\r   var circleOptions = { map: map, clickable:"\
	L" clickable, editable: editable , center: center, radius: r"\
	L"adius , fillColor: bgcolor , fillOpacity: bgopacity, strok"\
	L"eColor: bordercolor, strokeWeight: borderwidth, strokeOpac"\
	L"ity: borderopacity, visible: visible, zIndex: zindex };\r "\
	L"  var polygon = new google.maps.Circle(circleOptions);\r  "\
	L" } else if (ptype == \"rectangle\") {\r   var bounds = new"\
	L" google.maps.LatLngBounds(new google.maps.LatLng(swlat, sw"\
	L"lng), new google.maps.LatLng(nelat, nelng));\r   var rectO"\
	L"ptions = { map: map, clickable: clickable, editable: edita"\
	L"ble , bounds: bounds , fillColor: bgcolor , fillOpacity: b"\
	L"gopacity, strokeColor: bordercolor, strokeWeight: borderwi"\
	L"dth, strokeOpacity: borderopacity, visible: visible, zInde"\
	L"x: zindex };\r   var polygon = new google.maps.Rectangle(r"\
	L"ectOptions);\r   } else {\r   var polygonOptions = { map: "\
	L"map, clickable: clickable, editable: editable , paths: pat"\
	L"hs , fillColor: bgcolor , fillOpacity: bgopacity, strokeCo"\
	L"lor: bordercolor, strokeWeight: borderwidth, strokeOpacity"\
	L": borderopacity, visible: visible, geodesic: geodesic, zIn"\
	L"dex: zindex };\r   var polygon = new google.maps.Polygon(p"\
	L"olygonOptions);\r   }\r   allpolygons.push(polygon);\r   g"\
	L"oogle.maps.event.addListener(polygon, \"click\", function("\
	L") {\r          IdMarker=-1;\r          for (var i = 0; i <"\
	L" allpolygons.length; i++){\r            if (allpolygons[i]"\
	L"==polygon) {\r              IdMarker=i;\r            }\r  "\
	L"        }\r  window.location.href = \"jsevent://polygoncli"\
	L"ck:id=\"+IdMarker; \r   });\r   google.maps.event.addListe"\
	L"ner(polygon, \"dblclick\", function() {\r          IdMarke"\
	L"r=-1;\r          for (var i = 0; i < allpolygons.length; i"\
	L"++){\r            if (allpolygons[i]==polygon) {\r        "\
	L"      IdMarker=i;\r            }\r          }\r  window.lo"\
	L"cation.href = \"jsevent://polygondblclick:id=\"+IdMarker; "\
	L"\r   });\r }\r \r function Label(opt_options,color,borderc"\
	L"olor,padding,fontname,fontcolor,fontsize) {\r  this.setVal"\
	L"ues(opt_options);\r  var span = this.span_ = document.crea"\
	L"teElement(\"div\");\r  span.style.cssText = \"position: re"\
	L"lative; left: -50%; top: -60px; \" +                      "\
	L" \"white-space: nowrap; font-size:\" + fontsize + \"px;\" "\
	L"+                       \"border: 1px solid \" + bordercol"\
	L"or + \"; \" +                       \"font-family:\" + fon"\
	L"tname + \"; color: \" + fontcolor + \";\"+                "\
	L"       \"padding: \" + padding + \"px; background-color: \""\
	L" + color + \";\";\r  var div = this.div_ = document.create"\
	L"Element(\"div\");\r  div.appendChild(span);\r  div.style.c"\
	L"ssText = \"position: absolute; display: none\";\r };\r Lab"\
	L"el.prototype = new google.maps.OverlayView;\r Label.protot"\
	L"ype.onAdd = function() {\r  var pane = this.getPanes().ove"\
	L"rlayLayer;\r  pane.appendChild(this.div_);\r  var me = thi"\
	L"s;\r  this.listeners_ = [\r    google.maps.event.addListen"\
	L"er(this, \"position_changed\",\r        function() { me.dr"\
	L"aw(); }),\r    google.maps.event.addListener(this, \"text_"\
	L"changed\",\r        function() { me.draw(); })\r  ];\r };\r"\
	L" Label.prototype.setText = function(text) {\r   if (this.s"\
	L"pan_) {\r   this.set(\"text\", text);\r   this.draw();   }"\
	L"\r }\r Label.prototype.hide = function() {\r   if (this.di"\
	L"v_) {\r     this.div_.style.visibility = \"hidden\";\r   }"\
	L"\r }\r Label.prototype.show = function() {\r   if (this.di"\
	L"v_) {\r     this.div_.style.visibility = \"visible\";\r   "\
	L"}\r }\r Label.prototype.onRemove = function() {\r  this.di"\
	L"v_.parentNode.removeChild(this.div_);\r  for (var i = 0, I"\
	L" = this.listeners_.length; i < I; ++i) {\r    google.maps."\
	L"event.removeListener(this.listeners_[i]);\r  }\r };\r Labe"\
	L"l.prototype.draw = function() {\r  var projection = this.g"\
	L"etProjection();\r  var position = projection.fromLatLngToD"\
	L"ivPixel(this.get(\"position\"));\r  var div = this.div_;\r"\
	L"  div.style.left = position.x + \"px\";\r  div.style.top ="\
	L" position.y + \"px\";\r  div.style.display = \"block\";\r "\
	L" div.style.zIndex = 999;\r  this.span_.innerHTML = this.ge"\
	L"t(\"text\").toString();\r };\r function createMapMarker(la"\
	L"t, lng, html, drag, vis, clickble, flaticon, dropanimation"\
	L", imageicon, index, labeltext, labelcolor, labelbordercolo"\
	L"r, labelpadding, labelfontname, labelfontcolor, labelfonts"\
	L"ize) {\r   var point = new google.maps.LatLng(parseFloat(l"\
	L"at),parseFloat(lng));\r     var pinImage = imageicon;\r   "\
	L"if (dropanimation==true) { \r     var markerOptions = { ma"\
	L"p: map, position: point, title: html , draggable:drag , vi"\
	L"sible:vis , clickable:clickble , flat:flaticon, animation:"\
	L" google.maps.Animation.DROP, icon: pinImage, zIndex: index"\
	L"};\r   } else {\r     var markerOptions = { map: map, posi"\
	L"tion: point, title: html , draggable:drag , visible:vis , "\
	L"clickable:clickble , flat:flaticon , icon: pinImage, zInde"\
	L"x: index };\r   } \r   var marker = new google.maps.Marker"\
	L"(markerOptions);\r   var infowindow = new google.maps.Info"\
	L"Window({});\r   allmarkers.push(marker);\r   allinfowindow"\
	L"s.push(infowindow);\r"
#define HTML_FILE_2 L"   var label = new Label({     map: map   }, labelcolor, l"\
	L"abelbordercolor, labelpadding, labelfontname, labelfontcol"\
	L"or, labelfontsize);\r   label.bindTo(\"position\", marker,"\
	L" \"position\");\r   label.set(\"text\", labeltext);\r   if"\
	L" (labeltext == \"\")\r     label.hide();\r   alllabels.pus"\
	L"h(label);\r   google.maps.event.addListener(infowindow, \""\
	L"closeclick\", function() {\r          IdMarker=-1;\r      "\
	L"    for (var i = 0; i < allmarkers.length; i++){\r        "\
	L"    if (allmarkers[i]==marker) {\r              IdMarker=i"\
	L";\r            }\r          }\r  window.location.href = \""\
	L"jsevent://infowindowcloseclick:id=\"+IdMarker; \r   });\r "\
	L"  google.maps.event.addListener(marker, \"click\", functio"\
	L"n() {\r          ptmarker=marker.getPosition()\r          "\
	L"IdMarker=-1;\r          for (var i = 0; i < allmarkers.len"\
	L"gth; i++){\r            if (allmarkers[i]==marker) {\r    "\
	L"          IdMarker=i;\r            }\r          }\r       "\
	L"   lat=parseFloat(ptmarker.lat());\r          lng=parseFlo"\
	L"at(ptmarker.lng());\r          title=marker.getTitle();\r "\
	L" window.location.href = \"jsevent://markerclick:title=\" +"\
	L" title + \"#id=\"+IdMarker+\"#lat=\"+lat+\"#lng=\"+lng; \r"\
	L"   });\r   google.maps.event.addListener(marker, \"dblclic"\
	L"k\", function() {\r          ptmarker=marker.getPosition()"\
	L"\r          IdMarker=-1;\r          for (var i = 0; i < al"\
	L"lmarkers.length; i++){\r            if (allmarkers[i]==mar"\
	L"ker) {\r              IdMarker=i;\r            }\r        "\
	L"  }\r          lat=parseFloat(ptmarker.lat());\r          "\
	L"lng=parseFloat(ptmarker.lng());\r          title=marker.ge"\
	L"tTitle();\r  window.location.href = \"jsevent://markerdblc"\
	L"lick:title=\" + title + \"#id=\"+IdMarker+\"#lat=\"+lat+\""\
	L"#lng=\"+lng; \r   });\r   google.maps.event.addListener(ma"\
	L"rker, \"dragstart\", function() {\r          ptmarker=mark"\
	L"er.getPosition()\r          for (var i = 0; i < allmarkers"\
	L".length; i++){\r            if (allmarkers[i]==marker) {\r"\
	L"              IdMarker=i;\r            }\r          }\r   "\
	L"       lat=parseFloat(ptmarker.lat());\r          lng=pars"\
	L"eFloat(ptmarker.lng());\r          title=marker.getTitle()"\
	L";\r  window.location.href = \"jsevent://markerdragstart:ti"\
	L"tle=\" + title + \"#id=\"+IdMarker+\"#lat=\"+lat+\"#lng=\""\
	L"+lng; \r   });\r    google.maps.event.addListener(marker, "\
	L"\"drag\", function() {\r          ptmarker=marker.getPosit"\
	L"ion()\r          for (var i = 0; i < allmarkers.length; i+"\
	L"+){\r            if (allmarkers[i]==marker) {\r           "\
	L"   IdMarker=i;\r            }\r          }\r          lat="\
	L"parseFloat(ptmarker.lat());\r          lng=parseFloat(ptma"\
	L"rker.lng());\r          title=marker.getTitle();\r  window"\
	L".location.href = \"jsevent://markerdrag:title=\" + title +"\
	L" \"#id=\"+IdMarker+\"#lat=\"+lat+\"#lng=\"+lng; \r    });\r"\
	L"   google.maps.event.addListener(marker, \"dragend\", func"\
	L"tion() {\r          ptmarker=marker.getPosition()\r       "\
	L"   for (var i = 0; i < allmarkers.length; i++){\r         "\
	L"   if (allmarkers[i]==marker) {\r              IdMarker=i;"\
	L"\r            }\r          }\r          lat=parseFloat(ptm"\
	L"arker.lat());\r          lng=parseFloat(ptmarker.lng());\r"\
	L"          title=marker.getTitle();\r  window.location.href"\
	L" = \"jsevent://markerdragend:title=\" + title + \"#id=\"+I"\
	L"dMarker+\"#lat=\"+lat+\"#lng=\"+lng; \r   });\r }\r \r fun"\
	L"ction startMarkerBounceAnimation(IdMarker) {\r   if (IdMar"\
	L"ker<allmarkers.length) {\r     allmarkers[IdMarker].setAni"\
	L"mation(google.maps.Animation.BOUNCE);\r   } else {\r  wind"\
	L"ow.location.href = \"jsevent://error:id=3\"; \r   }\r }\r "\
	L"\r function stopMarkerBounceAnimation(IdMarker) {\r   if ("\
	L"IdMarker<allmarkers.length) {\r     allmarkers[IdMarker].s"\
	L"etAnimation(null);\r   } else {\r  window.location.href = "\
	L"\"jsevent://error:id=3\"; \r   }\r }\r \r function deleteM"\
	L"apMarker(IdMarker) {\r   if (IdMarker<allmarkers.length) {"\
	L"\r     allmarkers[IdMarker].setMap(null);\r     allmarkers"\
	L".splice(IdMarker,1);\r     allinfowindows.splice(IdMarker,"\
	L"1);\r   } else {\r  window.location.href = \"jsevent://err"\
	L"or:id=3\"; \r   }\r   if (IdMarker<alllabels.length) {\r  "\
	L"   alllabels[IdMarker].setMap(null);\r     alllabels.splic"\
	L"e(IdMarker,1);\r   } else {\r  window.location.href = \"js"\
	L"event://error:id=3\"; \r   }\r }\r \r function deleteMapPo"\
	L"lyline(IdMarker) {\r   if (IdMarker<allpolylines.length) {"\
	L"\r     allpolylines[IdMarker].setMap(null);\r     allpolyl"\
	L"ines.splice(IdMarker,1);\r   } else {\r  window.location.h"\
	L"ref = \"jsevent://error:id=3\"; \r   }\r }\r \r function d"\
	L"eleteMapPolygon(IdMarker) {\r   if (IdMarker<allpolygons.l"\
	L"ength) {\r     allpolygons[IdMarker].setMap(null);\r     a"\
	L"llpolygons.splice(IdMarker,1);\r   } else {\r  window.loca"\
	L"tion.href = \"jsevent://error:id=3\"; \r   }\r }\r \r func"\
	L"tion deleteKMLLayer(IdLayer) {\r   if (IdLayer<allkmllayer"\
	L"s.length) {\r     allkmllayers[IdLayer].setMap(null);\r   "\
	L"  allkmllayers.splice(IdLayer,1);\r   } else {\r  window.l"\
	L"ocation.href = \"jsevent://error:id=3\"; \r   }\r }\r \r f"\
	L"unction openMarkerInfoWindowHtml(IdMarker, html) {\r   if "\
	L"(IdMarker<allmarkers.length) {\r     var marker = allmarke"\
	L"rs[IdMarker];\r     var infowindow = allinfowindows[IdMark"\
	L"er];\r     infowindow.setContent(html);\r     infowindow.o"\
	L"pen(map, marker);\r   } else {\r  window.location.href = \""\
	L"jsevent://error:id=3\"; \r   }\r }\r \r function closeMark"\
	L"erInfoWindowHtml(IdMarker) {\r   if (IdMarker<allmarkers.l"\
	L"ength) {\r     var marker = allmarkers[IdMarker];\r     va"\
	L"r infowindow = allinfowindows[IdMarker];\r     infowindow."\
	L"close();\r   } else {\r  window.location.href = \"jsevent:"\
	L"//error:id=3\"; \r   }\r }\r \r function deleteAllMapMarke"\
	L"r() {\r   for (i in allmarkers) {\r     allmarkers[i].setM"\
	L"ap(null);\r   }\r   allmarkers.splice(0,allmarkers.length)"\
	L";\r   allinfowindows.splice(0,allinfowindows.length);\r   "\
	L"for (i in alllabels) {\r     alllabels[i].setMap(null);\r "\
	L"  }\r   alllabels.splice(0,alllabels.length);\r }\r \r fun"\
	L"ction deleteAllMapPolyline() {\r   for (i in allpolylines)"\
	L" {\r     allpolylines[i].setMap(null);\r   }\r   allpolyli"\
	L"nes.splice(0,allpolylines.length);\r }\r \r function delet"\
	L"eAllMapPolygon() {\r   for (i in allpolygons) {\r     allp"\
	L"olygons[i].setMap(null);\r   }\r   allpolygons.splice(0,al"\
	L"lpolygons.length);\r }\r \r function deleteAllKMLLayer() {"\
	L"\r   for (i in allkmllayers) {\r     allkmllayers[i].setMa"\
	L"p(null);\r   }\r   allkmllayers.splice(0,allkmllayers.leng"\
	L"th);\r }\r \r function ShowTraffic() {\r   trafficLayer.se"\
	L"tMap(map);\r }\r \r function HideTraffic() {\r   trafficLa"\
	L"yer.setMap(null);\r }\r \r function ShowBicycling() {\r   "\
	L"bicyclingLayer.setMap(map);\r }\r \r function HideBicyling"\
	L"() {\r   bicyclingLayer.setMap(null);\r }\r \r function Sh"\
	L"owPanoramio() {\r   panoramioLayer.setMap(map);\r }\r \r f"\
	L"unction HidePanoramio() {\r   panoramioLayer.setMap(null);"\
	L"\r }\r \r function ShowCloud() {\r   cloudLayer.setMap(map"\
	L");\r }\r \r function HideCloud() {\r   cloudLayer.setMap(n"\
	L"ull);\r }\r \r function ShowWeather() {\r   weatherLayer.s"\
	L"etMap(map);\r }\r \r function HideWeather() {\r   weatherL"\
	L"ayer.setMap(null);\r }\r \r"
#define HTML_FILE_3 L" function initialize() {\r  var latlng = new google.maps.L"\
	L"atLng(%latitude%, %longitude%);\r var myStyles =[\r     {\r"\
	L"         featureType: \"poi\",\r         elementType: \"la"\
	L"bels\",\r         stylers: [\r               { visibility:"\
	L" \"%disablepoi%\" }\r         ]\r     }\r ];\r  var myOpti"\
	L"ons = {\r    navigationControlOptions: {\r      style: goo"\
	L"gle.maps.NavigationControlStyle.%controlstype%\r    },\r  "\
	L" panControl: %panControl%,\r   panControlOptions: {\r     "\
	L"position: google.maps.ControlPosition.%panControlPosition%"\
	L"\r   },\r   zoomControl: %zoomControl%,\r   zoomControlOpt"\
	L"ions: {\r     position: google.maps.ControlPosition.%zoomC"\
	L"ontrolPosition%,\r     style: google.maps.ZoomControlStyle"\
	L".%zoomControlStyle%   },\r   mapTypeControl: %mapTypeContr"\
	L"ol%,\r   mapTypeControlOptions: {\r     position: google.m"\
	L"aps.ControlPosition.%mapTypeControlPosition%,\r     style:"\
	L" google.maps.MapTypeControlStyle.%mapTypeControlStyle%   }"\
	L",\r   scaleControl: %scaleControl%,\r   scaleControlOption"\
	L"s: {\r     position: google.maps.ControlPosition.%scaleCon"\
	L"trolPosition%\r   },\r   streetViewControl: %streetViewCon"\
	L"trol%,\r   streetViewControlOptions: {\r     position: goo"\
	L"gle.maps.ControlPosition.%streetViewControlPosition%\r   }"\
	L",\r   overviewMapControl: %overviewMapControl%,\r   overvi"\
	L"ewMapControlOptions: {\r     opened: %overviewMapControlOp"\
	L"ened%\r   },\r   disableDoubleClickZoom: %disableDoubleCli"\
	L"ckZoom%,\r   draggable: %draggable%,\r   keyboardShortcuts"\
	L": %keyboardShortcuts%,\r   scrollwheel: %scrollwheel%,\r  "\
	L" disableDefaultUI: %disableDefaultUI%,\r   zoom: %zoom%,\r"\
	L"   center: latlng,\r   mapTypeId: google.maps.MapTypeId.%m"\
	L"aptype%,\r   styles: myStyles\r  };\r  streetviewService ="\
	L" new google.maps.StreetViewService();\r  trafficLayer = ne"\
	L"w google.maps.TrafficLayer();\r  bicyclingLayer = new goog"\
	L"le.maps.BicyclingLayer();\r  panoramioLayer = new google.m"\
	L"aps.panoramio.PanoramioLayer();\r  var myWeatherOptions = "\
	L"{\r   temperatureUnits: google.maps.weather.TemperatureUni"\
	L"t.%weatherTemperature%,\r   labelColor: google.maps.weathe"\
	L"r.LabelColor.%weatherLabelColor%,\r   suppressInfoWindows:"\
	L" %weatherSuppressInfoWinddows%,\r   windSpeedUnits: google"\
	L".maps.weather.WindSpeedUnit.%weatherWindSpeed%\r  };\r  cl"\
	L"oudLayer = new google.maps.weather.CloudLayer()\r  weather"\
	L"Layer = new google.maps.weather.WeatherLayer(myWeatherOpti"\
	L"ons);\r  map = new google.maps.Map(document.getElementById"\
	L"(\"map_canvas\"), myOptions);\r    trafficLayer.setMap(%sh"\
	L"owtraffic%);\r    bicyclingLayer.setMap(%showbicycling%);\r"\
	L"    panoramioLayer.setMap(%showpanoramio%);\r    cloudLaye"\
	L"r.setMap(%showcloud%);\r    weatherLayer.setMap(%showweath"\
	L"er%);\r    streetviewPanorama = map.getStreetView();\r  if"\
	L" (%SVVisible%){\r    streetviewPanorama.setVisible(true); "\
	L"   showStreetview(\"%SVLat%\", \"%SVLng%\", %SVHeading%, %"\
	L"SVZoom%, %SVPitch%);\r  }\r    google.maps.event.addListen"\
	L"er(map, \"tilesloaded\", function() {\r        google.maps"\
	L".event.addListener(streetviewPanorama, \"position_changed\""\
	L", function() {\r          NewPosition = streetviewPanorama"\
	L".getPosition();\r          var lat = NewPosition.lat();\r "\
	L"         var lng = NewPosition.lng();\r          window.lo"\
	L"cation.href = \"jsevent://streetviewmove:lat=\" + lat + \""\
	L"#lng=\" + lng+\"#x=\"+mx+\"#y=\"+my; \r        });\r      "\
	L"  google.maps.event.addListener(streetviewPanorama, \"pov_"\
	L"changed\", function() {\r        var heading = streetviewP"\
	L"anorama.getPov().heading;\r        if (heading)\r         "\
	L" heading = parseInt(heading);\r        else\r          hea"\
	L"ding = -1;\r        var pitch = streetviewPanorama.getPov("\
	L").pitch;\r        if (pitch)\r          pitch = parseInt(p"\
	L"itch);\r        else\r          pitch = -1;\r        var z"\
	L"oom = streetviewPanorama.getPov().zoom;\r        if (zoom)"\
	L"\r          zoom = parseInt(zoom);\r        else\r        "\
	L"  zoom = -1;\r          window.location.href = \"jsevent:/"\
	L"/streetviewchange:heading=\" + heading + \"#pitch=\" + pit"\
	L"ch + \"#zoom=\" + zoom; \r        });\r      window.locati"\
	L"on.href = \"jsevent://tilesload\"; \r    });\r    google.m"\
	L"aps.event.addListener(map, \"click\", function(event) {\r "\
	L"        var ClickLatLng = event.latLng;\r         if (Clic"\
	L"kLatLng) {\r            var lat = ClickLatLng.lat();\r    "\
	L"        var lng = ClickLatLng.lng();\r  window.location.hr"\
	L"ef = \"jsevent://click:lat=\"+lat+\"#lng=\"+lng+\"#x=\"+mx"\
	L"+\"#y=\"+my; \r         }\r    });\r    google.maps.event."\
	L"addListener(map, \"dblclick\", function(event) {\r        "\
	L" var ClickLatLng = event.latLng;\r         if (ClickLatLng"\
	L") {\r            var lat = ClickLatLng.lat();\r           "\
	L" var lng = ClickLatLng.lng();\r  window.location.href = \""\
	L"jsevent://dblclick:lat=\"+lat+\"#lng=\"+lng+\"#x=\"+mx+\"#"\
	L"y=\"+my; \r         }\r    });\r    google.maps.event.addL"\
	L"istener(map, \"dragstart\", function() {\r         var ptc"\
	L"enter=map.getCenter();\r         var lat=ptcenter.lat();\r"\
	L"         var lng=ptcenter.lng();\r  window.location.href ="\
	L" \"jsevent://dragstart:lat=\"+lat+\"#lng=\"+lng+\"#x=\"+mx"\
	L"+\"#y=\"+my; \r    });\r    google.maps.event.addListener("\
	L"map, \"dragend\", function() {\r         var ptcenter=map."\
	L"getCenter();\r         var lat=ptcenter.lat();\r         v"\
	L"ar lng=ptcenter.lng();\r  window.location.href = \"jsevent"\
	L"://dragend:lat=\"+lat+\"#lng=\"+lng+\"#x=\"+mx+\"#y=\"+my;"\
	L" \r    });\r    google.maps.event.addListener(map, \"drag\""\
	L", function() {\r         var ptcenter=map.getCenter();\r  "\
	L"       var lat=ptcenter.lat();\r         var lng=ptcenter."\
	L"lng();\r  window.location.href = \"jsevent://drag:lat=\"+l"\
	L"at+\"#lng=\"+lng+\"#x=\"+mx+\"#y=\"+my; \r    });\r    goo"\
	L"gle.maps.event.addListener(map, \"idle\", function() {\r  "\
	L"window.location.href = \"jsevent://idle\";\r    });\r    g"\
	L"oogle.maps.event.addListener(map, \"maptypeid_changed\", f"\
	L"unction() {\r         var TypeMap=map.getMapTypeId();\r   "\
	L"      var IdTypeMap=0;\r         switch(TypeMap)\r        "\
	L" {\r         case google.maps.MapTypeId.ROADMAP:\r        "\
	L"   IdTypeMap=0;\r           break\r         case google.ma"\
	L"ps.MapTypeId.SATELLITE:\r           IdTypeMap=1;\r        "\
	L"   break\r         case google.maps.MapTypeId.HYBRID:\r   "\
	L"        IdTypeMap=2;\r           break\r         case goog"\
	L"le.maps.MapTypeId.TERRAIN:\r           IdTypeMap=3;\r     "\
	L"      break\r         }\r  window.location.href = \"jseven"\
	L"t://typeidchange:maptype=\"+IdTypeMap; \r    });\r    goog"\
	L"le.maps.event.addListener(map, \"zoom_changed\", function("\
	L") {\r         var ZoomLevel = map.getZoom();\r  window.loc"\
	L"ation.href = \"jsevent://zoomchange:zoomlevel=\"+ZoomLevel"\
	L"; \r    });\r }\r \r google.maps.event.addDomListener(wind"\
	L"ow, \"load\", initialize);\r \r  function SetValues()\r   "\
	L" {\r    mx = window.event.clientX;\r    my = window.event."\
	L"clientY;\r    }\rfunction touchStart(event) {\r  var allTo"\
	L"uches = event.touches;\r  for (var i = 0; i < allTouches.l"\
	L"ength; i++){\r    mx = event.touches[i].pageX;\r    my = e"\
	L"vent.touches[i].pageY;\r  }\r}\r</script>\r</head>\r<body "\
	L">\r<div id=\"map_canvas\" \r onmousedown=SetValues();\r></"\
	L"div>\r</body>\r</html>"
}	/* namespace Tmswebgmapsconst */
}	/* namespace Fmx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX_TMSWEBGMAPSCONST)
using namespace Fmx::Tmswebgmapsconst;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMX)
using namespace Fmx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmx_TmswebgmapsconstHPP
