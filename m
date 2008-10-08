Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 33B3FDE876
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 06:22:55 +1100 (EST)
Message-ID: <48ED0880.4090504@freescale.com>
Date: Wed, 08 Oct 2008 14:22:40 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: remove CHRP and PMAC support from defconfigs,
	fix Kconfigs
References: <1222449586-14622-1-git-send-email-timur@freescale.com>	
	<ed82fe3e0810080828r115b3e85laf08e8d1e47faf42@mail.gmail.com>
	<1223493596.8157.80.camel@pasglop>
In-Reply-To: <1223493596.8157.80.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

> yeah well, there's a consistency problem. If we remove default for these
> we should remove default for all.

I only removed the default from the ones I knew were wrong.

> The bug I think is in your original patch in fact to just remove those
> from .config rather than explicitely set them to "not set".

I did that because with the Kconfig changes, it's not necessary to set them to
"not set", so it kept the patch smaller.

> I'm not going to remove the applied patch to avoid rebasing, it's
> harmless to keep it in, please send another one that does the above.

Ok.

-- 
Timur Tabi
Linux kernel developer at Freescale
