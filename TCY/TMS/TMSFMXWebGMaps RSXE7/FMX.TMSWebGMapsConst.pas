{***************************************************************************)
{ TMS FMX WebGMaps component                                                }
{ for Delphi                                                                }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 2013 - 2014                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit FMX.TMSWebGMapsConst;

interface

const
  HTML_BLANK_PAGE       = 'about:blank';
  JAVASCRIPT            = 'JavaScript';
  MAP_TYPE_PREFIX       = 'google.maps.MapTypeId.';
  CONTROL_POSITION_TEXT = '%controlposition%';

  CONTROL_DEFAULT       = 'DEFAULT';
  CONTROL_ANDROID       = 'ANDROID';
  CONTROL_SMALL         = 'SMALL';
  CONTROL_ZOOMPAN       = 'ZOOM_PAN';

  POSITION_BOTTOMCENTER = 'BOTTOM_CENTER';
  POSITION_BOTTOMLEFT   = 'BOTTOM_LEFT';
  POSITION_BOTTOMRIGHT  = 'BOTTOM_RIGHT';
  POSITION_LEFTBOTTOM   = 'LEFT_BOTTOM';
  POSITION_LEFTCENTER   = 'LEFT_CENTER';
  POSITION_LEFTTOP      = 'LEFT_TOP';
  POSITION_RIGHTBOTTOM  = 'RIGHT_BOTTOM';
  POSITION_RIGHTCENTER  = 'RIGHT_CENTER';
  POSITION_RIGHTTOP     = 'RIGHT_TOP';
  POSITION_TOPCENTER    = 'TOP_CENTER';
  POSITION_TOPLEFT      = 'TOP_LEFT';
  POSITION_TOPRIGHT     = 'TOP_RIGHT';

  ZOOM_DEFAULT          = 'DEFAULT';
  ZOOM_LARGE            = 'LARGE';
  ZOOM_SMALL            = 'SMALL';

  MAPTYPE_DEFAULT       = 'DEFAULT';
  MAPTYPE_DROPDOWNMENU  = 'DROPDOWN_MENU';
  MAPTYPE_HORIZONTALBAR = 'HORIZONTAL_BAR';

  MAP_DEFAULT           = 'ROADMAP';
  MAP_SATELLITE         = 'SATELLITE';
  MAP_HYBRID            = 'HYBRID';
  MAP_TERRAIN           = 'TERRAIN';

  GIF_RESSOURCE_NAME    = 'LOADER';
  GIF_FORMAT            = 'GIF';

  DEFAULT_ZOOM          = 10;
  DEFAULT_LATITUDE      = 48.85904;
  DEFAULT_LONGITUDE     = 2.294297;
  DEFAULT_WIDTH         = 100;
  DEFAULT_HEIGHT        = 100;

  GEOCODING_BASE_URL                = 'http://maps.googleapis.com/maps/api/geocode/xml?';
  GEOCODING_START_URL               = 'address=';
  GEOCODING_REVERSESTART_URL        = 'latlng=';
  GEOCODING_END_URL                 = '&sensor=false';
  GEOCODING_STATUS                  = 'status';
  GEOCODING_LATITUDE                = 'lat';
  GEOCODING_LONGITUDE               = 'lng';
  GEOCODING_LOCATION_TYPE           = 'location_type';
  GEOCODING_ADDRESS                 = 'formatted_address';
  GEOCODINF_STATUS_OK               = 'OK';
  GEOCODINF_STATUS_ZERO_RESULTS     = 'ZERO_RESULTS';
  GEOCODINF_STATUS_OVER_QUERY_LIMIT = 'OVER_QUERY_LIMIT';
  GEOCODINF_STATUS_REQUEST_DENIED   = 'REQUEST_DENIED';
  GEOCODINF_STATUS_INVALID_REQUEST  = 'INVALID_REQUEST';

  GEOCODING_LOCTYPE_ROOFTOP            = 'ROOFTOP';
  GEOCODING_LOCTYPE_RANGE_INTERPOLATED = 'RANGE_INTERPOLATED';
  GEOCODING_LOCTYPE_GEOMETRIC_CENTER   = 'GEOMETRIC_CENTER';
  GEOCODING_LOCTYPE_APPROXIMATE        = 'APPROXIMATE';

  WEATHER_TEMPERATURE_CELSIUS             = 'CELSIUS';
  WEATHER_TEMPERATURE_FAHRENHEIT          = 'FAHRENHEIT';
  WEATHER_WIND_SPEED_KILOMETERS_PER_HOUR  = 'KILOMETERS_PER_HOUR';
  WEATHER_WIND_SPEED_METERS_PER_SECOND    = 'METERS_PER_SECOND';
  WEATHER_WIND_SPEED_MILES_PER_HOUR       = 'MILES_PER_HOUR';
  WEATHER_LABEL_COLOR_BLACK               = 'BLACK';
  WEATHER_LABEL_COLOR_WHITE               = 'WHITE';

  HTML_FILE_1 =
                '<!DOCTYPE html>' + #13 +
                '<html>' + #13 +
                '<head>' + #13 +
                '<meta name="viewport" content="initial-scale=1.0, user-scalable=yes" /> '+
                '<meta http-equiv="content-type" content="text/html; charset=UTF-8" />' + #13 +

                '<style type="text/css">' + #13 +
                ' html, body, #map_canvas {' + #13 +
                '  margin: 0;' + #13 +
                '  padding: 0;' + #13 +
                '  height: 100%' + #13 +
                ' }' + #13 +
                '</style>' + #13 +

                '<script type="text/javascript" src="http://maps.google.com/maps/api/js?%apikey%sensor=true&libraries=panoramio,weather&language=%lang%"></script>' + #13 +

                '<script type="text/javascript">' + #13 +
                ' var map;' + #13 +
                ' var streetviewService;' + #13 +
                ' var streetviewPanorama;' + #13 +
                ' var allmarkers = [];' + #13 +
                ' var alllabels = [];' + #13 +
                ' var allpolylines = [];' + #13 +
                ' var allpolygons = [];' + #13 +
                ' var allkmllayers = [];' + #13 +
                ' var allinfowindows = [];' + #13 +
                ' var trafficLayer;' + #13 +
                ' var bicyclingLayer;' + #13 +
                ' var panoramioLayer;' + #13 +
                ' var cloudLayer;' + #13 +
                ' var weatherLayer;' + #13 +
                ' var directionsDisplay;' + #13 +
                ' var directionsService = new google.maps.DirectionsService();' + #13 +
                ' var mx = 0;' + #13 +
                ' var my = 0;' + #13 +

                ' function setzoommap(newzoom) {' + #13 +
                '   var OldZoomLevel = parseFloat(map.getZoom());' + #13 +
                '   var NewzoomLevel = parseFloat(newzoom);' + #13 +
                '   if (OldZoomLevel!=NewzoomLevel) {' + #13 +
                '     map.setZoom(newzoom);' + #13 +
                '   }' + #13 +
                ' }' + #13 +
                ' ' + #13 +

                ' function getBounds() {' + #13 +
                '   var result = map.getBounds();' + #13 +
                '   var ne = result.getNorthEast();' + #13 +
                '   var sw = result.getSouthWest();' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://boundsretrieved:nelat="+ne.lat()+"#nelng="+ne.lng()+"#swlat="+sw.lat()+"#swlng="+sw.lng()); '+ #13 + //event
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://boundsretrieved:nelat="+ne.lat()+"#nelng="+ne.lng()+"#swlat="+sw.lat()+"#swlng="+sw.lng(); '+ #13 + //event
                {$ENDIF}
                ' }' + #13 +
                ' ' + #13 +

                ' function showStreetview(lat, lng, valhead, valzm, valptch) {' + #13 +
                '   var valheading = parseFloat(valhead);' + #13 +
                '   var valzoom = parseFloat(valzm);' + #13 +
                '   var valpitch = parseFloat(valptch);' + #13 +
                '   var point = new google.maps.LatLng(parseFloat(lat),parseFloat(lng));' + #13 +
                '   streetviewPanorama.setPov({' + #13 +
                '                              heading: valheading,' + #13 +
                '                              zoom: valzoom,' + #13 +
                '                              pitch: valpitch});' + #13 +
                '   streetviewService.getPanoramaByLocation(point, 100, processStreeviewData);' + #13 +
                ' }' + #13 +
                ' ' + #13 +
                ' function processStreeviewData(data, status) {' + #13 +
                '   if (status == google.maps.StreetViewStatus.OK) {' + #13 +
                '     streetviewPanorama.setPano(data.location.pano);' + #13 +
                '     streetviewPanorama.setVisible(true);' + #13 +
                '   } else {' + #13 +
                '     streetviewPanorama.setVisible(false);' + #13 +
                '     if (status == google.maps.StreetViewStatus.UNKNOWN_ERROR) {' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://error:errorid=4"); '+ #13 +
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://error:errorid=4"; '+ #13 +
                {$ENDIF}
                '     } else {' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://error:errorid=5"); '+ #13 +
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://error:errorid=5"; '+ #13 +
                {$ENDIF}
                '     }' + #13 +
                '   }' + #13 +
                ' }' + #13 +
                ' ' + #13 +

                //Directions
                ' function calcDirections(start, end, travelmode, avoidhighways, avoidtolls, wp, optwp) {' + #13 +
                ' directionsDisplay = new google.maps.DirectionsRenderer();' + #13 +
                ' directionsDisplay.setMap(map);' + #13 +
                '  var request = {' + #13 +
                '    origin: start,' + #13 +
                '    destination: end,' + #13 +
                '    travelMode: travelmode,' + #13 +
                '    avoidHighways: avoidhighways,' + #13 +
                '    avoidTolls: avoidtolls,' + #13 +
                '    waypoints: wp,' + #13 +
                '    optimizeWaypoints: optwp' + #13 +
                '  };' + #13 +
                '  directionsService.route(request, function(result, status) {' + #13 +
                '    if (status == google.maps.DirectionsStatus.OK) {' + #13 +
                '      directionsDisplay.setDirections(result);' + #13 +
                '    }' + #13 +
                '  });' + #13 +
                '}' + #13 +

                //KML layer
                ' function addKMLLayer(url, zoomtobounds) {' + #13 +
                '   var kmlOptions = {' + #13 +
                '     clickable: true,' + #13 +
                '     suppressInfoWindows: false,' + #13 +
                '     preserveViewport: zoomtobounds,' + #13 +
                '     map: map' + #13 +
                '   };' + #13 +
                '   var kmlLayer = new google.maps.KmlLayer(url, kmlOptions);' + #13 +
                '   allkmllayers.push(kmlLayer);' + #13 +
                '   google.maps.event.addListener(kmlLayer, "status_changed", function() {' + #13 +
                '     var status = kmlLayer.getStatus();' + #13 +
                '     if (status != "OK")' + #13 +
                ' 	    alert("KML Layer ''" + kmlLayer.getUrl() + "'' status: " + status);' + #13 +
                '   })' + #13 +
                '   google.maps.event.addListener(kmlLayer, "click", function(event) {' + #13 +
                '          IdKMLLayer=-1;' + #13 +
                '          for (var i = 0; i < allkmllayers.length; i++){' + #13 +
                '            if (allkmllayers[i]==kmlLayer) {' + #13 +
                '              IdKMLLayer=i;' + #13 +
                '            }' + #13 +
                '          }' + #13 +
                '          lat=parseFloat(event.latLng.lat());' + #13 +
                '          lng=parseFloat(event.latLng.lng());' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://kmllayerclick:title=" + event.featureData.name + "#id="+IdKMLLayer+"#lat="+lat+"#lng="+lng); '+ #13 +
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://kmllayerclick:title=" + event.featureData.name + "#id="+IdKMLLayer+"#lat="+lat+"#lng="+lng; '+ #13 +
                {$ENDIF}
                '   });' + #13 +
                ' }' + #13 +

                ' function updateMapPolyline(index, clickable, editable, icons, path, color, width, opacity, visible, geodesic, index) {' + #13 +
                '   var polylineOptions = { map: map, icons: icons, clickable: clickable, editable: editable , path: path , strokeColor: color, strokeWeight: width, strokeOpacity: opacity, visible: visible, geodesic: geodesic, zIndex: index };' + #13 +
                '   allpolylines[index].setOptions(polylineOptions);' + #13 +
                '   }' + #13 +

                ' function createMapPolyline(clickable, editable, icons, path, color, width, opacity, visible, geodesic, index) {' + #13 +
                '   var polylineOptions = { map: map, icons: icons, clickable: clickable, editable: editable , path: path , strokeColor: color, strokeWeight: width, strokeOpacity: opacity, visible: visible, geodesic: geodesic, zIndex: index };' + #13 +
                '   var polyline = new google.maps.Polyline(polylineOptions);' + #13 +
                '   allpolylines.push(polyline);' + #13 +
                '   google.maps.event.addListener(polyline, "click", function() {' + #13 +
                '          IdMarker=-1;' + #13 +
                '          for (var i = 0; i < allpolylines.length; i++){' + #13 +
                '            if (allpolylines[i]==polyline) {' + #13 +
                '              IdMarker=i;' + #13 +
                '            }' + #13 +
                '          }' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://polylineclick:id="+IdMarker); '+ #13 +
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://polylineclick:id="+IdMarker; '+ #13 +
                {$ENDIF}
                '   });' + #13 +
                '   google.maps.event.addListener(polyline, "dblclick", function() {' + #13 +
                '          IdMarker=-1;' + #13 +
                '          for (var i = 0; i < allpolylines.length; i++){' + #13 +
                '            if (allpolylines[i]==polyline) {' + #13 +
                '              IdMarker=i;' + #13 +
                '            }' + #13 +
                '          }' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://polylinedblclick:id="+IdMarker); '+ #13 +
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://polylinedblclick:id="+IdMarker; '+ #13 +
                {$ENDIF}
                '   });' + #13 +
                ' }' + #13 +
                ' ' + #13 +
                ' function updateMapPolygon(index, clickable, editable, paths, bgcolor, bordercolor, borderwidth, bgopacity, borderopacity, visible, geodesic, zindex, ptype, centerlat, centerlng, radius, nelat, nelng, swlat, swlng) {' + #13 +
                '   if (ptype == "circle") {' + #13 +
                '   var center = new google.maps.LatLng(parseFloat(centerlat),parseFloat(centerlng));' + #13 +
                '   var polygonOptions = ' +
                '{ map: map, clickable: clickable, editable: editable , center: center, radius: radius , fillColor: bgcolor , ' +
                'fillOpacity: bgopacity, strokeColor: bordercolor, strokeWeight: borderwidth, strokeOpacity: borderopacity, visible: visible, zIndex: zindex };' + #13 +
                '   } else if (ptype == "rectangle") {' + #13 +
                '   var bounds = new google.maps.LatLngBounds(new google.maps.LatLng(swlat, swlng), new google.maps.LatLng(nelat, nelng));' + #13 +
                '   var polygonOptions = ' +
                '{ map: map, clickable: clickable, editable: editable , bounds: bounds , fillColor: bgcolor , ' +
                'fillOpacity: bgopacity, strokeColor: bordercolor, strokeWeight: borderwidth, strokeOpacity: borderopacity, visible: visible, zIndex: zindex };' + #13 +
                '   } else {' + #13 +
                '   var polygonOptions = ' +
                '{ map: map, clickable: clickable, editable: editable , paths: paths , fillColor: bgcolor , ' +
                'fillOpacity: bgopacity, strokeColor: bordercolor, strokeWeight: borderwidth, strokeOpacity: borderopacity, visible: visible, geodesic: geodesic, zIndex: zindex };' + #13 +
                '   }' + #13 +
                '   allpolygons[index].setOptions(polygonOptions);' + #13 +
                '}' + #13 +

                ' function createMapPolygon(clickable, editable, paths, bgcolor, bordercolor, borderwidth, bgopacity, borderopacity, visible, geodesic, zindex, ptype, centerlat, centerlng, radius, nelat, nelng, swlat, swlng) {' + #13 +
                '   if (ptype == "circle") {' + #13 +
                '   var center = new google.maps.LatLng(parseFloat(centerlat),parseFloat(centerlng));' + #13 +
                '   var circleOptions = ' +
                '{ map: map, clickable: clickable, editable: editable , center: center, radius: radius , fillColor: bgcolor , ' +
                'fillOpacity: bgopacity, strokeColor: bordercolor, strokeWeight: borderwidth, strokeOpacity: borderopacity, visible: visible, zIndex: zindex };' + #13 +
                '   var polygon = new google.maps.Circle(circleOptions);' + #13 +
                '   } else if (ptype == "rectangle") {' + #13 +
                '   var bounds = new google.maps.LatLngBounds(new google.maps.LatLng(swlat, swlng), new google.maps.LatLng(nelat, nelng));' + #13 +
                '   var rectOptions = ' +
                '{ map: map, clickable: clickable, editable: editable , bounds: bounds , fillColor: bgcolor , ' +
                'fillOpacity: bgopacity, strokeColor: bordercolor, strokeWeight: borderwidth, strokeOpacity: borderopacity, visible: visible, zIndex: zindex };' + #13 +
                '   var polygon = new google.maps.Rectangle(rectOptions);' + #13 +
                '   } else {' + #13 +
                '   var polygonOptions = ' +
                '{ map: map, clickable: clickable, editable: editable , paths: paths , fillColor: bgcolor , ' +
                'fillOpacity: bgopacity, strokeColor: bordercolor, strokeWeight: borderwidth, strokeOpacity: borderopacity, visible: visible, geodesic: geodesic, zIndex: zindex };' + #13 +
                '   var polygon = new google.maps.Polygon(polygonOptions);' + #13 +
                '   }' + #13 +
                '   allpolygons.push(polygon);' + #13 +
                '   google.maps.event.addListener(polygon, "click", function() {' + #13 +
                '          IdMarker=-1;' + #13 +
                '          for (var i = 0; i < allpolygons.length; i++){' + #13 +
                '            if (allpolygons[i]==polygon) {' + #13 +
                '              IdMarker=i;' + #13 +
                '            }' + #13 +
                '          }' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://polygonclick:id="+IdMarker); '+ #13 +
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://polygonclick:id="+IdMarker; '+ #13 +
                {$ENDIF}
                '   });' + #13 +
                '   google.maps.event.addListener(polygon, "dblclick", function() {' + #13 +
                '          IdMarker=-1;' + #13 +
                '          for (var i = 0; i < allpolygons.length; i++){' + #13 +
                '            if (allpolygons[i]==polygon) {' + #13 +
                '              IdMarker=i;' + #13 +
                '            }' + #13 +
                '          }' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://polygondblclick:id="+IdMarker); '+ #13 +
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://polygondblclick:id="+IdMarker; '+ #13 +
                {$ENDIF}
                '   });' + #13 +
                ' }' + #13 +
                ' ' + #13 +

                ' function Label(opt_options,color,bordercolor,padding,fontname,fontcolor,fontsize) {' + #13 +
                '  this.setValues(opt_options);' + #13 +

                '  var span = this.span_ = document.createElement("div");' + #13 +
                '  span.style.cssText = "position: relative; left: -50%; top: -60px; " +' +
                '                       "white-space: nowrap; font-size:" + fontsize + "px;" +' +
                '                       "border: 1px solid " + bordercolor + "; " +' +
                '                       "font-family:" + fontname + "; color: " + fontcolor + ";"+' +
                '                       "padding: " + padding + "px; background-color: " + color + ";";' + #13 +

                '  var div = this.div_ = document.createElement("div");' + #13 +
                '  div.appendChild(span);' + #13 +
                '  div.style.cssText = "position: absolute; display: none";' + #13 +
                ' };' + #13 +
                ' Label.prototype = new google.maps.OverlayView;' + #13 +

                ' Label.prototype.onAdd = function() {' + #13 +
                '  var pane = this.getPanes().overlayLayer;' + #13 +
                '  pane.appendChild(this.div_);' + #13 +

                '  var me = this;' + #13 +
                '  this.listeners_ = [' + #13 +
                '    google.maps.event.addListener(this, "position_changed",' + #13 +
                '        function() { me.draw(); }),' + #13 +
                '    google.maps.event.addListener(this, "text_changed",' + #13 +
                '        function() { me.draw(); })' + #13 +
                '  ];' + #13 +
                ' };' + #13 +

                ' Label.prototype.setText = function(text) {' + #13 +
                '   if (this.span_) {' + #13 +
                '   this.set("text", text);'+ #13 +
                '   this.draw();'+
                '   }' + #13 +
                ' }' + #13 +

                ' Label.prototype.hide = function() {' + #13 +
                '   if (this.div_) {' + #13 +
                '     this.div_.style.visibility = "hidden";' + #13 +
                '   }' + #13 +
                ' }' + #13 +

                ' Label.prototype.show = function() {' + #13 +
                '   if (this.div_) {' + #13 +
                '     this.div_.style.visibility = "visible";' + #13 +
                '   }' + #13 +
                ' }' + #13 +

                ' Label.prototype.onRemove = function() {' + #13 +
                '  this.div_.parentNode.removeChild(this.div_);' + #13 +
                '  for (var i = 0, I = this.listeners_.length; i < I; ++i) {' + #13 +
                '    google.maps.event.removeListener(this.listeners_[i]);' + #13 +
                '  }' + #13 +
                ' };' + #13 +

                ' Label.prototype.draw = function() {' + #13 +
                '  var projection = this.getProjection();' + #13 +
                '  var position = projection.fromLatLngToDivPixel(this.get("position"));' + #13 +

                '  var div = this.div_;' + #13 +
                '  div.style.left = position.x + "px";' + #13 +
                '  div.style.top = position.y + "px";' + #13 +
                '  div.style.display = "block";' + #13 +
                '  div.style.zIndex = 999;' + #13 +

                '  this.span_.innerHTML = this.get("text").toString();' + #13 +
                ' };' + #13 +

                ' function createMapMarker(lat, lng, html, drag, vis, clickble, flaticon, dropanimation, imageicon, index, labeltext, labelcolor, labelbordercolor, labelpadding, labelfontname, labelfontcolor, labelfontsize) {' + #13 +
                '   var point = new google.maps.LatLng(parseFloat(lat),parseFloat(lng));' + #13 +
                '     var pinImage = imageicon;' + #13 +
                '   if (dropanimation==true) { ' + #13 +
                '     var markerOptions = { map: map, position: point, title: html , draggable:drag , visible:vis , clickable:clickble , flat:flaticon, animation: google.maps.Animation.DROP, icon: pinImage, zIndex: index};' + #13 +
                '   } else {' + #13 +
                '     var markerOptions = { map: map, position: point, title: html , draggable:drag , visible:vis , clickable:clickble , flat:flaticon , icon: pinImage, zIndex: index };' + #13 +
                '   } ' + #13 +
                '   var marker = new google.maps.Marker(markerOptions);' + #13 +
                '   var infowindow = new google.maps.InfoWindow({});' + #13 +
                '   allmarkers.push(marker);' + #13 +
                '   allinfowindows.push(infowindow);' + #13;


  HTML_FILE_2 = //Add Label
                '   var label = new Label({'+
                '     map: map'+
                '   }, labelcolor, labelbordercolor, labelpadding, labelfontname, labelfontcolor, labelfontsize);'+ #13 +
                '   label.bindTo("position", marker, "position");'+ #13 +
                '   label.set("text", labeltext);'+ #13 +
                '   if (labeltext == "")'+ #13 +
                '     label.hide();'+ #13 +
                '   alllabels.push(label);' + #13 +
                '   google.maps.event.addListener(infowindow, "closeclick", function() {' + #13 +
                '          IdMarker=-1;' + #13 +
                '          for (var i = 0; i < allmarkers.length; i++){' + #13 +
                '            if (allmarkers[i]==marker) {' + #13 +
                '              IdMarker=i;' + #13 +
                '            }' + #13 +
                '          }' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://infowindowcloseclick:id="+IdMarker); '+ #13 +
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://infowindowcloseclick:id="+IdMarker; '+ #13 +
                {$ENDIF}
                '   });' + #13 +
                '   google.maps.event.addListener(marker, "click", function() {' + #13 +
                '          ptmarker=marker.getPosition()' + #13 +
                '          IdMarker=-1;' + #13 +
                '          for (var i = 0; i < allmarkers.length; i++){' + #13 +
                '            if (allmarkers[i]==marker) {' + #13 +
                '              IdMarker=i;' + #13 +
                '            }' + #13 +
                '          }' + #13 +
                '          lat=parseFloat(ptmarker.lat());' + #13 +
                '          lng=parseFloat(ptmarker.lng());' + #13 +
                '          title=marker.getTitle();' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://markerclick:title=" + title + "#id="+IdMarker+"#lat="+lat+"#lng="+lng); '+ #13 +
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://markerclick:title=" + title + "#id="+IdMarker+"#lat="+lat+"#lng="+lng; '+ #13 +
                {$ENDIF}
                '   });' + #13 +
                '   google.maps.event.addListener(marker, "dblclick", function() {' + #13 +
                '          ptmarker=marker.getPosition()' + #13 +
                '          IdMarker=-1;' + #13 +
                '          for (var i = 0; i < allmarkers.length; i++){' + #13 +
                '            if (allmarkers[i]==marker) {' + #13 +
                '              IdMarker=i;' + #13 +
                '            }' + #13 +
                '          }' + #13 +
                '          lat=parseFloat(ptmarker.lat());' + #13 +
                '          lng=parseFloat(ptmarker.lng());' + #13 +
                '          title=marker.getTitle();' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://markerdblclick:title=" + title + "#id="+IdMarker+"#lat="+lat+"#lng="+lng); '+ #13 +
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://markerdblclick:title=" + title + "#id="+IdMarker+"#lat="+lat+"#lng="+lng; '+ #13 +
                {$ENDIF}
                '   });' + #13 +
                '   google.maps.event.addListener(marker, "dragstart", function() {' + #13 +
                '          ptmarker=marker.getPosition()' + #13 +
                '          for (var i = 0; i < allmarkers.length; i++){' + #13 +
                '            if (allmarkers[i]==marker) {' + #13 +
                '              IdMarker=i;' + #13 +
                '            }' + #13 +
                '          }' + #13 +
                '          lat=parseFloat(ptmarker.lat());' + #13 +
                '          lng=parseFloat(ptmarker.lng());' + #13 +
                '          title=marker.getTitle();' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://markerdragstart:title=" + title + "#id="+IdMarker+"#lat="+lat+"#lng="+lng); '+ #13 +
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://markerdragstart:title=" + title + "#id="+IdMarker+"#lat="+lat+"#lng="+lng; '+ #13 +
                {$ENDIF}
                '   });' + #13 +
                '    google.maps.event.addListener(marker, "drag", function() {' + #13 +
                '          ptmarker=marker.getPosition()' + #13 +
                '          for (var i = 0; i < allmarkers.length; i++){' + #13 +
                '            if (allmarkers[i]==marker) {' + #13 +
                '              IdMarker=i;' + #13 +
                '            }' + #13 +
                '          }' + #13 +
                '          lat=parseFloat(ptmarker.lat());' + #13 +
                '          lng=parseFloat(ptmarker.lng());' + #13 +
                '          title=marker.getTitle();' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://markerdrag:title=" + title + "#id="+IdMarker+"#lat="+lat+"#lng="+lng); '+ #13 +
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://markerdrag:title=" + title + "#id="+IdMarker+"#lat="+lat+"#lng="+lng; '+ #13 +
                {$ENDIF}
                '    });' + #13 +
                '   google.maps.event.addListener(marker, "dragend", function() {' + #13 +
                '          ptmarker=marker.getPosition()' + #13 +
                '          for (var i = 0; i < allmarkers.length; i++){' + #13 +
                '            if (allmarkers[i]==marker) {' + #13 +
                '              IdMarker=i;' + #13 +
                '            }' + #13 +
                '          }' + #13 +
                '          lat=parseFloat(ptmarker.lat());' + #13 +
                '          lng=parseFloat(ptmarker.lng());' + #13 +
                '          title=marker.getTitle();' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://markerdragend:title=" + title + "#id="+IdMarker+"#lat="+lat+"#lng="+lng); '+ #13 +
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://markerdragend:title=" + title + "#id="+IdMarker+"#lat="+lat+"#lng="+lng; '+ #13 +
                {$ENDIF}
                '   });' + #13 +
                ' }' + #13 +
                ' ' + #13 +
                ' function startMarkerBounceAnimation(IdMarker) {' + #13 +
                '   if (IdMarker<allmarkers.length) {' + #13 +
                '     allmarkers[IdMarker].setAnimation(google.maps.Animation.BOUNCE);' + #13 +
                '   } else {' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://error:id=3"); '+ #13 +
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://error:id=3"; '+ #13 +
                {$ENDIF}
                '   }' + #13 +
                ' }' + #13 +
                ' ' + #13 +
                ' function stopMarkerBounceAnimation(IdMarker) {' + #13 +
                '   if (IdMarker<allmarkers.length) {' + #13 +
                '     allmarkers[IdMarker].setAnimation(null);' + #13 +
                '   } else {' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://error:id=3"); '+ #13 +
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://error:id=3"; '+ #13 +
                {$ENDIF}
                '   }' + #13 +
                ' }' + #13 +
                ' ' + #13 +
                ' function deleteMapMarker(IdMarker) {' + #13 +
                '   if (IdMarker<allmarkers.length) {' + #13 +
                '     allmarkers[IdMarker].setMap(null);' + #13 +
                '     allmarkers.splice(IdMarker,1);' + #13 +
                '     allinfowindows.splice(IdMarker,1);' + #13 +
                '   } else {' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://error:id=3"); '+ #13 +
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://error:id=3"; '+ #13 +
                {$ENDIF}
                '   }' + #13 +
                '   if (IdMarker<alllabels.length) {' + #13 +
                '     alllabels[IdMarker].setMap(null);' + #13 +
                '     alllabels.splice(IdMarker,1);' + #13 +
                '   } else {' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://error:id=3"); '+ #13 +
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://error:id=3"; '+ #13 +
                {$ENDIF}
                '   }' + #13 +
                ' }' + #13 +
                ' ' + #13 +
                ' function deleteMapPolyline(IdMarker) {' + #13 +
                '   if (IdMarker<allpolylines.length) {' + #13 +
                '     allpolylines[IdMarker].setMap(null);' + #13 +
                '     allpolylines.splice(IdMarker,1);' + #13 +
                '   } else {' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://error:id=3"); '+ #13 +
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://error:id=3"; '+ #13 +
                {$ENDIF}
                '   }' + #13 +
                ' }' + #13 +
                ' ' + #13 +
                ' function deleteMapPolygon(IdMarker) {' + #13 +
                '   if (IdMarker<allpolygons.length) {' + #13 +
                '     allpolygons[IdMarker].setMap(null);' + #13 +
                '     allpolygons.splice(IdMarker,1);' + #13 +
                '   } else {' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://error:id=3"); '+ #13 +
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://error:id=3"; '+ #13 +
                {$ENDIF}
                '   }' + #13 +
                ' }' + #13 +
                ' ' + #13 +
                ' function deleteKMLLayer(IdLayer) {' + #13 +
                '   if (IdLayer<allkmllayers.length) {' + #13 +
                '     allkmllayers[IdLayer].setMap(null);' + #13 +
                '     allkmllayers.splice(IdLayer,1);' + #13 +
                '   } else {' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://error:id=3"); '+ #13 +
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://error:id=3"; '+ #13 +
                {$ENDIF}
                '   }' + #13 +
                ' }' + #13 +
                ' ' + #13 +
                ' function openMarkerInfoWindowHtml(IdMarker, html) {' + #13 +
                '   if (IdMarker<allmarkers.length) {' + #13 +
                '     var marker = allmarkers[IdMarker];' + #13 +
                '     var infowindow = allinfowindows[IdMarker];' + #13 +
                '     infowindow.setContent(html);' + #13 +
                '     infowindow.open(map, marker);' + #13 +
                '   } else {' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://error:id=3"); '+ #13 +
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://error:id=3"; '+ #13 +
                {$ENDIF}
                '   }' + #13 +
                ' }' + #13 +
                ' ' + #13 +
                ' function closeMarkerInfoWindowHtml(IdMarker) {' + #13 +
                '   if (IdMarker<allmarkers.length) {' + #13 +
                '     var marker = allmarkers[IdMarker];' + #13 +
                '     var infowindow = allinfowindows[IdMarker];' + #13 +
                '     infowindow.close();' + #13 +
                '   } else {' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://error:id=3"); '+ #13 +
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://error:id=3"; '+ #13 +
                {$ENDIF}
                '   }' + #13 +
                ' }' + #13 +
                ' ' + #13 +
                ' function deleteAllMapMarker() {' + #13 +
                '   for (i in allmarkers) {' + #13 +
                '     allmarkers[i].setMap(null);' + #13 +
                '   }' + #13 +
                '   allmarkers.splice(0,allmarkers.length);' + #13 +
                '   allinfowindows.splice(0,allinfowindows.length);' + #13 +
                '   for (i in alllabels) {' + #13 +
                '     alllabels[i].setMap(null);' + #13 +
                '   }' + #13 +
                '   alllabels.splice(0,alllabels.length);' + #13 +
                ' }' + #13 +
                ' ' + #13 +
                ' function deleteAllMapPolyline() {' + #13 +
                '   for (i in allpolylines) {' + #13 +
                '     allpolylines[i].setMap(null);' + #13 +
                '   }' + #13 +
                '   allpolylines.splice(0,allpolylines.length);' + #13 +
                ' }' + #13 +
                ' ' + #13 +
                ' function deleteAllMapPolygon() {' + #13 +
                '   for (i in allpolygons) {' + #13 +
                '     allpolygons[i].setMap(null);' + #13 +
                '   }' + #13 +
                '   allpolygons.splice(0,allpolygons.length);' + #13 +
                ' }' + #13 +
                ' ' + #13 +
                ' function deleteAllKMLLayer() {' + #13 +
                '   for (i in allkmllayers) {' + #13 +
                '     allkmllayers[i].setMap(null);' + #13 +
                '   }' + #13 +
                '   allkmllayers.splice(0,allkmllayers.length);' + #13 +
                ' }' + #13 +
                ' ' + #13 +
                ' function ShowTraffic() {' + #13 +
                '   trafficLayer.setMap(map);' + #13 +
                ' }' + #13 +
                ' ' + #13 +
                ' function HideTraffic() {' + #13 +
                '   trafficLayer.setMap(null);' + #13 +
                ' }' + #13 +
                ' ' + #13 +
                ' function ShowBicycling() {' + #13 +
                '   bicyclingLayer.setMap(map);' + #13 +
                ' }' + #13 +
                ' ' + #13 +
                ' function HideBicyling() {' + #13 +
                '   bicyclingLayer.setMap(null);' + #13 +
                ' }' + #13 +
                ' ' + #13 +
                ' function ShowPanoramio() {' + #13 +
                '   panoramioLayer.setMap(map);' + #13 +
                ' }' + #13 +
                ' ' + #13 +
                ' function HidePanoramio() {' + #13 +
                '   panoramioLayer.setMap(null);' + #13 +
                ' }' + #13 +
                ' ' + #13 +
                ' function ShowCloud() {' + #13 +
                '   cloudLayer.setMap(map);' + #13 +
                ' }' + #13 +
                ' ' + #13 +
                ' function HideCloud() {' + #13 +
                '   cloudLayer.setMap(null);' + #13 +
                ' }' + #13 +
                ' ' + #13 +
                ' function ShowWeather() {' + #13 +
                '   weatherLayer.setMap(map);' + #13 +
                ' }' + #13 +
                ' ' + #13 +
                ' function HideWeather() {' + #13 +
                '   weatherLayer.setMap(null);' + #13 +
                ' }' + #13 +
                ' ' + #13;

  HTML_FILE_3 = ' function initialize() {' + #13 +
                '  var latlng = new google.maps.LatLng(%latitude%, %longitude%);' + #13 +

                //disable POI labels
                ' var myStyles =[' + #13 +
                '     {' + #13 +
                '         featureType: "poi",' + #13 +
                '         elementType: "labels",' + #13 +
                '         stylers: [' + #13 +
//                '               { visibility: "off" }' + #13 +
                '               { visibility: "%disablepoi%" }' + #13 +
                '         ]' + #13 +
                '     }' + #13 +
                ' ];' + #13 +

                '  var myOptions = {' + #13 +
                '    navigationControlOptions: {' + #13 +
                '      style: google.maps.NavigationControlStyle.%controlstype%' + #13 +
                '    },' + #13 +
                '   panControl: %panControl%,' + #13 +
                '   panControlOptions: {' + #13 +
                '     position: google.maps.ControlPosition.%panControlPosition%' + #13 +
                '   },' + #13 +
                '   zoomControl: %zoomControl%,' + #13 +
                '   zoomControlOptions: {' + #13 +
                '     position: google.maps.ControlPosition.%zoomControlPosition%,' + #13 +
                '     style: google.maps.ZoomControlStyle.%zoomControlStyle%' +
                '   },' + #13 +
                '   mapTypeControl: %mapTypeControl%,' + #13 +
                '   mapTypeControlOptions: {' + #13 +
                '     position: google.maps.ControlPosition.%mapTypeControlPosition%,' + #13 +
                '     style: google.maps.MapTypeControlStyle.%mapTypeControlStyle%' +
                '   },' + #13 +
                '   scaleControl: %scaleControl%,' + #13 +
                '   scaleControlOptions: {' + #13 +
                '     position: google.maps.ControlPosition.%scaleControlPosition%' + #13 +
                '   },' + #13 +
                '   streetViewControl: %streetViewControl%,' + #13 +
                '   streetViewControlOptions: {' + #13 +
                '     position: google.maps.ControlPosition.%streetViewControlPosition%' + #13 +
                '   },' + #13 +
                '   overviewMapControl: %overviewMapControl%,' + #13 +
                '   overviewMapControlOptions: {' + #13 +
                '     opened: %overviewMapControlOpened%' + #13 +
                '   },' + #13 +
                '   disableDoubleClickZoom: %disableDoubleClickZoom%,' + #13 +
                '   draggable: %draggable%,' + #13 +
                '   keyboardShortcuts: %keyboardShortcuts%,' + #13 +
                '   scrollwheel: %scrollwheel%,' + #13 +
                '   disableDefaultUI: %disableDefaultUI%,' + #13 +
                '   zoom: %zoom%,' + #13 +
                '   center: latlng,' + #13 +
                '   mapTypeId: google.maps.MapTypeId.%maptype%,' + #13 +
                '   styles: myStyles' + #13 +
                '  };' + #13 +
                '  streetviewService = new google.maps.StreetViewService();' + #13 +
                '  trafficLayer = new google.maps.TrafficLayer();' + #13 +
                '  bicyclingLayer = new google.maps.BicyclingLayer();' + #13 +
                '  panoramioLayer = new google.maps.panoramio.PanoramioLayer();' + #13 +
                '  var myWeatherOptions = {' + #13 +
                '   temperatureUnits: google.maps.weather.TemperatureUnit.%weatherTemperature%,' + #13 +
                '   labelColor: google.maps.weather.LabelColor.%weatherLabelColor%,' + #13 +
                '   suppressInfoWindows: %weatherSuppressInfoWinddows%,' + #13 +
                '   windSpeedUnits: google.maps.weather.WindSpeedUnit.%weatherWindSpeed%' + #13 +
                '  };' + #13 +
                '  cloudLayer = new google.maps.weather.CloudLayer()' + #13 +
                '  weatherLayer = new google.maps.weather.WeatherLayer(myWeatherOptions);' + #13 +
                '  map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);' + #13 +

                '    trafficLayer.setMap(%showtraffic%);' + #13 +
                '    bicyclingLayer.setMap(%showbicycling%);' + #13 +
                '    panoramioLayer.setMap(%showpanoramio%);' + #13 +
                '    cloudLayer.setMap(%showcloud%);' + #13 +
                '    weatherLayer.setMap(%showweather%);' + #13 +
                '    streetviewPanorama = map.getStreetView();' + #13 +
                '  if (%SVVisible%){' + #13 +
                '    streetviewPanorama.setVisible(true);'+
                '    showStreetview("%SVLat%", "%SVLng%", %SVHeading%, %SVZoom%, %SVPitch%);' + #13 +
                '  }' + #13 +
                '    google.maps.event.addListener(map, "tilesloaded", function() {' + #13 +
//                '        streetviewPanorama = map.getStreetView();' + #13 +

                '        google.maps.event.addListener(streetviewPanorama, "position_changed", function() {' + #13 +
                '          NewPosition = streetviewPanorama.getPosition();' + #13 +
                '          var lat = NewPosition.lat();' + #13 +
                '          var lng = NewPosition.lng();' + #13 +
                {$IFDEF ANDROID}
                '          injectedObject.setPrivateImeOptions("jsevent://streetviewmove:lat=" + lat + "#lng=" + lng+"#x="+mx+"#y="+my); '+ #13 +
                '          injectedObject.performClick();'+ #13 +
                {$ELSE}
                '          window.location.href = "jsevent://streetviewmove:lat=" + lat + "#lng=" + lng+"#x="+mx+"#y="+my; '+ #13 +
                {$ENDIF}
                '        });' + #13 +

                '        google.maps.event.addListener(streetviewPanorama, "pov_changed", function() {' + #13 +
//              Fix: POI streetview click has undefined zoom value
                '        var heading = streetviewPanorama.getPov().heading;' + #13 +
                '        if (heading)' + #13 +
                '          heading = parseInt(heading);' + #13 +
                '        else' + #13 +
                '          heading = -1;' + #13 +
                '        var pitch = streetviewPanorama.getPov().pitch;' + #13 +
                '        if (pitch)' + #13 +
                '          pitch = parseInt(pitch);' + #13 +
                '        else' + #13 +
                '          pitch = -1;' + #13 +
                '        var zoom = streetviewPanorama.getPov().zoom;' + #13 +
                '        if (zoom)' + #13 +
                '          zoom = parseInt(zoom);' + #13 +
                '        else' + #13 +
                '          zoom = -1;' + #13 +
                {$IFDEF ANDROID}
                '          injectedObject.setPrivateImeOptions("jsevent://streetviewchange:heading=" + heading + "#pitch=" + pitch + "#zoom=" + zoom); '+ #13 +
                '          injectedObject.performClick();'+ #13 +
                {$ELSE}
                '          window.location.href = "jsevent://streetviewchange:heading=" + heading + "#pitch=" + pitch + "#zoom=" + zoom; '+ #13 +
                {$ENDIF}
                '        });' + #13 +

                {$IFDEF ANDROID}
                '      injectedObject.setPrivateImeOptions("jsevent://tilesload"); '+ #13 +
                '      injectedObject.performClick();'+ #13 +
                {$ELSE}
                '      window.location.href = "jsevent://tilesload"; '+ #13 +
                {$ENDIF}
                '    });' + #13 +
                '    google.maps.event.addListener(map, "click", function(event) {' + #13 +
                '         var ClickLatLng = event.latLng;' + #13 +
                '         if (ClickLatLng) {' + #13 +
                '            var lat = ClickLatLng.lat();' + #13 +
                '            var lng = ClickLatLng.lng();' + #13 +
                {$IFDEF ANDROID}
                '      injectedObject.setPrivateImeOptions("jsevent://click:lat="+lat+"#lng="+lng+"#x="+mx+"#y="+my); '+ #13 +
                '      injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://click:lat="+lat+"#lng="+lng+"#x="+mx+"#y="+my; '+ #13 +
                {$ENDIF}
                '         }' + #13 +
                '    });' + #13 +
                '    google.maps.event.addListener(map, "dblclick", function(event) {' + #13 +
                '         var ClickLatLng = event.latLng;' + #13 +
                '         if (ClickLatLng) {' + #13 +
                '            var lat = ClickLatLng.lat();' + #13 +
                '            var lng = ClickLatLng.lng();' + #13 +
                {$IFDEF ANDROID}
                '      injectedObject.setPrivateImeOptions("jsevent://dblclick:lat="+lat+"#lng="+lng+"#x="+mx+"#y="+my); '+ #13 +
                '      injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://dblclick:lat="+lat+"#lng="+lng+"#x="+mx+"#y="+my; '+ #13 +
                {$ENDIF}
                '         }' + #13 +
                '    });' + #13 +
                '    google.maps.event.addListener(map, "dragstart", function() {' + #13 +
                '         var ptcenter=map.getCenter();' + #13 +
                '         var lat=ptcenter.lat();' + #13 +
                '         var lng=ptcenter.lng();' + #13 +
                {$IFDEF ANDROID}
                '      injectedObject.setPrivateImeOptions("jsevent://dragstart:lat="+lat+"#lng="+lng+"#x="+mx+"#y="+my); '+ #13 +
                '      injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://dragstart:lat="+lat+"#lng="+lng+"#x="+mx+"#y="+my; '+ #13 +
                {$ENDIF}
                '    });' + #13 +
                '    google.maps.event.addListener(map, "dragend", function() {' + #13 +
                '         var ptcenter=map.getCenter();' + #13 +
                '         var lat=ptcenter.lat();' + #13 +
                '         var lng=ptcenter.lng();' + #13 +
                {$IFDEF ANDROID}
                '      injectedObject.setPrivateImeOptions("jsevent://dragend:lat="+lat+"#lng="+lng+"#x="+mx+"#y="+my); '+ #13 +
                '      injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://dragend:lat="+lat+"#lng="+lng+"#x="+mx+"#y="+my; '+ #13 +
                {$ENDIF}
                '    });' + #13 +
                '    google.maps.event.addListener(map, "drag", function() {' + #13 +
                '         var ptcenter=map.getCenter();' + #13 +
                '         var lat=ptcenter.lat();' + #13 +
                '         var lng=ptcenter.lng();' + #13 +
                {$IFDEF ANDROID}
                '      injectedObject.setPrivateImeOptions("jsevent://drag:lat="+lat+"#lng="+lng+"#x="+mx+"#y="+my); '+ #13 +
                '      injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://drag:lat="+lat+"#lng="+lng+"#x="+mx+"#y="+my; '+ #13 +
                {$ENDIF}
                '    });' + #13 +
                '    google.maps.event.addListener(map, "idle", function() {' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://idle");'+ #13 +
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://idle";'+ #13 +
                {$ENDIF}
                '    });' + #13 +
                '    google.maps.event.addListener(map, "maptypeid_changed", function() {' + #13 +
                '         var TypeMap=map.getMapTypeId();'+ #13 +
                '         var IdTypeMap=0;' + #13 +
                '         switch(TypeMap)' + #13 +
                '         {' + #13 +
                '         case google.maps.MapTypeId.ROADMAP:' + #13 +
                '           IdTypeMap=0;' + #13 +
                '           break' + #13 +
                '         case google.maps.MapTypeId.SATELLITE:' + #13 +
                '           IdTypeMap=1;' + #13 +
                '           break' + #13 +
                '         case google.maps.MapTypeId.HYBRID:' + #13 +
                '           IdTypeMap=2;' + #13 +
                '           break' + #13 +
                '         case google.maps.MapTypeId.TERRAIN:' + #13 +
                '           IdTypeMap=3;' + #13 +
                '           break' + #13 +
                '         }' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://typeidchange:maptype="+IdTypeMap); '+ #13 +
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://typeidchange:maptype="+IdTypeMap; '+ #13 +
                {$ENDIF}
                '    });' + #13 +
                '    google.maps.event.addListener(map, "zoom_changed", function() {' + #13 +
                '         var ZoomLevel = map.getZoom();' + #13 +
                {$IFDEF ANDROID}
                '  injectedObject.setPrivateImeOptions("jsevent://zoomchange:zoomlevel="+ZoomLevel); '+ #13 +
                '  injectedObject.performClick();'+ #13 +
                {$ELSE}
                '  window.location.href = "jsevent://zoomchange:zoomlevel="+ZoomLevel; '+ #13 +
                {$ENDIF}
                '    });' + #13 +
                ' }' + #13 +
                ' ' + #13 +

                ' google.maps.event.addDomListener(window, "load", initialize);' + #13 +
                ' ' + #13 +

                '  function SetValues()'+#13+
                '    {'+#13+
                '    mx = window.event.clientX;'+#13+
                '    my = window.event.clientY;'+#13+
                '    }'+#13+

                'function touchStart(event) {'+#13+
                '  var allTouches = event.touches;'+#13+
                '  for (var i = 0; i < allTouches.length; i++){' + #13 +
                '    mx = event.touches[i].pageX;'+#13+
                '    my = event.touches[i].pageY;'+#13+
                '  }'+#13+
                '}'+#13+

                '</script>' + #13 +
                '</head>' + #13 +
                '<body >' + #13 +

                '<div id="map_canvas" '+ #13+
//                ' ontouchstart="touchStart(event);"'+#13+
                ' onmousedown=SetValues();'+#13+
                '></div>' + #13 +

                '</body>' + #13 +
                '</html>';

implementation

end.
