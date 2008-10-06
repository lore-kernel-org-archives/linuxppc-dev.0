Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DA965DDF23
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2008 03:35:19 +1100 (EST)
Message-ID: <48EA3D0C.1050107@freescale.com>
Date: Mon, 06 Oct 2008 11:30:04 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Remi Machet <rmachet@slac.stanford.edu>
Subject: Re: [PATCH] dma: add new dma_mapping_ops API sync_page
References: <1222898599.8628.52.camel@pcds-ts102.slac.stanford.edu>
	<1223051594.4251.12.camel@pcds-ts102.slac.stanford.edu>
In-Reply-To: <1223051594.4251.12.camel@pcds-ts102.slac.stanford.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linux PPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remi Machet wrote:
> After continuing to work on the dma noncoherent code I realized that
> sync_page is not the best choice of API: 
> -The API should preferably take a dma_addr_t in my opinion

A virtual address will typically be needed to perform the flush; why 
pass the bus address?

-Scott
