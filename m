Return-Path: <yinbo.zhu@nxp.com>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03on0113.outbound.protection.outlook.com [104.47.40.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hwlC2QVszF2Cp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 13:37:26 +1000 (AEST)
From: Yinbo Zhu <yinbo.zhu@nxp.com>
To: <yinbo.zhu@nxp.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, "Catalin Marinas )" <catalin.marinas@arm.com>, "Will
 Deacon )" <will.deacon@arm.com>, "Lorenzo Pieralisi )"
 <lorenzo.pieralisi@arm.com>, Li Yang <leoyang.li@nxp.com>
CC: <xiaobo.xie@nxp.com>, <ran.wang_1@nxp.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Shawn Guo
 <shawnguo@kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>, Hou Zhiqiang
 <Zhiqiang.Hou@nxp.com>, Changming Huang <jerry.huang@nxp.com>, Minghuan Lian
 <Minghuan.Lian@nxp.com>, Zhao Qiang <qiang.zhao@nxp.com>, Fabio Estevam
 <fabio.estevam@nxp.com>, "jiaheng . fan" <jiaheng.fan@nxp.com>, Po Liu
 <po.liu@nxp.com>, Nipun Gupta <nipun.gupta@nxp.com>,
 =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>, Priyanka Jain
 <priyanka.jain@nxp.com>, Sumit Garg <sumit.garg@nxp.com>, costi
 <constantin.tudor@freescale.com>, Bogdan Purcareata
 <bogdan.purcareata@nxp.com>, Meng Yi <meng.yi@nxp.com>, Wang Dongsheng
 <dongsheng.wang@nxp.com>, "open list:CLOCKSOURCE, CLOCKEVENT DRIVERS"
 <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, "open list:FREESCALE SOC DRIVERS"
 <linuxppc-dev@lists.ozlabs.org>, Tang Yuantian <Yuantian.Tang@nxp.com>,
 <ying.zhang22455@nxp.com>
Subject: [PATCH 6/9] soc: fsl: fix the compilation issue
Date: Fri, 11 May 2018 11:35:27 +0800
Message-ID: <20180511033530.7931-6-yinbo.zhu@nxp.com>
In-Reply-To: <20180511033530.7931-1-yinbo.zhu@nxp.com>
References: <20180511033530.7931-1-yinbo.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Zhang Ying-22455 <ying.zhang22455@nxp.com>

Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
---
 drivers/soc/fsl/layerscape/ftm_alarm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/soc/fsl/layerscape/ftm_alarm.c b/drivers/soc/fsl/layerscape/ftm_alarm.c
index 811dcfa..c22ef49 100644
--- a/drivers/soc/fsl/layerscape/ftm_alarm.c
+++ b/drivers/soc/fsl/layerscape/ftm_alarm.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/libata.h>
+#include <linux/module.h>
 
 #define FTM_SC			0x00
 #define FTM_SC_CLK_SHIFT	3
-- 
1.7.1
