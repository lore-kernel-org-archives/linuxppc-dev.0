Date: Wed, 7 Apr 1999 10:38:52 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Dave Weis <djweis@plconline.com>
cc: "David A. Gatwood" <marsmail@globegate.utm.edu>,
        Roy Wood <roy@centricsystems.ca>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Resurrecting mkLinux
In-Reply-To: <Pine.LNX.3.95.990406200339.14652L-100000@catbert.desm.plconline.com>
Message-ID: <Pine.LNX.4.03.9904071038100.27618-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 6 Apr 1999, Dave Weis wrote:
> We got around a lot of this in the linux-ma68k port. I think these series
> of powermacs are pretty similar to the top-of-the-line 68k's. I've put
> more comments below.
> 
> > It's not a stupid idea, but there are a handful of issue sthat would have
> > to be resolved before drivers come into play.  The biggest one is the
> > physical RAM.  On the x100 PowerMacs, RAM is not (ever) contiguous.  I
> > have some info about it in a PDF file somewhere, but not with me.  Anyway,
> > there's a table you can read to get the addresses of the banks of memory.
> > That will produce a wrinkle, if I'm reading the LinuxPPC code right, since
> > it appears to only be willing to handle a single memory region.  Also, the
> > LinuxPPC booter would have to incorporate the code to read that table, and
> > pass it in as part of the kernel boot args or whatever.  Further, since
> > the machines don't have OpenFirmware and there are substantial differences
> > between them and PCI machines, it would be wise to pass in the machine ID
> > (gestalt) along with that.  There's no reason to fake an OF tree -- it
> > would clutter the booter unnecessarily, and in virtually every place where
> > you'd do an OF check for addresses or interrupts, you'd probably have to
> > have a switch statement with a PDM case anyway, so there's not much point.
> 
> We passed along a structure that contained addresses of ram chunks to be
> mapped.

I'm not 100% sure, but I expect Linux/PPC on APUS to handle non-contiguous
memory. APUS is just a PPC expansion for Amigas.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
