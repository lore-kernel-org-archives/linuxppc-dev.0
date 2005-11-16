Return-Path: <SRS0+150203a680be38a3f079+815+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 268766872A
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Nov 2005 19:52:08 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <1131382971.27347.79.camel@baythorne.infradead.org>
References: <1131357857.27347.28.camel@baythorne.infradead.org>
	<20051107160939.GD3839@smtp.west.cox.net>
	<1131380422.27347.72.camel@baythorne.infradead.org>
	<20051107165453.GA29111@lst.de>
	<1131382971.27347.79.camel@baythorne.infradead.org>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 08:51:56 +0000
Message-Id: <1132131116.28963.75.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Fix 8250 probe on ppc32
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-11-07 at 17:02 +0000, David Woodhouse wrote:
> Or do you just mean the trivial patch to make arch/ppc64/boot/ capable
> of loading a 32-bit kernel? That'll make sense if that code gets moved
> to arch/powerpc/boot, and I'll do so then.

.... except that it seems to have been done already -- the code which
just landed in arch/powerpc/boot can already load a 32-bit kernel.

-- 
dwmw2
