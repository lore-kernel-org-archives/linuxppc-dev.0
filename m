Return-Path: <jeff@garzik.org>
Message-ID: <45C33DED.8010200@garzik.org>
Date: Fri, 02 Feb 2007 08:34:37 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Jens Osterkamp <jens@de.ibm.com>
Subject: Re: [PATCH] spidernet : fix memory leak in spider_net_stop
References: <200702011207.47421.jens@de.ibm.com>
In-Reply-To: <200702011207.47421.jens@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
	James K Lewis <jim@jklewis.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jens Osterkamp wrote:
> We forget to call spider_net_free_rx_chain_contents which does the
> actual dev_kfree_skb. New skbs are allocated from skbuff_head_cache
> on each "ifconfig up" letting the cache grow infinitely.
> 
> This patch fixes it.
> 
> Signed-off-by: Jens Osterkamp <jens@de.ibm.com>

applied
