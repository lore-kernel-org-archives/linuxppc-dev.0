Return-Path: <SRS0+61c71195c88f4b174b7b+595+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org
	[81.187.226.107])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CE85B67B34
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Apr 2005 18:28:31 +1000 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1113091621.9518.450.camel@gaston>
References: <1112594783.26086.22.camel@gaston>
	<1113064594.4636.28.camel@localhost.localdomain>
	<1113089830.9518.444.camel@gaston>
	<1113090515.12012.65.camel@baythorne.infradead.org>
	<1113091621.9518.450.camel@gaston>
Content-Type: text/plain
Date: Sun, 10 Apr 2005 09:28:22 +0100
Message-Id: <1113121703.12012.70.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: iBook G3 owners
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2005-04-10 at 10:07 +1000, Benjamin Herrenschmidt wrote:
> Can you check that you have the very latest versions of these
> patches ?
> I updated them a couple of time since I posted the message...

The md5sums of the patches I have precisely match the md5sums of the
patches which are currently up for download:

fc63b0d57d26f2dec44d0ba1667eb263  linux-2.6.11-ppc32-pmac-sleep-fix.patch
29792fdd1970b9447d06a2bb044e48e0  linux-2.6.11-cpufreq-add-suspend.patch
dcdb468b9325c1835e9992034b7d8a28  linux-2.6.11-ppc32-750-erratum-fix.patch
689353b33f3bdc7759692a4cccdb24fa  linux-2.6.11-ppc32-cpufreq-gpio-off.patch

A kernel without _any_ of these patches survived an overnight sleep, and
in fact cpufreq was working again too. I'll try with just the cpufreq
patches.

-- 
dwmw2
