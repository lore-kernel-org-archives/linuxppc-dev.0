Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0E4B1DE0F5
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 03:51:15 +1000 (EST)
Message-ID: <4703D68E.9010000@garzik.org>
Date: Wed, 03 Oct 2007 13:51:10 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: "Valentine Barshak (by way of Josh Boyer <jwboyer@linux.vnet.ibm.com>)"
	<vbarshak@ru.mvista.com>
Subject: Re: [PATCH] Fix typo in new EMAC driver.
References: <20071002120107.GA21847@ru.mvista.com>
In-Reply-To: <20071002120107.GA21847@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Valentine Barshak (by way of Josh Boyer <jwboyer@linux.vnet.ibm.com>) wrote:
> Fix an obvious typo in emac_xmit_finish.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> ---
>  drivers/net/ibm_newemac/core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

applied
