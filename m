Subject: Re: On-Chip-Debugging for MPC 860 ?
To: Tobias.Otto-Adamczak@e-technik.tu-chemnitz.de (Tobias Otto-Adamczak)
Date: Mon, 14 Feb 2000 10:33:53 +1100 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <Pine.GSO.4.21.0002111115480.20126-100000@samson.hrz.tu-chemnitz.de> from "Tobias Otto-Adamczak" at Feb 11, 2000 12:44:18 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000213233353.B879884F0@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tobias Otto-Adamczak writes:
> I am new to this whole stuff. I'm a student working on diploma thesis.
> My goal is to have linux running on MBX board -WITHOUT- EPPC-Bug, booting
> diskless out of the flash-ROM and having a ramdisk and a flash-filesystem.

Cool project; should be a lot of fun. Please do the world a favour in return,
and release your startup code under the GPL when you're done.

> How to make use of MPC's BDM (with a linux host), if possible via GDB ?
> I know that I need an adapter cable for the parallel port.
> Actually I have three of them:
>
> * a so-called "EBDI-Lite" from Motorola
> * a "CPU32"-cable which was used for debugging the 68360 with GDB
> * a very simple cable according to the suggestions of sergey drashnikov
> (found in graham stoneys mailing from Jan 27th, which I found really
> helpful. Graham, what is the URL for your HOWTO ?)

Glad you found it helpful; that's just the inspiration I need to keep updating
it. I don't have it up on the 'net yet; I was hoping to get it (or at least a
link to it) put on the "Linux/PPC on Embedded Systems" home page. One problem
is putting it somewhere I can update easily & frequently.

Anyway, as far as BDM goes...

> * Patches from Sergey Drashnikov for 860 who are very "quick and
> dirty" and didn't work out of the box (he tested under FreeBSD only).

I believe this is currently the only option for doing it under Linux. I'd be
interested if anyone knows whether Sergey's cable is compatible with any of
the simple commercal ones, for those of us who would rather buy something off-
the-shelf.

Here's an updated snippet from my HOWTO:

GDB support for PowerPC BDM under Linux isn't yet available. See the thread:
http://www.oarcorp.com/rtems/freesupport/rtemslistArchive/1999/july/msg00057.htm
l

There are many sources of BDM hardware probes and debuggers:

Macraigor Systems: http://www.macraigor.com/
Currently only support Windoze platform, but say Linux support should be
available sometime in Q1 2000. Beware that the 1999 version of OCD Commander
silently truncates S-records longer than 20 bytes during download.

The Cygwin version of gdb can use the Macraigor DLL, if you're prepared to do
your debugging under Windoze.

Build your own: http://cyclone.parad.ru/ppcdbm/

Commercial solutions, none of which support a Linux development host:
Mentor (X-ray):
http://www.mentor.com/embedded/xray/index.html

Huntsville Microsystems (SourceGate):
http://www.hmi.com/bmd.htm

Tasking (CrossView Pro):
http://www.tasking.com/products/PPC/ppcsolution.htm#debugger

SDS (SingleStep):
http://www.sdsi.com/product/powerpc/index.php3#power

Applied Microsystems (PowerTap):
http://www.amc.com/products/powertap.html

EST Corporation:
http://www.estc.com/

> What would you suggest to do ? Is there any "ready-to-use"-solution ? I
> know that there are some commercial tools for Windows (Metrowerks, EST)
> but what about linux ?  I thought about adopting the GDB-BDM patches for
> 360 to 860, but I cannot evaluate how much work it is.

If you don't need it right away, my suggestion would be to wait until you do.
Things may well have changed by then as far as Linux support goes.

Regards,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
