Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 87307679EA
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 10:09:16 +1100 (EST)
Message-ID: <442B0BA2.9020200@garzik.org>
Date: Wed, 29 Mar 2006 17:35:14 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH] Janitor: drivers/net/pcnet32: fix incorrect comments
References: <20060328223623.GD2172@austin.ibm.com>
In-Reply-To: <20060328223623.GD2172@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: tsbogend@alpha.franken.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jklewis@us.bm.com,
	linuxppc-dev@ozlabs.org, donf@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:
> Please sign-off/ack/apply and/or forward upstream.
> 
> [PATCH] Janitor: drivers/net/pcnet32: fix incorrect comments
> 
> The comments concerning how the pcnet32 ethernet device driver selects 
> the MAC addr to use are incorrect. A recent patch (in the last 3 months)
> changed how the code worked, but did not change the comments.
> 
> Side comment: the new behaviour is good; I've got a pcnet32 card which
> powers up with garbage in the CSR's, and a good MAC addr in the PROM.
> 
> Signed-off-by: Linas Vepstas <linas@linas.org>

applied
