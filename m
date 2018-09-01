Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2620:137:e000::1:9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 422QSs0WF4zF39b
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Sep 2018 15:55:55 +1000 (AEST)
Date: Fri, 31 Aug 2018 22:55:49 -0700 (PDT)
Message-Id: <20180831.225549.934645882889326596.davem@davemloft.net>
To: david.gounaris@infinera.com
Cc: qiang.zhao@nxp.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 3/6] net/wan/fsl_ucc_hdlc: Adding ARPHRD_ETHER
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180829131328.27901-4-david.gounaris@infinera.com>
References: <20180828110921.2542-2-david.gounaris@infinera.com>
 <20180829131328.27901-1-david.gounaris@infinera.com>
 <20180829131328.27901-4-david.gounaris@infinera.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: David Gounaris <david.gounaris@infinera.com>
Date: Wed, 29 Aug 2018 15:13:25 +0200

> @@ -513,6 +517,8 @@ static int hdlc_rx_done(struct ucc_hdlc_private *priv, int rx_work_limit)
>  			break;
>  
>  		case ARPHRD_PPP:
> +		case ARPHRD_ETHER:
> +			

Please don't add such an extraneous empty line.

Thanks.
