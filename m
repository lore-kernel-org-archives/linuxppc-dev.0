Return-Path: <geert@linux-m68k.org>
Received: from witte.sonytel.be (witte.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 7788B67A5D
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jan 2005 02:08:42 +1100 (EST)
Date: Wed, 19 Jan 2005 16:08:07 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1106146083.26551.526.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.GSO.4.61.0501191606260.15516@waterleaf.sonytel.be>
References: <1106120622.10851.42.camel@baythorne.infradead.org>
	<BD84893E-6A28-11D9-AC28-000393DBC2E8@freescale.com>
	<1106146083.26551.526.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] raid6: altivec support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 19 Jan 2005, David Woodhouse wrote:
> On Wed, 2005-01-19 at 08:45 -0600, Kumar Gala wrote:
> > We did talk about looking at using some work Ben did in ppc64 with OF 
> > in ppc32.  John Masters was looking into this, but I havent heard much
> > from him on it lately.
> > 
> > The firmware interface on the ppc32 embedded side is some what broken 
> > in my mind.
> 
> The binary structure which changes every few weeks and which is shared
> between the bootloader and the kernel? Yeah, "somewhat broken" is one
> way of putting it :)
> 
> The ARM kernel does it a lot better with tag,value pairs.

As does m68k... That's why we never got beyond bootinfo major version 2.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
