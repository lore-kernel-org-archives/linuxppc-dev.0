Date: Mon, 10 May 1999 10:48:06 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Michel Lanners <mlan@cpu.lu>
cc: bh40@calva.net, frodol@dds.nl, linuxppc-dev@lists.linuxppc.org
Subject: Re: Support for Hydra i2c
In-Reply-To: <199904302005.WAA00302@piglet.cpu.lu>
Message-ID: <Pine.LNX.4.10.9905101046110.10789-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 30 Apr 1999, Michel Lanners wrote:
> On  28 Apr, this message from Benjamin Herrenschmidt echoed through cyberspace:
> [snip]
> > On non-CHRP PowerMacs, there is at least one I2C bus (maybe more) driven
> > by Cuda. It's used for things like planB video input,
> 
> Not that it matters much, but for correctness: the Apple planb ASIC
> includes its own I2C bus interface, controlling the I2C bus on which
> the video decoder chip is connected.
> 
> By the way, this I2C interface is quite simple: write a (sub)address,
> write a value, and off it goes. However, it seems to be hardcoded to
> access only the SAA7196 video decoder, and reading that chip is done
> with a different interface.
> 
> Which gives me another thought, completely unrelated to the subject of
> this mail: I'm wondering whether the video output chips in the 8x00
> also have I2C, and if yes, how they are accessed...
> 
> > and maybe some more stuffs.
> 
> The only device on this I2C bus in the PCI Macs that I know off is the
> RADACAL RAMDAC/CLUT (used at least with the control chip), which gets
> its timebase factors via I2C.
> 
> > Unfortunately, I think we only know how to write to the i2c bus.
> 
> Yes.
> 
> > More hacking needed before we can implement this one too.
> 
> One problem might be that there is as yet no readable device on the bus
> ;-).

Really? Since i2c devices need to identify on the bus, you must be able to read
something from them.

Are there OF methods for the i2c bus on those Macs? My CHRP box has them under
/pci/mac-io@2/misc@0/iic/.

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
