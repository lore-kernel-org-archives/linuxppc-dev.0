Subject: Re: iBook G3: status of 2.6.5
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Christiaan Welvaart <cjw@daneel.dyndns.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.58.0403311105030.19002@zem.cjw.nep>
References: <c4c2si$dv7$1@sea.gmane.org>  <1080687801.13152.56.camel@gaston>
	 <1080689835.9195.52.camel@thor.asgaard.local>
	 <1080690668.1216.65.camel@gaston>
	 <Pine.LNX.4.58.0403311105030.19002@zem.cjw.nep>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1080730223.2199.14.camel@thor.asgaard.local>
Mime-Version: 1.0
Date: Wed, 31 Mar 2004 12:50:24 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2004-03-31 at 11:18, Christiaan Welvaart wrote:
>
> on a beige G3:
> With a 2.6.3-based kernel, PREEMPT on (no idea if that matters),

preempt used to be broken on PPC until very recently, but I doubt it
would cause sound skips.

> I hear occasional glitches in the sound output, using xmms. It sounds
> like it's playing some random piece of data in memory for maybe 0.2s.
> How often this happens seems to be independent of system load. The alsa
> driver works fine in 2.4, and IIRC also with 2.6.0 (without PREEMPT).

The xmms ALSA plugin is known to be completely hosed. I don't have any
sound skip problems with mpd, alsaplayer, ogg123, xine, rhythmbox, ...


--
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
