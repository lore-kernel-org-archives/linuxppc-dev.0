Date: Tue, 11 Jul 2000 21:15:08 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Adrian Cox <apc@agelectronics.co.uk>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Going from 2.2.12 to 2.2.17pre10
In-Reply-To: <396B19BF.D2EAF0D7@agelectronics.co.uk>
Message-ID: <Pine.LNX.4.10.10007112110350.1244-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 11 Jul 2000, Adrian Cox wrote:
> Benjamin Herrenschmidt wrote:
> > In the case of Apple HW, the OF device tree is the only way to know about:
> > [big list of things Apple OF tells you]
>
> Actually, I'm whining about nothing. I just did a search of the drivers
> tree, and the only generic PCI device that uses the OF tree is
> chipsfb.c. Of course, that's the one I've been porting to a more generic
> PCI device driver aimed at the later C&T devices.
>
> As Geert has declared intent to move the FB drivers to PCI probing, this
> is a non-issue.

Well, some (control/platinum/valkyrie) will keep on using OF probing since
they're used on PowerMac only. But their initialization routine will no longer
be called by offb.

Prepare to see an (untested, as usual :-) patch for this RSN...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
