Message-ID: <38DF4E37.61DFEFA9@iiic.ethz.ch>
Date: Mon, 27 Mar 2000 14:04:07 +0200
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Kostas Gewrgiou <gewrgiou@imbc.gr>, Gabriel Paubert <paubert@iram.es>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
References: <Pine.LNX.4.10.10003271355370.32203-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:

> > There's a difference between bpp (`bit per pixel': 8, 16, 24 or 32 are
> > supported by atyfb) and depth (8, 15 and 24 are supported by atyfb).
>
> Imagine my confusion.

'depth' is the number of bits used to determine the color of a pixel.

'framebuffer bpp' is the number of bits a pixel takes up in memory.


> What bpp will X use for depth 24 by default?

24.

Or then maybe it depends on the driver? Check yourself in the server output or
the log.


> Would 32 help any?

Maybe, because pixels correspond to words directly.


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
