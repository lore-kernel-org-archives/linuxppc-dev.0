Date: Tue, 28 Mar 2000 19:51:08 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
cc: ajoshi@shell.unixbox.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: Some issues to resolve with XFree 4.0 yet
In-Reply-To: <20000329015122J.roikawa@rr.iij4u.or.jp>
Message-ID: <Pine.LNX.4.05.10003281949370.17650-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 29 Mar 2000, Ryuichi Oikawa wrote:
> From: Ani Joshi <ajoshi@shell.unixbox.com>
> Subject: Re: Some issues to resolve with XFree 4.0 yet
> > On Tue, 28 Mar 2000, Ryuichi Oikawa wrote:
> > > BTW, I noticed an interesting x11perf score. x11perf -scroll500 marked ~300/sec
> > > for ATI Rage128RE connected to 66MHz bus on B&W G3 rev.1, but ~600/sec for an
> > > old Matrox Millennium II to 33MHz bus, measured at 32bpp/24bit depth.
> >
> > are you using the patch I posted last week?  If not, then I suggest you
> Yes, I am. But Rage128RE score was only ~300/sec at 1280x1024x32bpp/75Hz.
> (The score is very sensitive to actual(not virtual) screen size and refresh rate).

The old Millennium II had dual-ported WRAM, so the accel engine wasn't
sensitive to refresh rate. But single-ported commodity SDRAM/SGRAM is cheaper,
so WRAM was killed.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
