Return-Path: <scott.wood@nxp.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0077.outbound.protection.outlook.com [157.56.112.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qRgsz0RsmzDq70
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Mar 2016 10:09:58 +1100 (AEDT)
From: Scott Wood <scott.wood@nxp.com>
To: Yangbo Lu <yangbo.lu@nxp.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-i2c@vger.kernel.org"
 <linux-i2c@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-mmc@vger.kernel.org"
 <linux-mmc@vger.kernel.org>
CC: Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>,
 Jochen Friedrich <jochen@scram.de>, Joerg Roedel <joro@8bytes.org>, "Claudiu
 Manoil" <claudiu.manoil@freescale.com>, "ulf.hansson@linaro.org"
 <ulf.hansson@linaro.org>, Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 "Zhao Qiang" <qiang.zhao@freescale.com>, Kumar Gala <galak@codeaurora.org>,
 "Santosh Shilimkar" <ssantosh@kernel.org>, Yang-Leo Li <leoyang.li@nxp.com>,
 Xiaobo Xie <xiaobo.xie@nxp.com>
Subject: Re: [v6, 2/5] soc: fsl: add GUTS driver for QorIQ platforms
Date: Fri, 18 Mar 2016 22:54:46 +0000
Message-ID: <DB5PR0401MB1928302BB0DDE8D9B47E4361918C0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1457518131-11339-1-git-send-email-yangbo.lu@nxp.com>
 <1457518131-11339-3-git-send-email-yangbo.lu@nxp.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/09/2016 04:18 AM, Yangbo Lu wrote:=0A=
> +#ifdef CONFIG_FSL_GUTS=0A=
> +u32 fsl_guts_get_svr(void);=0A=
> +int fsl_guts_init(void);=0A=
> +#endif=0A=
=0A=
Don't ifdef prototypes (when not providing a stub alternative).=0A=
=0A=
-Scott=0A=
=0A=
