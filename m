Date: Tue, 26 Oct 1999 20:19:04 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
cc: luther@dpt-info.u-strasbg.fr, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org, jmb@montana.edu
Subject: Re: iBook/UMA pre3
In-Reply-To: <Pine.LNX.4.10.9910261012010.1206-100000@opus.bloom.county>
Message-ID: <Pine.LNX.4.05.9910262018310.665-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 26 Oct 1999, Tom Rini wrote:
> On Tue, 26 Oct 1999, Sven LUTHER wrote:
> > On Mon, Oct 25, 1999 at 10:36:13PM +0200, Benjamin Herrenschmidt wrote:
> > > I updated the patches and kernel to a new version. PCI config is fully
> > > working now, USB works too. I'n now running MacOS under mac-on-linux (the
> > > new version that doesn't require you to patch the kernel) on linux on the
> > > iBook ;)
> > 
> > Is any iof the scsi on USB controllers supported by linux ? 
> > 
> > Is some one working on this, is it difficult to do ?
> 
> They supposedly work, tho I'm not sure if anyone has tried it w/ an OHCI
> controller.

And don't expect it to be faster than the ATA slow-PIO disk. USB (in its
current incarnation) tops at 12 Mbps.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
