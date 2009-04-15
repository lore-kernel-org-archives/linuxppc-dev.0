Return-Path: <davem@davemloft.net>
Date: Wed, 15 Apr 2009 02:35:48 -0700 (PDT)
Message-Id: <20090415.023548.116886749.davem@davemloft.net>
To: super.firetwister@googlemail.com
Subject: Re: [PATCH] stop send queue before resetting gianfar
From: David Miller <davem@davemloft.net>
In-Reply-To: <200904150951.23711.super.firetwister@gmail.com>
References: <200904150951.23711.super.firetwister@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: Linuxppc-dev@ozlabs.org, rini@arvoo.nl, afleming@freescale.com,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Markus Brunner <super.firetwister@googlemail.com>
Date: Wed, 15 Apr 2009 09:51:23 +0200

> After a transmit timed out, the reset task will be called, which will free the
> allocated resources(stop_gfar). If gfar_poll will be called before the
> resources get allocated again gfar_clean_tx_ring will call
> dev_kfree_skb_any(NULL).
> This Patch calls netif_stop_queue before calling stop_gfar.
> 
> Signed-off-by: Markus Brunner <super.firetwister@gmail.com>

Applied, thanks.
