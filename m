To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Failsafe bootloader 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 03 Jun 2003 16:10:28 EDT."
             <5.1.0.14.2.20030603154752.034f0e78@falcon.si.com>
Date: Tue, 03 Jun 2003 23:51:15 +0200
Message-Id: <20030603215120.7E6DBC5492@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <5.1.0.14.2.20030603154752.034f0e78@falcon.si.com> you wrote:
>
> Check out U-Boot
>    http://sourceforge.net/projects/u-boot
> The project page on sourceforge is pretty much non-existant other than the
> CVS link.  Pull down the source -- there _is_ a good README file in it that
> explains a lot about u-boot.
>    http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/u-boot/u-boot/README?rev=1.30
> Wolfgang Denk of Denx Computer Systems runs the project.  He doesn't appear

Actually this is Wolfgang Denk of DENX Software Engineering :-)

> to have anything on U-Boot on his web site either.
>    http://www.denx.de/

Well, we do have some documentation about PPCBoot at

	http://www.denx.de/re/DPLG.html

which can be used directly for U-Boot, too.

> The predecessor was ppcboot, which at least has a home page on sourceforge
>    http://ppcboot.sourceforge.net/
> Pretty much everything said for ppcboot goes for u-boot as well, only
> better :-).

Right :-)

> U-boot has some scripting capabilities as well as variables that can be
> used for rudimentary decision making.  I'm sure Wolfgang will welcome
> improvements to the scripting :-).

The "some scripting capabilities" includes a more  or  less  complete
bourne   shell   (the   "hush"   shell  from  busybox).  Things  like
if/then/else/fi,   for/do/done,   while/do/done,   until/do/done   or
operators like && and || are available.

For a trivial example: to recover from corrupted images (bad checksum
etc.) you could use

	setenv bootcmd 'bootm $addr_primary || bootm $addr_secondary'

etc.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"A fractal is by definition a set for which the Hausdorff Besicovitch
dimension strictly exceeds the topological dimension."
- Mandelbrot, _The Fractal Geometry of Nature_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
