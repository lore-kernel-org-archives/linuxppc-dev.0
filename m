Return-Path: <xiaowei.bao@nxp.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0043.outbound.protection.outlook.com [104.47.42.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yY4jH6QnKzDrKG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Nov 2017 14:08:03 +1100 (AEDT)
From: Bao Xiaowei <xiaowei.bao@nxp.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
 <will.deacon@arm.com>, <bhelgaas@google.com>, <shawnguo@kernel.org>,
 <madalin.bucur@nxp.com>, <sumit.garg@nxp.com>, <yangbo.lu@nxp.com>,
 <hongtao.jia@nxp.com>, <Yuantian.Tang@nxp.com>, <leoyang.li@nxp.com>,
 <kishon@ti.com>, <jingoohan1@gmail.com>, <pbrobinson@gmail.com>,
 <songxiaowei@hisilicon.com>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <Zhiqiang.Hou@nxp.com>, <mingkai.hu@nxp.com>, <Minghuan.Lian@nxp.com>
CC: Bao Xiaowei <xiaowei.bao@nxp.com>
Subject: [PATCHv3 1/3] ARMv8: dts: ls1046a: add the property of IB and OB
Date: Fri, 10 Nov 2017 10:49:24 +0800
Message-ID: <20171110024926.39700-2-xiaowei.bao@nxp.com>
In-Reply-To: <20171110024926.39700-1-xiaowei.bao@nxp.com>
References: <20171110024926.39700-1-xiaowei.bao@nxp.com>
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

Add the property of inbound and outbound windows number for ep
driver.

Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>
Acked-by: Minghuan Lian <minghuan.Lian@nxp.com>
---
 v2:
 - no change
 v3:
 - modify the commit message

 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 06b5e12d04d8..f8332669663c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -674,6 +674,8 @@
 			device_type = "pci";
 			dma-coherent;
 			num-lanes = <4>;
+			num-ib-windows = <6>;
+			num-ob-windows = <6>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
@@ -699,6 +701,8 @@
 			device_type = "pci";
 			dma-coherent;
 			num-lanes = <2>;
+			num-ib-windows = <6>;
+			num-ob-windows = <6>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x48 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
@@ -724,6 +728,8 @@
 			device_type = "pci";
 			dma-coherent;
 			num-lanes = <2>;
+			num-ib-windows = <6>;
+			num-ob-windows = <6>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x50 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x50 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-- 
2.14.1
