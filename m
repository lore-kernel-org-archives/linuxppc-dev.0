Return-Path: <geert@linux-m68k.org>
Received: from witte.sonytel.be (witte.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 681F967A5D
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jan 2005 02:27:40 +1100 (EST)
Date: Wed, 19 Jan 2005 16:27:17 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <F0F87817-6A2C-11D9-AC28-000393DBC2E8@freescale.com>
Message-ID: <Pine.GSO.4.61.0501191622060.15516@waterleaf.sonytel.be>
References: <Pine.GSO.4.61.0501191606260.15516@waterleaf.sonytel.be>
	<F0F87817-6A2C-11D9-AC28-000393DBC2E8@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] raid6: altivec support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 19 Jan 2005, Kumar Gala wrote:
> On Jan 19, 2005, at 9:08 AM, Geert Uytterhoeven wrote:
> > On Wed, 19 Jan 2005, David Woodhouse wrote:
> > > The binary structure which changes every few weeks and which is shared
> >  > between the bootloader and the kernel? Yeah, "somewhat broken" is one
> > > way of putting it :)
> >  >
> > > The ARM kernel does it a lot better with tag,value pairs.
> > 
> > As does m68k... That's why we never got beyond bootinfo major version 2.
> 
> Out of interest, on ARM & m68k I would assume that the list of tag's gets
> added to over time?

That's true. But besides the recent conversion of the HP9000/[34]00 code to
use bootinfo, not much has changed during the last 5 years.

If a tag is not recognized, it's just ignored. That means your new feature
cannot be used by the kernel, but it doesn't break the bootloader<->kernel
interface the hard way.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
