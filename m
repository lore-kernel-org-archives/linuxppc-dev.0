Date: Tue, 17 Jul 2001 09:18:53 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Joseph P. Garcia" <jpgarcia@execpc.com>
Cc: linuxppc-dev@lists.linuxppc.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.4 - buttons, temperature, ictc
In-Reply-To: <20010717004540.255d1b2c.jpgarcia@execpc.com>
Message-ID: <Pine.LNX.4.05.10107170917410.10614-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 17 Jul 2001, Joseph P. Garcia wrote:
> - small ATY resource tweak in pmac_pci.c (I like it at 0x830--.  not sure if 0x800-- is best or not.  ignore if you like.)

Why is it necessary to hardcode this address? It may clash with another device.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
