Subject: Re: Radeon 7000 dual head issues?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Stefan Jeglinski <jeglin@4pi.com>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <p06100402bcd3b533403f@[192.168.9.138]>
References: <p06100402bcd3b533403f@[192.168.9.138]>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1085230739.30582.86.camel@localhost>
Mime-Version: 1.0
Date: Sat, 22 May 2004 14:59:00 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2004-05-21 at 16:06, Stefan Jeglinski wrote:
> Can anyone state that they have dual monitors working with a Radeon
> 7000 card? XFree86.org implies, nay, states outright, that this card
> is fully supported, including dual head mode.

That's basically right.


> 1. Got the semblance of a plain colored desktop background. It
> actually looks correct in 15 bit mode; 8, 16, and 24 cause lots of
> the graininess and weird coloring one sees when the bit depth is off.
>
> 2. Got a mouse cursor that exactly tracks the cursor on the main
> (good) monitor.
>
> 3. Got a lower resolution than expected (everything is bigger and pixelated).
>
> 4. Am seeing 4 replications of what is on the main screen. The
> replications are 4 across, not 2x2 or anything more complicated.

[...]

> 2. If I set Option "UseFBDev" to false, the second monitor goes "out
> of range" and although the main monitor works in X as always, when I
> kill X I no longer have console video on the main monitor. So is
> seems that UseFBDev must be set to true for both heads.

Actually, it needs to be off for both, because the framebuffer device
doesn't support the second head yet, so its behaviour is undefined with
UseFBDev. The failure to restore the console is a bug in the XFree86
radeon driver I think.

Otherwise, I don't see anything obviously wrong with your configuration,
the X server log would be interesting.


--
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
