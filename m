Date: Mon, 19 Jan 2004 15:00:20 +0100
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040119140020.GA21261@iliana>
References: <20040118144412.GA6897@iliana> <1074443601.9704.164.camel@thor.asgaard.local> <20040119134831.GA21093@iliana> <Pine.GSO.4.58.0401191453400.551@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <Pine.GSO.4.58.0401191453400.551@waterleaf.sonytel.be>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 19, 2004 at 02:54:32PM +0100, Geert Uytterhoeven wrote:
> On Mon, 19 Jan 2004, Sven Luther wrote:
> > On Sun, Jan 18, 2004 at 05:33:21PM +0100, Michel Dänzer wrote:
> > > You may want to try my dri-trunk-sid packages.
> >
> > Just tried (all three packages) and my Radeon 9200 SE is not recognized :
> >
> > (II) PCI: 10:08:0: chip 1002,5964 card 148c,2073 rev 01 class 03,00,00 hdr 00
> > ...
> > (WW) ATI:  PCI/AGP Mach64 in slot 16:8:0 could not be detected!
>
> That's a warning from the Mach64 driver, not from the Radeon driver?

Yes, indeed it is. And in fact i see :

(II) ATI: ATI driver (version 6.5.3) for chipset: ati
...
(II) RADEON: Driver for ATI Radeon chipsets: ATI Radeon QD (AGP),
...
        ATI Radeon 9200 5962 (AGP), ATI Radeon 9200SE 5964 (AGP),

Which is my graphic card, but then :

        ATI Radeon 9800XT NJ (AGP)
(II) Primary Device is: PCI 10:08:0
(II) ATI:  Candidate "Device" section "Generic Video Card".
(WW) ATI:  PCI/AGP Mach64 in slot 16:8:0 could not be detected!
(EE) No devices detected.

So, i wonder what is going on.

Full log can be found at :

  http://people.debian.org/~luther/XFree86.Michel.log

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
