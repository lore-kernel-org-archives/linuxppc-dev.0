Message-ID: <406C3B07.3000405@fh-landshut.de>
Date: Thu, 01 Apr 2004 17:53:43 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
Reply-To: okorpil@fh-landshut.de
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Serial Console / Booting Linux with the PPCbug on MVME2100?
References: <Pine.LNX.4.58.0403311359540.21912@ppcproject1> <20040331170924.GL13819@smtp.west.cox.net> <Pine.LNX.4.58.0404011015410.476@ppcproject1> <20040401150943.GE21709@smtp.west.cox.net>
In-Reply-To: <20040401150943.GE21709@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is what I expected. Looking quickly over the prep_* files in

>arch/ppc/platform confirms that the MVME2100 is not supported by these
>files.  As an aside, mkbugboot is only needed to put an image into flash
>and boot it. mkprep is used for hd(/cd?), floppy and network.
>
>
>
Just to make sure I tried hard enough.

>Now, a quick googling for Linux and MVME2100 gives this very old, but
>mostly sufficient patch:
>http://www.aps.anl.gov/asd/people/anj/mvme2100.patch.gz
>Since you have the hardware, from here it should be not too hard, using
>the LoPEC as an example, port the code in that patch to 2.4 and 2.6 (if
>you do a patch vs 2.6 we can get that support into kernel.org, if you're
>willing to try and keep the platform working).
>
>Tom Rini
>
>
Well, "not too hard" is a bit funny, since I'm a kernel hacking newbie!
But I guess I should be able to try that 2.4.2 kernel to verify this
patch works, and then try to to stick that stuff into a more recent
(2.4) kernel. I'm not sure if I can support that platform in the long
run, since this (at the moment) a rather limited project - get the
platform running, get board capabilities running, get VME bus running -
produce a demonstration and document that solution as a simple BSP.

Thanks for the advice, and I think I have little other choice than
heeding it, because I'm starting to run out of options. ;)

Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
