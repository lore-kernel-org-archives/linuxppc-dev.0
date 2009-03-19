Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 230F1DDED1
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 02:57:20 +1100 (EST)
Message-Id: <5D5BAD65-6ED3-4B07-9106-7DD2A715B6BA@freescale.com>
From: Andy Fleming <afleming@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090319155232.GA5419@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH -next] fsl_pq_mdio: Revive Gianfar TBI PHY support
Date: Thu, 19 Mar 2009 10:56:59 -0500
References: <20090319155232.GA5419@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 19, 2009, at 10:52 AM, Anton Vorontsov wrote:

> commit 1577ecef766650a57fceb171acee2b13cbfaf1d3 ("netdev: Merge UCC
> and gianfar MDIO bus drivers") broke the TSEC TBI PHY support: the
> driver now refuses to probe TBI MDIO buses as it doesn't know about
> "fsl,gianfar-tbi" compatible entry, and thus _probe() fails with
> -ENODEV status.
>
> Fix this by adding "fsl,gianfar-tbi" to the list of known Gianfar
> MDIO buses.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-by: Andy Fleming <afleming@freescale.com>
