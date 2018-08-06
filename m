Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2620:137:e000::1:9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41kJ4L4HG3zF3HM
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2018 10:12:17 +1000 (AEST)
Date: Sun, 05 Aug 2018 17:12:14 -0700 (PDT)
Message-Id: <20180805.171214.1083281848605802821.davem@davemloft.net>
To: yangbo.lu@nxp.com
Cc: netdev@vger.kernel.org, madalin.bucur@nxp.com,
 richardcochran@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v2, 3/3] ptp_qoriq: support automatic configuration for ptp timer
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180801100554.36634-3-yangbo.lu@nxp.com>
References: <20180801100554.36634-1-yangbo.lu@nxp.com>
 <20180801100554.36634-3-yangbo.lu@nxp.com>
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
Date: Wed,  1 Aug 2018 18:05:54 +0800

> This patch is to support automatic configuration for ptp timer.
> If required ptp dts properties are not provided, driver could
> try to calculate a set of default configurations to initialize
> the ptp timer. This makes the driver work for many boards which
> don't have the required ptp dts properties in current kernel.
> Also the users could set dts properties by themselves according
> to their requirement.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v2:
> 	- Dropped module_param.

Applied.
