Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 21D87B6FDC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 09:12:43 +1100 (EST)
Date: Tue, 06 Mar 2012 17:08:28 -0500 (EST)
Message-Id: <20120306.170828.2286313308907964046.davem@davemloft.net>
To: dhdang@apm.com
Subject: Re: [PATCH v3 2/2] powerpc/44x: Add more changes for APM821XX EMAC
 driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <1330945102-15802-1-git-send-email-dhdang@apm.com>
References: <1330920224-3006-1-git-send-email-dhdang@apm.com>
 <1330945102-15802-1-git-send-email-dhdang@apm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, netdev@vger.kernel.org,
 sr@denx.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Duc Dang <dhdang@apm.com>
Date: Mon,  5 Mar 2012 17:58:22 +0700

>  This patch includes:
> 
>   Configure EMAC PHY clock source (clock from PHY or internal clock).
> 
>   Do not advertise PHY half duplex capability as APM821XX EMAC does not support half duplex mode.
> 
>   Add changes to support configuring jumbo frame for APM821XX EMAC.
> 
> Signed-off-by: Duc Dang <dhdang@apm.com>

Applied with coding style fixes.
