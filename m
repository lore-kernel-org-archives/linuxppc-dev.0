Return-Path: <SRS0+10f07f6f278ab718f41d+514+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [205.233.218.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E433767A2C
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jan 2005 01:48:39 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <BD84893E-6A28-11D9-AC28-000393DBC2E8@freescale.com>
References: <1106120622.10851.42.camel@baythorne.infradead.org>
	<BD84893E-6A28-11D9-AC28-000393DBC2E8@freescale.com>
Content-Type: text/plain
Date: Wed, 19 Jan 2005 14:48:03 +0000
Message-Id: <1106146083.26551.526.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
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

On Wed, 2005-01-19 at 08:45 -0600, Kumar Gala wrote:
> We did talk about looking at using some work Ben did in ppc64 with OF 
> in ppc32.  John Masters was looking into this, but I havent heard much
> from him on it lately.
> 
> The firmware interface on the ppc32 embedded side is some what broken 
> in my mind.

The binary structure which changes every few weeks and which is shared
between the bootloader and the kernel? Yeah, "somewhat broken" is one
way of putting it :)

The ARM kernel does it a lot better with tag,value pairs.

-- 
dwmw2
