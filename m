Return-Path: <SRS0+0172f75cf8e7244956cd+1562+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4682DDDE33
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 02:13:44 +1100 (EST)
Subject: Re: [PPC BOOT] Find device-tree source file in default directory.
From: David Woodhouse <dwmw2@infradead.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20071203150843.GA4393@loki.buserror.net>
References: <1196650083.13978.113.camel@pmac.infradead.org>
	<1196650164.13978.115.camel@pmac.infradead.org>
	<20071203150843.GA4393@loki.buserror.net>
Content-Type: text/plain
Date: Mon, 03 Dec 2007 15:13:39 +0000
Message-Id: <1196694819.13978.158.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-12-03 at 09:08 -0600, Scott Wood wrote:
> Shouldn't this be $srctree (which doesn't seem to be passed to wrapper at
> the moment), not $object?
> 
> BTW, if we do this, we should remove the part in arch/powerpc/boot/Makefile
> where this is done.

It wasn't really done for the benefit of the in-kernel invocation -- it
was done so that the installed standalone copy of the wrapper doesn't
need a full path.

We _could_ make the in-kernel setup use it -- but then you just have to
pass the directory as a separate argument, instead of prepending it to
the name of the dts file, as you observe... so there didn't seem to be a
lot of point.

-- 
dwmw2
