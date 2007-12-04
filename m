Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 9BFDFDDFC6
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 06:57:19 +1100 (EST)
Date: Tue, 4 Dec 2007 14:01:21 -0600
From: Olof Johansson <olof@lixom.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v2 2/4] [libata] pata_of_platform: OF-Platform PATA
	device driver
Message-ID: <20071204200121.GA6782@lixom.net>
References: <20071204170442.GA10460@localhost.localdomain>
	<20071204170719.GB15599@localhost.localdomain>
	<20071204184826.GA5758@lixom.net>
	<20071204194921.GB1253@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071204194921.GB1253@localhost.localdomain>
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

On Tue, Dec 04, 2007 at 10:49:21PM +0300, Anton Vorontsov wrote:
>  	tristate "Generic platform device PATA support"
> -	depends on EMBEDDED || ARCH_RPC
> +	depends on EMBEDDED || ARCH_PPC

It needs to be || PPC, not || ARCH_PPC.


-Olof
