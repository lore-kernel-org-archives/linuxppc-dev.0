Date: Tue, 21 Mar 2000 01:29:46 -0800 (PST)
From: Matt Brubeck <mbrubeck@hmc.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: aty128fb patch on iMac DV
In-Reply-To: <Pine.LNX.4.05.10003210956450.29327-100000@callisto.of.borg>
Message-ID: <Pine.GSO.4.21.0003210126560.24640-100000@turing.cs.hmc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 21 Mar 2000, Geert Uytterhoeven wrote:

> > I applied Kevin Hendricks' latest rage128.patch, and aty128fb now works
> > perfectly in 8-bit color. It still fails as before in 15/16, 24, and
> > 32-bit modes. I get the following message when I do "fbset -depth 16":
> >
> > fbcon_setup: No support for fontwidth 8
> > fbcon_setup: type 0 (aux 0, depth 16) not supported
>
> You have to enable
>
>     CONFIG_FBCON_CFB16=y
>     CONFIG_FBCON_CFB24=y
>     CONFIG_FBCON_CFB32=y
>
> for 16/24/32 bpp text console support.

Ahh. That explains the error message from fbcon. But in any case the
framebuffer is having its own problems; the picture is half-sized and
appears in psychedelic colors several times across the screen.

Matt Brubeck


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
