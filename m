From: Joe Green <jgreen@mvista.com>
To: "Brown, David (dbrown03)" <DBrown03@harris.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Where to send patch files?
Date: Wed, 7 Jun 2000 11:28:17 -0700
Content-Type: text/plain
References: <BE1C564723B3D21191FD0000F840E39801D81566@rfcmx2.rfc.comm.harris.com>
In-Reply-To: <BE1C564723B3D21191FD0000F840E39801D81566@rfcmx2.rfc.comm.harris.com>
MIME-Version: 1.0
Message-Id: <00060711371105.26446@minotaur.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 07 Jun 2000, Brown, David (dbrown03) wrote:
> I have linux-2.2.13 working on a Harris modem platform.
> I started with the hardhat version, but added flash drivers from Wolfgang
> Denk.
> I extended the flash drivers to support JEDEC identification, Intel
> write/erase commands, and multiple kinds of flash per board.
> Also, of course, I added support for the modem platform I was using.
>
> The question:  Where should I send the 19K patch file?
> Minimally I'll send it to Dan Malek, someone at Montavista, and Wolfgang
> Denk.

Patches for anything we ship can be sent to <source@mvista.com>.  I
can't promise that every patch we get will be incorporated into our
code.

It's helpful if you separate big patches by functionality (e.g.,
different patches for your flash changes and the changes to support
your unique hardware).  Try to base your patches on a common base we
both have access to--for us, a particular Hard Hat Linux package is
best.  Remember to tell us what the base is :-).

Thanks
--
Joe Green <jgreen@mvista.com>
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
