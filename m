Date: Thu, 28 Oct 1999 20:44:41 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: anthony tong <atong@uiuc.edu>
cc: Charlie McLachlan <cim@uk.research.att.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Accel ATI Rage 128 support, the very first step (Help needed)
In-Reply-To: <19991028012551.A16581@mango.genunix.net>
Message-ID: <Pine.LNX.4.05.9910282043170.6037-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 28 Oct 1999, anthony tong wrote:
> Charlie McLachlan (Wed, Oct 27, 1999 at 11:46:15AM +0100):
> > 2) If I recompile aty128fb, how do I replace the currently active version
> > without having to restart? (i.e. how do I change frame buffer modules?)
> 
> You don't; at least, I've never been able to unregister a fbdev driver
> and re-registering a new one. I'm not sure if this has been fixed recently
> though.

If you have a second active frame buffer device, you can unload the first after
you mapped all VCs to the second. It works for me: I can unload/reload vga16fb
for my S3 Trio64V+ while atyfb serves my RAGE II+.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
