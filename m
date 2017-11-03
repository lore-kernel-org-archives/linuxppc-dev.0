Return-Path: <xiaowei.bao@nxp.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0078.outbound.protection.outlook.com [104.47.37.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySxy33vv0zDrFG
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Nov 2017 20:49:47 +1100 (AEDT)
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
Subject: [PATCH 1/3] ARMv8: dts: ls1046a: add the property of IB and OB
Date: Fri, 3 Nov 2017 17:31:13 +0800
Message-ID: <20171103093115.14915-2-xiaowei.bao@nxp.com>
In-Reply-To: <20171103093115.14915-1-xiaowei.bao@nxp.com>
References: <20171103093115.14915-1-xiaowei.bao@nxp.com>
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

Add the property of inbind and outbind windows number for ep
driver.

add the inband or outband window entry for pcie controller
ep driver used in dts.

Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>
Acked-by: Minghuan Lian <minghuan.Lian@nxp.com>
---
 v2:
 - no change

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
