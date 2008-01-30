Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 52110DDE09
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 19:41:35 +1100 (EST)
Message-ID: <47A03830.7070907@pobox.com>
Date: Wed, 30 Jan 2008 03:41:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] [NET]: Remove PowerPC code from fec.c
References: <4799F349.9090102@scram.de>
In-Reply-To: <4799F349.9090102@scram.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linux-m68k@vger.kernel.org, "Kernel, Linux" <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jochen Friedrich wrote:
> fec.c is only used on M68k Coldfire CPUs. Remove leftover
> PowerPC code from this driver.
> 
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> ---
>  drivers/net/fec.c |  136 +---------------------------------------------------
>  1 files changed, 3 insertions(+), 133 deletions(-)

Seems OK to me, but I feel I don't have enough knowledge to ACK or NAK. 
  Please pass through an arch tree, thanks.

	Jeff
