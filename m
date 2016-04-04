Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qdgDx3pDczDqL0
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Apr 2016 15:16:01 +1000 (AEST)
Date: Mon, 4 Apr 2016 00:15:52 -0500
From: Rob Herring <robh@kernel.org>
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-mmc@vger.kernel.org, scott.wood@nxp.com,
 Russell King <linux@arm.linux.org.uk>,
 Jochen Friedrich <jochen@scram.de>, Joerg Roedel <joro@8bytes.org>,
 Claudiu Manoil <claudiu.manoil@freescale.com>, ulf.hansson@linaro.org,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 Zhao Qiang <qiang.zhao@freescale.com>, Kumar Gala <galak@codeaurora.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, leoyang.li@nxp.com,
 xiaobo.xie@nxp.com
Subject: Re: [v7, 3/5] dt: move guts devicetree doc out of powerpc directory
Message-ID: <20160404051552.GG17806@rob-hp-laptop>
References: <1459480051-3701-1-git-send-email-yangbo.lu@nxp.com>
 <1459480051-3701-4-git-send-email-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459480051-3701-4-git-send-email-yangbo.lu@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 01, 2016 at 11:07:29AM +0800, Yangbo Lu wrote:
> Move guts devicetree doc to Documentation/devicetree/bindings/soc/fsl/
> since it's used by not only PowerPC but also ARM. And add a specification
> for 'little-endian' property.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v2:
> 	- None
> Changes for v3:
> 	- None
> Changes for v4:
> 	- Added this patch
> Changes for v5:
> 	- Modified the description for little-endian property
> Changes for v6:
> 	- None
> Changes for v7:
> 	- None
> ---
>  Documentation/devicetree/bindings/{powerpc => soc}/fsl/guts.txt | 3 +++
>  1 file changed, 3 insertions(+)
>  rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/guts.txt (91%)

Acked-by: Rob Herring <robh@kernel.org>
