Date: Mon, 6 Aug 2001 09:34:25 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Olaf Hering <olh@suse.de>
Cc: R Shapiro <reshapiro@mediaone.net>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: lcd17 kernel patches?
In-Reply-To: <20010805200639.A14938@suse.de>
Message-ID: <Pine.LNX.4.05.10108060933320.4858-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 5 Aug 2001, Olaf Hering wrote:
> On Sun, Aug 05, R Shapiro wrote:
> > When will the lcd17 kernel patches (needed to run linux on Apple's 17"
> > flat panel display) make it into penguinppc.org::linux-2.4-benh?  Or
> > are they there already? I'm running someone's prebuilt 2.4.2 with
> > those patches right now, since that seemed to be the only way to get
> > them.  But I'd really rather build my own kernel, with my preferred
> > .config and newer souces, if I can.
>
> Try this one in the meantime:
>
> diff -urN linux-2.4.7-orig/drivers/video/macmodes.c
> linux-2.4.7-pci/drivers/video/macmodes.c
> --- linux-2.4.7-orig/drivers/video/macmodes.c   Thu Jun 28 02:10:55 2001
> +++ linux-2.4.7-pci/drivers/video/macmodes.c    Sun Aug  5 20:03:16 2001
> @@ -68,7 +68,7 @@
>         0, FB_VMODE_NONINTERLACED
>      }, {
>         /* 1024x768, 60 Hz, Non-Interlaced (65.00 MHz dotclock) */
> -       "mac14", 60, 1024, 768, 15385, 144, 40, 29, 3, 136, 6,
> +        "mac14", 60, 1280, 1024, 15358, 160, 24, 29, 3, 136, 6,
>         0, FB_VMODE_NONINTERLACED
>      }, {
>         /* 1024x768, 72 Hz, Non-Interlaced (75.00 MHz dotclock) */

IFF this is a correct fix, please also change
  - the name in the comment
  - the ordering in the table a bit lower (must be sorted)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
