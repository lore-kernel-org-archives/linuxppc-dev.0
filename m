Date: Mon, 19 Jan 2004 14:54:32 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: multiple separate pci bridges ...
In-Reply-To: <20040119134831.GA21093@iliana>
Message-ID: <Pine.GSO.4.58.0401191453400.551@waterleaf.sonytel.be>
References: <20040118144412.GA6897@iliana> <1074443601.9704.164.camel@thor.asgaard.local>
 <20040119134831.GA21093@iliana>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 19 Jan 2004, Sven Luther wrote:
> On Sun, Jan 18, 2004 at 05:33:21PM +0100, Michel Dänzer wrote:
> > You may want to try my dri-trunk-sid packages.
>
> Just tried (all three packages) and my Radeon 9200 SE is not recognized :
>
> (II) PCI: 10:08:0: chip 1002,5964 card 148c,2073 rev 01 class 03,00,00 hdr 00
> ...
> (WW) ATI:  PCI/AGP Mach64 in slot 16:8:0 could not be detected!

That's a warning from the Mach64 driver, not from the Radeon driver?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
