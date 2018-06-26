Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2620:137:e000::1:9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41FRd24THCzF1GF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 23:25:57 +1000 (AEST)
Date: Tue, 26 Jun 2018 22:18:19 +0900 (KST)
Message-Id: <20180626.221819.2229197444662289895.davem@davemloft.net>
To: yangbo.lu@nxp.com
Cc: netdev@vger.kernel.org, madalin.bucur@nxp.com,
 richardcochran@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v4, 00/10] Support DPAA PTP clock and timestamping
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180625123716.28993-1-yangbo.lu@nxp.com>
References: <20180625123716.28993-1-yangbo.lu@nxp.com>
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

From: Yangbo Lu <yangbo.lu@nxp.com>
Date: Mon, 25 Jun 2018 20:37:06 +0800

> This patchset is to support DPAA FMAN PTP clock and HW timestamping.
> It had been verified on both ARM platform and PPC platform.
> - The patch #1 to patch #5 are to support DPAA FMAN 1588 timer in
>   ptp_qoriq driver.
> - The patch #6 to patch #10 are to add HW timestamping support in
>   DPAA ethernet driver.

Series applied to net-next.
