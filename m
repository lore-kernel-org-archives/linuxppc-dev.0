Date: Mon, 4 Jan 1999 10:41:35 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Gerd Knorr <kraxel@goldbach.in-berlin.de>
cc: Kernel List <linux-kernel@vger.rutgers.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: multiheaded console: vgacon + matroxfb
In-Reply-To: <Pine.LNX.4.04.9901031637330.464-100000@bogomips.masq.in-berlin.de>
Message-ID: <Pine.LNX.4.03.9901041039390.5366-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 3 Jan 1999, Gerd Knorr wrote:
> The good news:
> ==============
> 
> bogomips kraxel ~# xinit -- /cdrbuf/xc/programs/Xserver/XF86_SVGA :0
> [ ... ]
> Configured drivers:
>   SVGA: server for SVGA graphics adaptors (Patchlevel 0):
>       fbdev, NV1, STG2000, RIVA128, RIVATNT, ET4000, ET4000W32, ET4000W32i,
>       ^^^^^
> [ ... ]
> (--) SVGA: PCI: Matrox MGA 1064SG rev 3, Memory @ 0xff000000, 0xfe800000, MMIO @ 0xffbec000
> (--) SVGA: chipset:  fbdev
> (--) SVGA: videoram: 4096k
> (**) SVGA: Using 16 bpp, Depth 16, Color weight: 565
> (--) SVGA: Maximum allowed dot-clock: 90.000 MHz
> (**) SVGA: Mode "1024x768": mode clock =  85.000
> (**) SVGA: Mode "800x600": mode clock =  49.000
> (**) SVGA: Mode "640x480": mode clock =  36.000
> (**) SVGA: Mode "400x300": mode clock =  25.000
> (**) SVGA: Mode "320x240": mode clock =  15.750
> (**) SVGA: Mode "PAL": mode clock =  50.000
> (--) SVGA: Virtual resolution set to 1024x768
> fbdev: accelerator=Matrox MGA1064SG (Mystique), fb=0xff000000+4194304k, mmio=0xffbec000+16384
> (--) SVGA: Using XAA (XFree86 Acceleration Architecture)
> (--) SVGA: XAA: Solid filled rectangles
> (--) SVGA: XAA: Screen-to-screen copy
> (--) SVGA: XAA: 8x8 color expand pattern fill
> (--) SVGA: XAA: CPU to screen color expansion (TE/NonTE imagetext, TE/NonTE polytext)
> (--) SVGA: XAA: Using 8 128x128 areas for pixmap caching
> (--) SVGA: XAA: Caching tiles and stipples
> (--) SVGA: XAA: General lines and segments
> (--) SVGA: XAA: Dashed lines and segments
> 
> Runs happily on the matrox mystique, even if it works as secondary
> display.  Fully Accelerated.  Patches against XFree 3.3.3 available by

YES!! Thanks a lot!

> mail.

Please send me a copy...

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
