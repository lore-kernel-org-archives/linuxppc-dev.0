Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A7159DDE1B
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 07:50:12 +1100 (EST)
Message-ID: <4755BD7B.6030208@garzik.org>
Date: Tue, 04 Dec 2007 15:50:03 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] pata_of_platform: Move electra-ide support over to new
	framework
References: <20071204170442.GA10460@localhost.localdomain>
	<20071204204432.GD8099@lixom.net>
In-Reply-To: <20071204204432.GD8099@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> [POWERPC] Move electra-ide support over to new pata_of_platform framework
> 
> Move electra-ide glue over to the new pata_of_platform framework, and
> add the quirks needed to that driver.
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> ---
> 
> I'll remove the electra-ide stuff from arch/powerpc/platforms/pasemi
> once this hits a common tree, since otherwise I'd be without IDE until
> they converge (i.e.  2.6.25 merge window).

FWIW I'm presuming this work will go via a powerpc tree not libata... 
Generally that's not the case, but here it's largely an arch-specific work.

	Jeff
