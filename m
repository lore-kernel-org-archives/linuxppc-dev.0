Date: Sun, 18 Jan 2004 13:31:27 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Debian PowerPC List <debian-powerpc@lists.debian.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.21-ben2 issues: RTC, Thermal and RTAS
In-Reply-To: <20040118121754.GA4916@iliana>
Message-ID: <Pine.GSO.4.58.0401181330330.2808@waterleaf.sonytel.be>
References: <20031217011849.GA26643@iliana> <Pine.GSO.4.58.0312171042530.24864@waterleaf.sonytel.be>
 <20031217095241.GD2283@iliana> <Pine.GSO.4.58.0312171056030.24864@waterleaf.sonytel.be>
 <20031217100358.GA2655@iliana> <Pine.GSO.4.58.0312171112040.24864@waterleaf.sonytel.be>
 <20040113151230.GA12089@iliana> <Pine.GSO.4.58.0401131806560.9060@waterleaf.sonytel.be>
 <20040113171606.GA13923@iliana> <Pine.GSO.4.58.0401181310240.2808@waterleaf.sonytel.be>
 <20040118121754.GA4916@iliana>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 18 Jan 2004, Sven Luther wrote:
> On Sun, Jan 18, 2004 at 01:14:07PM +0100, Geert Uytterhoeven wrote:
> > On Tue, 13 Jan 2004, Sven Luther wrote:
> > > Can you confirm that the GEN_RTC driver works for you ?
> >
> > To my surprise, genrtc in 2.4.23 does not work on my LongTrail!
> > The kernel crashes in init/do_mounts.c:mount_block_root() right after the call
> > to sys_chdir(), because current->fs is a NULL pointer. Weird, and it doesn't
> > really look genrtc-related, although the same source tree works fine if I
> > disable genrtc and build in rtc.
>
> Weird, it works fine for me, what tree are you using ?

linuxppc-2.4, just after 2.4.23 got merged in.

> I think i remember some part of patch concerning the rtc clock or
> something in the linuxppc diff. Could you try 2.4.24 ?

I may give it a try...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
