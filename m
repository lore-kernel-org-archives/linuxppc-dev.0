Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6DE17B6FFB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Dec 2011 05:01:50 +1100 (EST)
Date: Tue, 27 Dec 2011 12:59:40 -0500 (EST)
Message-Id: <20111227.125940.1585324652948148302.davem@davemloft.net>
To: X.Xie@freescale.com
Subject: Re: [PATCH] net/ucc_geth: some fix in current kernel
From: David Miller <davem@davemloft.net>
In-Reply-To: <1324979328-32081-1-git-send-email-X.Xie@freescale.com>
References: <y>
	<1324979328-32081-1-git-send-email-X.Xie@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Xie Xiaobo <X.Xie@freescale.com>
Date: Tue, 27 Dec 2011 17:48:48 +0800

> * Revert commit "ucc_geth: Fix hangs after switching from full to half duplex"
>   This commit impacted the driver in all link state change more than
>   duplex change.
> * Change some parameters.
>   Increased the BD ring length.
> 
> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
> Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>

Please, one major change per patch.
