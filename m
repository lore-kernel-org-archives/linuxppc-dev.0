Date: Tue, 28 Jan 2003 10:41:20 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Lanners <mlan@cpu.lu>
Cc: vroopcha@mcw.edu,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Info on IO vs. Memory mapped PCI configuration ...
In-Reply-To: <E18dHWJ-00008i-00@piglet.grunz.lu>
Message-ID: <Pine.GSO.4.21.0301281040070.9269-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 27 Jan 2003, Michel Lanners wrote:
> On  27 Jan, this message from vinai echoed through cyberspace:
> > I am just getting into some driver programming for my work.  I read a
> > bit of the PCI System Architecture book, and it talked about one of the
> > main ways x86 vs the PPC did PCI configuration was through IO vs memory
> > space.
>
> Configration? That's inherently platform-dependant. The host bridge
> arranges for _some_ way of configuration space access to be available.
> _You_ need to know _how_ you access it from the bridge docs.

It's explained in the PCI System Architecture book for PReP-style PPC host
bridges only. Other host bridges behave different, check out their technical
docs (if you can find them), or look at the arch/ppc/kernel/*pci.c files.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
