Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id EE98A67A2C
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jan 2005 01:55:05 +1100 (EST)
In-Reply-To: <1106146083.26551.526.camel@hades.cambridge.redhat.com>
References: <1106146083.26551.526.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <115DD72E-6A2A-11D9-AC28-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 19 Jan 2005 08:54:49 -0600
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] raid6: altivec support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 19, 2005, at 8:48 AM, David Woodhouse wrote:

> On Wed, 2005-01-19 at 08:45 -0600, Kumar Gala wrote:
>  > We did talk about looking at using some work Ben did in ppc64 with=20=

> OF
> > in ppc32.=A0 John Masters was looking into this, but I havent heard=20=

> much
>  > from him on it lately.
>  >
> > The firmware interface on the ppc32 embedded side is some what =
broken
> > in my mind.
>
> The binary structure which changes every few weeks and which is shared
>  between the bootloader and the kernel? Yeah, "somewhat broken" is one
> way of putting it :)
>
> The ARM kernel does it a lot better with tag,value pairs.

The funny thing is that one of the variants on ppc32 supports tag,=20
value pairs

- kumar=
