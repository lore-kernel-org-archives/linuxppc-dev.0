Return-Path: <jeff@garzik.org>
Message-ID: <465602E4.1050807@garzik.org>
Date: Thu, 24 May 2007 17:25:56 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 1/10] spidernet: skb used after netif_receive_skb
References: <20070522230942.GT5921@austin.ibm.com>
In-Reply-To: <20070522230942.GT5921@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
	Florin Malita <fmalita@gmail.com>, cbe-oss-dev@ozlabs.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:
> From: Florin Malita <fmalita@gmail.com>
> 
> The stats update code in spider_net_pass_skb_up() is touching the skb 
> after it's been passed up to the stack. To avoid that, just update the 
> stats first.
> 
> Signed-off-by: Florin Malita <fmalita@gmail.com>
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> ----
> 
>  drivers/net/spider_net.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

applied to #upstream-fixes
