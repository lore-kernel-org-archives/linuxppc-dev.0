From: linas@austin.ibm.com
Date: Mon, 19 May 2003 10:21:16 -0500
To: Mark Rakes <mrakes@vivato.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: e1000 patch for linuxppc_2_4_devel
Message-ID: <20030519102116.A33266@forte.austin.ibm.com>
References: <3048EFC8-87FB-11D7-B0B0-000393DB7C12@vivato.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3048EFC8-87FB-11D7-B0B0-000393DB7C12@vivato.net>; from mrakes@vivato.net on Fri, May 16, 2003 at 05:04:54PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,


On Fri, May 16, 2003 at 05:04:54PM -0700, Mark Rakes wrote:
>
> this patch fixes e1000 vlan hardware acceleration on ppc.
>
> vlan tags weren't swapped.

Maybe I hav e junky fonts in my mailreader, but, no matter how
hard I squint, the only thing I can see in this patch is a
change in indentation.  Whazzup?

--linas

> thanks!
> -Mark Rakes
>
>
> diff -Nru a/drivers/net/e1000/e1000_main.c
> b/drivers/net/e1000/e1000_main.c
> --- a/drivers/net/e1000/e1000_main.c	Fri May 16 17:00:24 2003
> +++ b/drivers/net/e1000/e1000_main.c	Fri May 16 17:00:24 2003
> @@ -2062,7 +2062,8 @@
>   		skb->protocol = eth_type_trans(skb, netdev);
>   		if(adapter->vlgrp && (rx_desc->status & E1000_RXD_STAT_VP)) {
>   			vlan_hwaccel_rx(skb, adapter->vlgrp,
> -				le16_to_cpu(rx_desc->special & E1000_RXD_SPC_VLAN_MASK));
> +				le16_to_cpu(rx_desc->special &
> +					    E1000_RXD_SPC_VLAN_MASK));
>   		} else {
>   			netif_rx(skb);
>   		}
>
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
