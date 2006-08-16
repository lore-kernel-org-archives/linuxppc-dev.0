Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5611967B6D
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 02:30:55 +1000 (EST)
Message-ID: <44E34825.2020105@garzik.org>
Date: Wed, 16 Aug 2006 12:30:29 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 1/2]:  powerpc/cell spidernet bottom half
References: <20060811170337.GH10638@austin.ibm.com>
	<20060816161856.GD20551@austin.ibm.com>
In-Reply-To: <20060816161856.GD20551@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: akpm@osdl.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:
> Please apply and forward upstream. This patch requires the previous
> sequence of 4 spidernet patches to be applied.
> 
> --linas
> 
> 
> The recent set of low-waterark patches for the spider result in a
> significant amount of computing being done in an interrupt context.
> This patch moves this to a "bottom half" aka work queue, so that
> the code runs in a normal kernel context. Curiously, this seems to 
> result in a performance boost of about 5% for large packets.
> 
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> Cc: Utz Bacher <utz.bacher@de.ibm.com>
> Cc: Jens Osterkamp <Jens.Osterkamp@de.ibm.com>

Let's not reinvented NAPI, shall we...

	Jeff
