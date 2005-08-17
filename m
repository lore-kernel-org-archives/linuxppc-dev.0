Return-Path: <geert@linux-m68k.org>
Received: from witte.sonytel.be (witte.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id D830E67FBD
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2005 21:18:53 +1000 (EST)
Date: Wed, 17 Aug 2005 13:18:40 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
To: Andrey Volkov <avolkov@varma-el.com>
In-Reply-To: <43030D41.3000508@varma-el.com>
Message-ID: <Pine.LNX.4.62.0508171317540.6073@numbat.sonytel.be>
References: <20050816194825.A62AC353AB5@atlas.denx.de>
	<43030D41.3000508@varma-el.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>, surendra.yadav@softdel.com
Subject: Re: [F]Framebuffer driver using SM501 hardware.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 17 Aug 2005, Andrey Volkov wrote:
> Todo:
> - 16 bpp colormap (needed reverse endian support in fbcon/fbmem)

Can you please elaborate? For 2.6, there should be no such problems (for 2.4,
there are).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
