Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 4E8C267A5D
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jan 2005 02:15:43 +1100 (EST)
In-Reply-To: <Pine.GSO.4.61.0501191606260.15516@waterleaf.sonytel.be>
References: <Pine.GSO.4.61.0501191606260.15516@waterleaf.sonytel.be>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <F0F87817-6A2C-11D9-AC28-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 19 Jan 2005 09:15:23 -0600
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
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


On Jan 19, 2005, at 9:08 AM, Geert Uytterhoeven wrote:

> On Wed, 19 Jan 2005, David Woodhouse wrote:
>  > On Wed, 2005-01-19 at 08:45 -0600, Kumar Gala wrote:
>  > > We did talk about looking at using some work Ben did in ppc64=20
> with OF
> > > in ppc32.=A0 John Masters was looking into this, but I havent =
heard=20
> much
>  > > from him on it lately.
>  > >
> > > The firmware interface on the ppc32 embedded side is some what=20
> broken
> > > in my mind.
> >
> > The binary structure which changes every few weeks and which is=20
> shared
>  > between the bootloader and the kernel? Yeah, "somewhat broken" is=20=

> one
> > way of putting it :)
>  >
> > The ARM kernel does it a lot better with tag,value pairs.
>
> As does m68k... That's why we never got beyond bootinfo major version=20=

> 2.

Out of interest, on ARM & m68k I would assume that the list of tag's=20
gets added to over time?

- kumar
