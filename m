Date: Mon, 13 Mar 2000 14:05:19 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
cc: Michel Dänzer <michdaen@iiic.ethz.ch>,
        "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work
 onppcwithr128
In-Reply-To: <Pine.LNX.4.21.0003131341340.748-100000@idd-01.imbc.gr>
Message-ID: <Pine.LNX.4.10.10003131401510.32105-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>   Without the BusID line the XServer will disable the pci memory/io
> for the card, it doesn't matter if fbdev_open_pci is used or not.
> What probably happens is that even with the BusID defined the xserver
> still disables your card.

We'll see if that's a problem; right now it hangs earlier.

> The PCI warnings that you get most likely will tell us where the problem
> is, can you send the logfile over ?

Relevant log excerpt:

(II) Loading /usr/X11R6/lib/modules/linux/libfbdevhw.a
(II) Module fbdevhw: vendor="The XFree86 Project"
	compiled for 4.0, module version = 0.0.1
(II) FBDev(1): using default device
(**) FBDev(1): claimed PCI slot 0:17:0
(WW) ****INVALID MEM ALLOCATION**** b: 0x81000000 e: 0x81ffffff correcting
own
        [0] -1  0x81fff000 - 0x81ffffff (0x1000) MXB
	[1] -1  0x00000c00 - 0x00000cff (0x100) IXB
(WW) ****INVALID IO ALLOCATION**** b: 0xc00 e: 0xcff correcting
(**) FBDev(0): Depth 16, (--) framebuffer bpp 16
(==) FBDev(0): RGB weight 565
(==) FBDev(0): Default visual is TrueColor
(==) FBDev(0): Using gamma correction (1.0, 1.0, 1.0)
(II) FBDev(0): Hardware: ATY Mach64 (vidmem: 8184k)

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
