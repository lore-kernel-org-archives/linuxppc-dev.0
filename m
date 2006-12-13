Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A884167CBE
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 08:34:52 +1100 (EST)
In-Reply-To: <45803CE3.4030600@freescale.com>
References: <1166013887.30422.54.camel@gentoo-jocke.transmode.se>
	<45803CE3.4030600@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CB1C9185-2489-4121-BCE4-58D028A56672@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: latest linux git doesn't compile ucc_geth_phy.c and ucc_geth.c
Date: Wed, 13 Dec 2006 15:34:36 -0600
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Jeff Garzik <jgarzik@pobox.com>, Netdev <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I just posted two patches to linuxppc-dev that fix these problems.   
> The message
> are titled:
>
> [PATCH] Update ucc_geth.c for new workqueue structure
> [PATCH] Fix phy_read/write redefinition errors in ucc_geth_phy.c
>
> I've tested these on an 8360EMDS, and Kumar has reviewed and signed  
> off on the
> code, so I think they're good.  Please let me know if they're not.

You should really copy Jeff Garzik and the netdev list on these patches.

- k
