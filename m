Return-Path: <SRS0+65cdfcdee250eb80995e+514+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org
	[81.187.226.107])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 385DB67A63
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2005 18:43:52 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1106107876.4534.163.camel@gaston>
References: <200501082324.j08NOIva030415@hera.kernel.org>
	<20050109151353.GA9508@suse.de>
	<1105956993.26551.327.camel@hades.cambridge.redhat.com>
	<1106107876.4534.163.camel@gaston>
Content-Type: text/plain
Date: Wed, 19 Jan 2005 07:43:42 +0000
Message-Id: <1106120622.10851.42.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] raid6: altivec support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-01-19 at 15:11 +1100, Benjamin Herrenschmidt wrote:
> We should probably "backport" that simplification to ppc32...

Yeah.... I'm increasingly tempted to merge ppc32/ppc64 into one arch
like mips/parisc/s390. Or would that get vetoed on the basis that we
don't have all that horrid non-OF platform support in ppc64 yet, and
we're still kidding ourselves that all those embedded vendors will
either not notice ppc64 or will use OF?

-- 
dwmw2
