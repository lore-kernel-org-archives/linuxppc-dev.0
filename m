Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 944F1DDDDB
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Sep 2007 09:32:27 +1000 (EST)
Message-ID: <46EC6B86.3050405@garzik.org>
Date: Sat, 15 Sep 2007 19:32:22 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] ucc_geth: fix compilation
References: <20070912112456.GA15556@localhost.localdomain>
	<20070913152333.GA2381@localhost.localdomain>
In-Reply-To: <20070913152333.GA2381@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> Currently qe_bd_t is used in the macro call -- dma_unmap_single,
> which is a no-op on PPC32, thus error is hidden today. Starting
> with 2.6.24, macro will be replaced by the empty static function,
> and erroneous use of qe_bd_t will trigger compilation error.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> 
> Reposting this to include netdev in Cc.
> 
>  drivers/net/ucc_geth.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

applied
