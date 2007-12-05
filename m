Return-Path: <lethal@linux-sh.org>
Received: from mx.gate01.com (pip10.gyao.ne.jp [61.122.117.248])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A813CDE086
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 11:49:11 +1100 (EST)
Date: Wed, 5 Dec 2007 09:48:41 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 2/4] [libata] pata_of_platform: OF-Platform PATA device
	driver
Message-ID: <20071205004841.GA25905@linux-sh.org>
References: <20071204170442.GA10460@localhost.localdomain>
	<20071204170719.GB15599@localhost.localdomain>
	<20071204184826.GA5758@lixom.net>
	<20071204194921.GB1253@localhost.localdomain>
	<20071204200121.GA6782@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071204200121.GA6782@lixom.net>
Cc: linux-ide@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 04, 2007 at 02:01:21PM -0600, Olof Johansson wrote:
> On Tue, Dec 04, 2007 at 10:49:21PM +0300, Anton Vorontsov wrote:
> >  	tristate "Generic platform device PATA support"
> > -	depends on EMBEDDED || ARCH_RPC
> > +	depends on EMBEDDED || ARCH_PPC
> 
> It needs to be || PPC, not || ARCH_PPC.
> 
Wrong. It needs to be EMBEDDED || ARCH_RPC || PPC.

ARCH_RPC is not a typo, it's an ARM platform. Please grep first :-)
