Date: Sun, 18 Jan 2004 22:38:35 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH 2.6] LongTrail W83C553 IDE
In-Reply-To: <16394.63877.394603.88313@cargo.ozlabs.ibm.com>
Message-ID: <Pine.GSO.4.58.0401182235410.4900@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0401181317170.653@callisto>
 <16394.63877.394603.88313@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 19 Jan 2004, Paul Mackerras wrote:
> Geert Uytterhoeven writes:
> > The patch below enables the W83C553 IDE interface on the CHRP LongTrail.
> > It's a straight forward port of the W83C553 fixup code for LongTrail and Briq
> > in 2.4.x. It was tested on LongTrail only, using a ST340810ACE hard drive.
> > Briq support may need additional changes.
>
> Can we figure out a way to do this without so many #ifdefs, please?

Sure, the reason I added the various incarnations of #ifdef
BRIQ_SUPPORT_IS_THERE is that the other parts of BriQ support are missing in
2.6, unlike in 2.4.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
