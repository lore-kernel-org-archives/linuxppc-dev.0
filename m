Return-Path: <geert@linux-m68k.org>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 24B1667B92
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Nov 2006 21:31:01 +1100 (EST)
Date: Wed, 29 Nov 2006 11:30:58 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonytel.be
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] remove broken video drivers (v3)
In-Reply-To: <20061129100431.GN11084@stusta.de>
Message-ID: <Pine.LNX.4.62.0611291130070.6335@pademelon.sonytel.be>
References: <20061129100431.GN11084@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, Sam Creasey <sammy@sammy.net>,
	linux-m68k@vger.kernel.org,
	James Simmons <jsimmons@infradead.org>, sun3-list@redhat.com,
	Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>, adaplas@pol.net,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 29 Nov 2006, Adrian Bunk wrote:
> This patch removes some video drivers that:
> - had already been marked as BROKEN in 2.6.0 three years ago and
> - are still marked as BROKEN.
> 
> These are the following drivers:
> - FB_CYBER
> - FB_VIRGE
> - FB_RETINAZ3
> - FB_SUN3
> 
> Drivers that had been marked as BROKEN for such a long time seem to be
> unlikely to be revived in the forseeable future.
> 
> But if anyone wants to ever revive any of these drivers, the code is
> still present in the older kernel releases.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-By: Geert Uytterhoeven <geert@linux-m68k.org>

> This patch obsoletes the following patches in -mm:
> ioremap-balanced-with-iounmap-for-drivers-video-cyberfb.patch
> ioremap-balanced-with-iounmap-for-drivers-video-retz3fb.patch
> ioremap-balanced-with-iounmap-for-drivers-video-virgefb.patch

If possible, can these still be integrated first, to ease a future
resurrection?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
