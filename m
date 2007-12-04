Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 01F59DDD01
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 07:35:31 +1100 (EST)
Date: Tue, 4 Dec 2007 14:39:33 -0600
From: Olof Johansson <olof@lixom.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v2 2/4] [libata] pata_of_platform: OF-Platform PATA
	device driver
Message-ID: <20071204203933.GA8099@lixom.net>
References: <20071204170442.GA10460@localhost.localdomain>
	<20071204170719.GB15599@localhost.localdomain>
	<20071204184826.GA5758@lixom.net>
	<20071204194921.GB1253@localhost.localdomain>
	<20071204200121.GA6782@lixom.net>
	<20071204203751.GA3015@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071204203751.GA3015@localhost.localdomain>
Cc: linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
	Arnd Bergmann <arnd@arndb.de>, Jeff Garzik <jeff@garzik.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 04, 2007 at 11:37:51PM +0300, Anton Vorontsov wrote:
> On Tue, Dec 04, 2007 at 02:01:21PM -0600, Olof Johansson wrote:
> > On Tue, Dec 04, 2007 at 10:49:21PM +0300, Anton Vorontsov wrote:
> > >  	tristate "Generic platform device PATA support"
> > > -	depends on EMBEDDED || ARCH_RPC
> > > +	depends on EMBEDDED || ARCH_PPC
> > 
> > It needs to be || PPC, not || ARCH_PPC.
> 
> D'oh.
> 
> - - - -
> From: Anton Vorontsov <avorontsov@ru.mvista.com>
> Subject: [PATCH v2.2] [libata] pata_of_platform: OF-Platform PATA device driver
> 
> This driver nicely wraps around pata_platform library functions,
> and provides OF platform bus bindings to the PATA devices.
> 
> In addition fix ARCH_RPC typo in the PATA_PLATFORM Kconfig entry,
> spotted by Olof Johansson.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Reviewed-by: Olof Johansson <olof@lixom.net>
