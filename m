Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 9ABCEB6F17
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Apr 2011 11:56:20 +1000 (EST)
Date: Sun, 10 Apr 2011 18:55:42 -0700 (PDT)
Message-Id: <20110410.185542.115938862.davem@davemloft.net>
To: mirq-linux@rere.qmqm.pl
Subject: Re: [PATCH] net: Remove invalid offloads
From: David Miller <davem@davemloft.net>
In-Reply-To: <20110408123846.D947E13909@rere.qmqm.pl>
References: <20110408123846.D947E13909@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=euc-kr
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	vbordug@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Micha©© Miros©©aw <mirq-linux@rere.qmqm.pl>
Date: Fri,  8 Apr 2011 14:38:46 +0200 (CEST)

> Remove offload changing ethtool ops which drivers don't really support:
> 
>  - fs_enet
>  - ucc_geth
> 
> Signed-off-by: Micha©© Miros©©aw <mirq-linux@rere.qmqm.pl>

Applied.
