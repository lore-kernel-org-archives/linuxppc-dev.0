Return-Path: <geert@linux-m68k.org>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 4C2E7DDE0A
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Jan 2007 20:58:55 +1100 (EST)
Date: Fri, 5 Jan 2007 10:36:40 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonytel.be
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [RFC: 2.6 patch] remove the broken FB_S3TRIO driver
In-Reply-To: <20070104185403.GK20714@stusta.de>
Message-ID: <Pine.LNX.4.62.0701051036170.17589@pademelon.sonytel.be>
References: <20070104185403.GK20714@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: adaplas@pol.net, Paul Mackerras <paulus@samba.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 4 Jan 2007, Adrian Bunk wrote:
> The FB_S3TRIO driver:
> - has been marked as BROKEN for more than two years and
> - is still marked as BROKEN.
> 
> Drivers that had been marked as BROKEN for such a long time seem to be
> unlikely to be revived in the forseeable future.

As there's a new generic S3Trio driver in the works...

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
