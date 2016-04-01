Return-Path: <sboyd@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qc9lB2xmKzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Apr 2016 06:03:33 +1100 (AEDT)
Subject: Re: [v7, 4/5] powerpc/fsl: move mpc85xx.h to include/linux/fsl
To: Yangbo Lu <yangbo.lu@nxp.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-clk@vger.kernel.org,
 linux-i2c@vger.kernel.org, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-mmc@vger.kernel.org
References: <1459480051-3701-1-git-send-email-yangbo.lu@nxp.com>
 <1459480051-3701-5-git-send-email-yangbo.lu@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>, scott.wood@nxp.com,
 Russell King <linux@arm.linux.org.uk>, Jochen Friedrich <jochen@scram.de>,
 Joerg Roedel <joro@8bytes.org>, Claudiu Manoil
 <claudiu.manoil@freescale.com>, ulf.hansson@linaro.org,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 Zhao Qiang <qiang.zhao@freescale.com>, Kumar Gala <galak@codeaurora.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, leoyang.li@nxp.com,
 xiaobo.xie@nxp.com
From: Stephen Boyd <sboyd@codeaurora.org>
Message-ID: <56FEC601.7020800@codeaurora.org>
Date: Fri, 1 Apr 2016 12:03:29 -0700
MIME-Version: 1.0
In-Reply-To: <1459480051-3701-5-git-send-email-yangbo.lu@nxp.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/31/2016 08:07 PM, Yangbo Lu wrote:
>  drivers/clk/clk-qoriq.c                                       | 3 +--
>

For clk part:

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
