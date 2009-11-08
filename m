Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 63272B7D43
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Nov 2009 19:43:32 +1100 (EST)
Date: Sun, 08 Nov 2009 00:43:51 -0800 (PST)
Message-Id: <20091108.004351.236432748.davem@davemloft.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 2/3] fsl_pq_mdio: Fix compiler/sparse warnings (part 2)
From: David Miller <davem@davemloft.net>
In-Reply-To: <20091104225257.GB29537@oksana.dev.rtsoft.ru>
References: <20091104225257.GB29537@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Sandeep.Kumar@freescale.com,
	afleming@freescale.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Thu, 5 Nov 2009 01:52:57 +0300

> This patch fixes following warnings:
> 
> fsl_pq_mdio.c:112:38: warning: cast adds address space to expression (<asn:2>)
> fsl_pq_mdio.c:124:38: warning: cast adds address space to expression (<asn:2>)
> fsl_pq_mdio.c:133:38: warning: cast adds address space to expression (<asn:2>)
> fsl_pq_mdio.c:414:11: warning: cast adds address space to expression (<asn:2>)
> 
> Instead of adding __force all over the place, introduce convenient
> fsl_pq_mdio_get_regs() call that does the ugly casting just once.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Applied.
