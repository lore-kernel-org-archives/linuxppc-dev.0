Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 34C89DE144
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jun 2009 20:51:35 +1000 (EST)
Date: Wed, 03 Jun 2009 03:51:32 -0700 (PDT)
Message-Id: <20090603.035132.157926180.davem@davemloft.net>
To: Haiying.Wang@freescale.com
Subject: Re: [PATCH 4/4] MPC85xx: Add UCC6 and UCC8 nodes in SGMII mode for
	MPC8569MDS
From: David Miller <davem@davemloft.net>
In-Reply-To: <1243951456-4685-4-git-send-email-Haiying.Wang@freescale.com>
References: <1243951456-4685-2-git-send-email-Haiying.Wang@freescale.com>
	<1243951456-4685-3-git-send-email-Haiying.Wang@freescale.com>
	<1243951456-4685-4-git-send-email-Haiying.Wang@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Haiying Wang <Haiying.Wang@freescale.com>
Date: Tue,  2 Jun 2009 10:04:16 -0400

> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>

I couldn't apply this to net-next-2.6 because this DTS
file being patched doesn't exist there.

Perhaps the powerpc-next tree can suck it in...
