Date: Wed, 14 Nov 2001 07:28:20 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Robert E Brose II <bob@kunk.jriver.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: E15 Carolina Frame Buffer Driver for 2.4
In-Reply-To: <20011113155734.28247.qmail@kunk.jriver.com>
Message-ID: <Pine.GSO.4.21.0111140727240.2370-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 13 Nov 2001, Robert E Brose II wrote:
> I have gotten the 2.2 framebuffer driver for the E15 (internal)
> display adapter in the IBM 7248-133 43p (carolina Prep MB) to
> work (on my machine anyway) in 2.4. This provides a way to
> run X with the 2.4 kernels on this hardware.
>
> Here is a patch against the benh rsync tree from last night...
>
> http://www.qbjnet.com/~bob/e15fb-2.4.15-pre3-benh-patch
>
> It would be interesting to hear if it works on other variations
> of the 7248.

Can't this be merged with the various frame buffer devices for S3 that are
available on the net?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
