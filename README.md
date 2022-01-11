# RADAR | A Realtime Animated Score for Any Number & Combination of Instruments

<i class="fa fa-download fa-2x"></i> 

[project page](http://orestiskaramanlis.net/radar/)
<hr>

**Equipment**

1 x laptop running the SuperCollider programming language 
1 x projector connected to the laptop<hr>**Description**
Radar (ver.0.2) is an interactive notation system constructed in the SuperCollider programming language. It allows a single user 'the maestro' to organise an ensemble and to communicate information to the members by means of an interactive window (a disc) projected on a surface visible to all. •	The ensemble is initially divided into groups; with each group represented as a disc sector (a ‘pizza slice’ corresponding to the region on the disc which is bounded by 2 radii). Any number of performers is feasible, but an ensemble of more than 20 will clutter the animated score making it difficult to read on the fly. 
•	The homocentric circles usually define sound-event categories, which could be notes, tones, whole musical phrases, vamps, sound-objects, etc.•	A black dot on the disc surface denotes a sound-event to be played by the respective performer (or group of performers).•	An arm spinning around the disc keeps all performers in sync. When the arm intersects with a dot, the respective performer(s) play a sound. If the ensemble is comprised of pitched acoustic instruments, a dot could be thought to correspond to a note from a particular scale as defined by the number of homocentric circles. •	The ensemble can collectively decide on all aspects of the performing strategy beforehand. For example, a larger dot may denote a higher dynamic or an embellishment; a rotating grey wedge may be a cue for improvisation or for sustaining a sound, and so on.•	Multiple spinning arms allow the maestro to create polyrhythmic structures. The faster an arm rotates, the faster its tempo. <hr>**Example**
In this simple scenario there are 8 instrumentalists (or 8 groups of performers). The ensemble has decided to use a particular pentatonic scale (as there are 5 homocentric circles). Performer-2 plays the lower note of the scale with an ornament and sustains. Performer-5 will play the 4th note of the scale (in any octave) when the white arm intersects with the dot; she will hold the note for as long as the dot is within the grey area of the rotating wedge. Performer-8 is getting ready to play an instantaneous pitch (the 2nd note of the pentatonic scale) when the yellow arm intersects with her dot.  
<img src="resources\img.png" width="300">

Performers don't have to play one event at a time; interesting textures emerge when the maestro assigns multiple dots (sound-events) per disc sector sequentially. Relying on the ensemble's intuition and creative input to decide on the exact performing strategy would yield something which is fun to play for the available forces. 

<hr>

**Maestro Controls**
The maestro has control over the following parameters: window size, clocks’ tempi, area of the grey wedge, number of homocentric circles, number of groups. •	Cmd + click: adds/deletes a dot•	Alt + drag: moves a dot•	Ctrl + click: changes dot’s size•	Cmd + Shift + click: clears all dots•	Cmd + .: closes the window
<hr>

**File Structure**
Open the file “Radar.scd” and run it in its entirety. Adjustments on the number of players, the sound-event categories, the tempi, etc. can take place on the fly by changing the values of the respective parameters within the same document.**Note**
No audio interface is required in order to perform Radar. It can accommodate almost any number of players and any acoustic/electronic sources. The system has been devised with the intention to construct a framework for structuring pieces for an ensemble which varies in size and forces in every rehearsal; exactly as it happens in real life when dealing with ensembles in the academia!<hr>

<i>© 2020, Orestis Karamanlis, you may redistribute and/or modify the code under the terms of the [GNU General Public License v.3](https://www.gnu.org/licenses/gpl-3.0.html)</i>



