Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0E0B4DDDFE
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 11:24:45 +1100 (EST)
Subject: Re: [PATCH 0/4] spidernet: support for Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <45CA4F90.60806@pobox.com>
References: <200702070849.l178nvGC005341@toshiba.co.jp>
	<45CA4F90.60806@pobox.com>
Content-Type: text/plain
Date: Thu, 08 Feb 2007 11:24:18 +1100
Message-Id: <1170894259.2620.325.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, jim@jklewis.com,
	Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-02-07 at 17:15 -0500, Jeff Garzik wrote:
> Ishizaki Kou wrote:
> > This is a revised spidernet patch set based on
> > netdev-2.6.git#upstream.
> > 
> > This patch set is merged Jens-san's spidernet patch and works on
> > Toshiba Cell reference set (aka Celleb). 
> > It requires Jens-san's phy patch
> > (http://ozlabs.org/pipermail/linuxppc-dev/2007-February/030987.html).
> 
> I'm unsure of the status of the phy patch, so will put this patchset on 
> hold until that is resolved

PHY patch is mostly Ok except I don't like that "medium" variable Jens
added which isn't used anywhere in sungem_phy. Jens, can you resend a
version without that ? If you need that variable in spidernet itself,
then put it there :-)

Also, the GMII_* constants, are they standard or 54xx specific ? If the
later, then change the name to reflect that.

Once I have the new patch, I'll give it a test on G5 and if it's ok, it
will be good to go for 2.6.21

Cheers,
Ben.
