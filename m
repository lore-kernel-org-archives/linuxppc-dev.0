Date: Tue, 21 Mar 2000 09:57:32 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Matt Brubeck <mbrubeck@hmc.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: aty128fb patch on iMac DV
In-Reply-To: <Pine.GSO.4.21.0003202326590.17973-100000@turing.cs.hmc.edu>
Message-ID: <Pine.LNX.4.05.10003210956450.29327-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 21 Mar 2000, Matt Brubeck wrote:
> I applied Kevin Hendricks' latest rage128.patch, and aty128fb now works
> perfectly in 8-bit color. It still fails as before in 15/16, 24, and
> 32-bit modes. I get the following message when I do "fbset -depth 16":
>
> fbcon_setup: No support for fontwidth 8
> fbcon_setup: type 0 (aux 0, depth 16) not supported

You have to enable

    CONFIG_FBCON_CFB16=y
    CONFIG_FBCON_CFB24=y
    CONFIG_FBCON_CFB32=y

for 16/24/32 bpp text console support.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
