From: Michael Engel <engel@math.uni-siegen.de>
Message-Id: <199906230835.KAA26148@fourier.numerik.math.uni-siegen.de>
Subject: Re: Xbh not working (Cirrus X server)
To: jrugen@primenet.com
Date: Wed, 23 Jun 1999 10:35:10 +0200 (MET DST)
Cc: engel@math.uni-siegen.de, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.BSI.3.96.990622225336.2245A-100000@usr08.primenet.com> from "Jeff Rugen" at Jun 22, 99 11:09:02 pm
Content-Type: text
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Jeff,

> On Wed, 23 Jun 1999, Michael Engel wrote:
> 
> > I'm experiencing a problem with Xbh on the Motorola PowerStack Series E
> > and PowerStack II here. Xbh crashes with segmentation fault shortly after
> > starting the server, gdb shows that the server is crashing in
> > gd54xx_memsize
> > (in xc/programs/Xserver/hw/bh/gd54xx.c). I built XFree from source
> > (rpm --rebuild) with the same result. When setting a fixed memsize of 2 MB
> > in gd54xx_memsize, the server crashes in outb() in
> > gd54xx_setcolor

[...]

> Are you starting Xbh with the -mmap option?  If you're using 2.2.x or later,
> you have to have that option selected, and it might not be default:
> 
> startx -- -mmap

Thanks a lot, that did it ! (and promptly hung up my keyboard somehow and with
it my telnet session where I wanted to write that reply ... ;-) - but the display
works fine now).

> If that doesn't work, read on. :-)

Still reading on ;-).

> I might be the de-facto maintainer for Xbh right now (I'm the latest person
> I know to play with it much).  A couple questions:

If you need a tester or some help, please let me know. As I wrote, I don't 
know much about X servers yet but writing a server was a thing I wanted to 
learn for some time now (I got around it for our DECstation port by writing
a frame buffer device driver ;-)).

> 1) How much video memory does your graphics chip have (it sounds like 2 MB
> with you setting a fixed memsize).

I've got a 2 MB card with a 5446 chip set.

> 2) What version of Linux are you running.

LinuxPPC R5 with kernel 2.2.1 (as I can't get any later kernels to run without
SCSI timeouts on the PowerStack E, the PowerStack II works fine with kernels
2.2.6 and 2.2.10).

> 3) Is your Series E one in a black case, or is it a standard PC
> tower/desktop model (I can't remember if my motherboard is considered the
> series E, but its a standard PC tower with 2MB video memory -- I'm using
> various 2.2.x and 2.3.x kernels, though Xbh mainly with an older 2.2.x
> kernel).

It's the black stackable case model, the video card is a separate PCI board.

> Which version of glibc do you have?  (Are you a R5 or pre-R5 distribution,
> with the newer glibc, or an older R4+ with glibc 1.99?)

glibc-2.1 with R5 final.

> If you're running R5 (glibc of 2.1 or something like that), is it convenient
> for you to download the Xbh I have compiled at
> ftp://linuxppc.cs.nmt.edu/pub/linuxppc/patches/Xbh-16bit-glibc2x

OK, I'll try it right now.

Once again, thanks a lot !

Best regards,
	Michael Engel	(engel@unix-ag.org)


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
