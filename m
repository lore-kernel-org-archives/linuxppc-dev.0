Message-ID: <3A5E1B8C.5CC5A7DC@relog.ch>
Date: Thu, 11 Jan 2001 21:46:04 +0100
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: michdaen@iiic.ethz.ch
MIME-Version: 1.0
To: erik cameron <cameron@dura.spc.uchicago.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: '99 powerbook (lombard)/xfree 4.0.x
References: <20010111154325.D2651@ccp.uchicago.edu>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


erik cameron wrote:
>
> has anyone tested (successfully) xfree86 4 with a '99 powerbook g3,
> specifically using the r128 driver?  i've been having all sorts of
> problems with it, and there seems to be a dearth of information on this
> hardware/software combination.  i've tried 4.0.1 and 4.0.2, both from
> packages and from source, and i've tried several of the r128_drv.o files.
> this, from /var/log/XFree86.0.log, seems important:
>
> (--) PCI: (0:17:0) ATI Mach64 LI rev 220, Mem @ 0x81000000/24,
> 0x80881000/12, I/O @ 0x0c00/8

As you can see, you have a Mach64 chip, not a Rage128.


> this shows up during the pci scan.  i'm assuming that the only problem
> is getting the x server to recognize the card as a rage 128...  have any
> of you seen this?
>
> this is the final result:
>
> (II) ATI: ATI driver (version 6.2.3) for chipsets: ati
> (II) R128: Driver for ATI Rage 128 chipsets: ATI Rage 128 RE (PCI),
>         ATI Rage 128 RF (AGP), ATI Rage 128 RG (AGP), ATI Rage 128 RK (PCI),
>         ATI Rage 128 RL (AGP), ATI Rage 128 Pro PF (AGP), ATI Rage 128 PR,
>         ATI Rage 128 Mobility LE (PCI), ATI Rage 128 Mobility LF (AGP),
>         ATI Rage 128 Mobility MF (AGP), ATI Rage 128 Mobility ML (AGP)
> (II) RADEON: Driver for ATI Radeon chipsets: ATI Radeon QD (AGP),
>         ATI Radeon QE (AGP), ATI Radeon QF (AGP), ATI Radeon QG (AGP)
> (EE) No devices detected.

Try the ati driver (which has been merged to support all ATI hardware in 4.0.2
BTW), but beware that you may experience trouble if you're booting with BootX.


> '99 (lombard) powerbook g3
> ati rage 128 3d lt pro

There's no such thing. Erase the '128'.

> kernel version 2.2.18pre21
> debian 2.2

There has been much discussion about X on the Lombard on the debian-powerpc
list in the past months.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and the DRI project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
