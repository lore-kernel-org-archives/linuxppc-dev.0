Date: Wed, 30 Dec 1998 14:21:22 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Michael Schmitz <mschmitz@lbl.gov>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: grackle, patches, MMU, ...
In-Reply-To: <19981230123559.019295@mail.mipsys.com>
Message-ID: <Pine.LNX.4.03.9812301346100.18617-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 30 Dec 1998, Benjamin Herrenschmidt wrote:
> BTW. Geert: Since you are working on m68k too, do you know if linux-m68k
> uses the same adb code as linux-ppc ? I'm working on a new adb.c/.h,

Linux/m68k on Mac uses arch/m68k/mac/adb-bus.c, drivers/char/adbmouse.c and
include/asm-m68k/adb.h. All these files are up-to-date in 2.2.0-pre1, AFAIK
(just diffed between pre1 and m68k-.131).

> which cleans up things (especially "hook-like" entry points to the
> controller by exporting functions for registering hardware controllers
> (via a structure with function pointers)) and for registering devices
> (also a structure with function pointers with more entrypoint to allow
> proper re-probing when a bus reset is done for example) and I would like
> to know if there are risk I break m68k while doing so. Currently,

Integration would be nice. Contact Michael Schmitz <mschmitz@lbl.gov> in case
of troubles.

> adb.c/.h is in arch/ppc but I don't know if vger is the main repository
> for m68k too or not

Vger isn't the main repository for m68k. The main things that keep Linus' tree
from working on m68k are IDE and serial. We're working on integrating IDE
(patches are ready), but I'm afraid Linus won't accept them. BTW, in 3 more
months I'll celebrate `5 year IDE in Linux/m68k' on my Amiga, with the driver
still not integrated... sigh...

The mandatory site for Linux/m68k kernels is
ftp://sunsite.auc.dk/pub/os/linux/680x0/.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
