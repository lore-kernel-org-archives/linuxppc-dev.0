Date: Tue, 8 Feb 2000 22:39:33 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Retrace
In-Reply-To: <20000208223045.004499@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.05.10002082238430.889-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 8 Feb 2000, Benjamin Herrenschmidt wrote:
> On Tue, Feb 8, 2000, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> >The BAR values in PCI config space may be the same, but the BAR values in
> >struct pci_dev can be made different by the machine-specific fixup code.
>
> This would work as long as no one reads the BAR directly. I know no-one
> should do it, but I've seen some time ago (can't remember where) some
> drivers reading BARs directly. Also, I don't know for the X server.

If drivers use the BARs directly, they're broken and won't work on other archs
like SPARC64 neither.

X should use /proc/bus/pci, which relies on struct pci_dev as well.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
