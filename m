Date: Thu, 27 Jan 2000 23:38:47 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>
Subject: Re: [linux-fbdev] vgacon, vga16fb, clgenfb on PPC
In-Reply-To: <Pine.LNX.3.96.1000127161526.32564L-100000@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.LNX.4.05.10001272338160.425-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 27 Jan 2000, Jeff Garzik wrote:
> On Thu, 27 Jan 2000, Geert Uytterhoeven wrote:
> > I revised my patch to make vga16fb and clgenfb compile (as modules, in my
> > case). I couldn't test clgenfb, but vga16fb works fine as my second head (S3
> [...]
>
> I was hoping someone would patch up clgenfb for Zorro.  When I updated
> it, I tried to make initialization as obvious as possible to correct.
>
> Please let me know if there are any success or failure reports for
> clgenfb...  I would love to continue to support it on Zorro, but don't
> have the hardware to do so...

Zorro patches are something different. I posted them to the linux-m68k list a
few days ago.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
