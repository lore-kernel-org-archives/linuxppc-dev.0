Message-Id: <200008040916.KAA26622@hyperion.valhalla.net>
Date: Fri, 04 Aug 2000 10:16:32 +0100
Subject: Re: CDDA playback on Pismo (and other newer models)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Henry Worth <haworth@ncal.verio.com>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Henry,
 Fri, Aug 4, 2000, Henry Worth wrote:
> Additionally there seems to be some clipping occuring somewhere
> in the A/D or mixer/preamp. It's independent of output
> volume on either the internal speakers or external port, and
> only occurs, consistently, on a few tracks I've tried. But in
> general using .aiff format instead of .wav seems to sound a
> bit better, with perhaps a bit less clipping (haven't tried
> the latest damsound patches).

The latest patches will (probably) not help this... although the output from
them will help me in debugging where we're at - and they do fix on or two
other pismo-related issues.

it is likely (a) either the app not really setting up /dev/dsp properly. or
(b) issues with the mixer abstraction which are still being worked on.

Try opening the oss mixer (e.g. kmixer) and making sure that the monitoring
channel is full *up*.  I know this sounds strange (but at least with CDs)
for me it stops the distortion.

This stuff is being actively worked on... and I will post with patch/URL
if/when the results are more positive.

> I'd like to give XMMS a try, but the XMMS in LPPC2K and updates
> and builds of newer versions all generate white noise on .wav
> files (endiness?). Has anyone been able to get XMMS to work on
> a Pismo? And where can I find the XMMS CDDA playback plugin?

I've been using the xmms CVS tree (www.xmms.org and follow the links).  It
works fine with .wavs of different sample rates etc.  [xmms --version ==
1.2.1].

I don't think the 'standard' CD plugin routes the audio from disk to
/dev/dsp -- it seems to do the same as other media players and start the CD
player but use the local routing of audio on the mixer.  will check some
more on this.

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
