Date: Fri, 4 Aug 2000 16:40:45 -0400 (EDT)
From: Henry Worth <haworth@ncal.verio.com>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CDDA playback on Pismo (and other newer models)
In-Reply-To: <200008040916.KAA26622@hyperion.valhalla.net>
Message-ID: <Pine.SOL.4.10.10008041547100.26828-100000@ncal.verio.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 4 Aug 2000, Iain Sandoe wrote:

> Hi Henry,
>  Fri, Aug 4, 2000, Henry Worth wrote:
> > Additionally there seems to be some clipping occuring somewhere
> > in the A/D or mixer/preamp. It's independent of output
> > volume on either the internal speakers or external port, and
> > only occurs, consistently, on a few tracks I've tried. But in
> > general using .aiff format instead of .wav seems to sound a
> > bit better, with perhaps a bit less clipping (haven't tried
> > the latest damsound patches).
>
> The latest patches will (probably) not help this... although the output from
> them will help me in debugging where we're at - and they do fix on or two
> other pismo-related issues.
>
> it is likely (a) either the app not really setting up /dev/dsp properly. or
> (b) issues with the mixer abstraction which are still being worked on.
>
> Try opening the oss mixer (e.g. kmixer) and making sure that the monitoring
> channel is full *up*.  I know this sounds strange (but at least with CDs)
> for me it stops the distortion.

I've about decided the "clipping" is mostly on the CDs (it's heavily
picked acoustic string stuff), it's just more noticeable when
listening hard for problems (and in particular through those
tinny internal spearkers).

>
> This stuff is being actively worked on... and I will post with patch/URL
> if/when the results are more positive.
>
> > I'd like to give XMMS a try, but the XMMS in LPPC2K and updates
> > and builds of newer versions all generate white noise on .wav
> > files (endiness?). Has anyone been able to get XMMS to work on
> > a Pismo? And where can I find the XMMS CDDA playback plugin?
>
> I've been using the xmms CVS tree (www.xmms.org and follow the links).  It
> works fine with .wavs of different sample rates etc.  [xmms --version ==
> 1.2.1].

I've been trying 1.2.2 binary and source RPM's. Oddly the smaller wavs
in /usr/share/sound that the gnome desktop uses play ok, but just the
the ones that show a 0:00 length in the playlist. Longer ones just
generate noise (but play ok with other players). Have the same problem
with the version in LPPC2K (IIRC, 1.1.6 or 1.1.7). This is with both oss
and esd output modules. I'll have to check lib dependencies, something
is amiss.

>
> I don't think the 'standard' CD plugin routes the audio from disk to
> /dev/dsp -- it seems to do the same as other media players and start the CD
> player but use the local routing of audio on the mixer.  will check some
> more on this.
>

There has been mention of a CDDA plug-in that doesn't work
very well. I took another look at www.xmms.org and found one that
looked like it might be it, but I go back a few minutes later
to get the name and it's not on the list, just the newer plugins...
Plugin list and new plugin list have same URL..., clearing my cache
doesn't help so the server's cache must be confused as well. Check
history and get the earlier response URL... there it is:

Xmms_CdRead from ftp://mud.stack.nl/pub/OuterSpace/willem/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
