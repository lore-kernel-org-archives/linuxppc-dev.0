Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 9BA5967A65
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jan 2005 05:54:27 +1100 (EST)
In-Reply-To: <1106120622.10851.42.camel@baythorne.infradead.org>
References: <1106120622.10851.42.camel@baythorne.infradead.org>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <BD84893E-6A28-11D9-AC28-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 19 Jan 2005 08:45:19 -0600
To: "David Woodhouse" <dwmw2@infradead.org>
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

David,

We did talk about looking at using some work Ben did in ppc64 with OF=20
in ppc32.  John Masters was looking into this, but I havent heard much=20=

from him on it lately.

The firmware interface on the ppc32 embedded side is some what broken=20
in my mind.

- kumar

On Jan 19, 2005, at 1:43 AM, David Woodhouse wrote:

> On Wed, 2005-01-19 at 15:11 +1100, Benjamin Herrenschmidt wrote:
>  > We should probably "backport" that simplification to ppc32...
>
> Yeah.... I'm increasingly tempted to merge ppc32/ppc64 into one arch
>  like mips/parisc/s390. Or would that get vetoed on the basis that we
>  don't have all that horrid non-OF platform support in ppc64 yet, and
> we're still kidding ourselves that all those embedded vendors will
>  either not notice ppc64 or will use OF?
>
> --=20
> dwmw2
>
>
>
> -
>  To unsubscribe from this list: send the line "unsubscribe=20
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html
>  Please read the FAQ at=A0 http://www.tux.org/lkml/
