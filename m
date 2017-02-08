Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vJTvt2jDNzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2017 05:17:45 +1100 (AEDT)
Date: Wed, 08 Feb 2017 13:17:32 -0500 (EST)
Message-Id: <20170208.131732.767256319781283002.davem@davemloft.net>
To: christophe.leroy@c-s.fr
Cc: leoli@freescale.com, qiang.zhao@nxp.com, oss@buserror.net,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] get rid of immrbar_virt_to_phys()
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1486456900.git.christophe.leroy@c-s.fr>
References: <cover.1486456900.git.christophe.leroy@c-s.fr>
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

From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Tue,  7 Feb 2017 10:05:07 +0100 (CET)

> ucc_geth ethernet driver is the only driver using immrbar_virt_to_phys() and it uses it incorrectly.
> 
> This patch fixes ucc_geth driver then removes immrbar_virt_to_phys()

Feel free to merge this via whatever tree handles that SOC fsl driver.

Acked-by: David S. Miller <davem@davemloft.net>
