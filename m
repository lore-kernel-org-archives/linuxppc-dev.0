Return-Path: <xiaowei.bao@nxp.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0055.outbound.protection.outlook.com [104.47.36.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLn501tF3zDqZ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 19:49:23 +1100 (AEDT)
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
Subject: [PATCH 3/3] ARMv8: pcie: make the DWC EP driver support for layerscape
Date: Tue, 24 Oct 2017 16:30:45 +0800
Message-ID: <20171024083045.31135-4-xiaowei.bao@nxp.com>
In-Reply-To: <20171024083045.31135-1-xiaowei.bao@nxp.com>
References: <20171024083045.31135-1-xiaowei.bao@nxp.com>
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

Layerscape pcie controllers support RC or EP mode, Add the EP mode
support in Kconfig, the driver will support both RC and EP mode, and
the driver is able to judge the pcie controllers work on RC or EP mode.

Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>
---
 drivers/pci/dwc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index 22ec82fcdea2..b5f507795779 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -108,6 +108,7 @@ config PCI_LAYERSCAPE
 	depends on PCI_MSI_IRQ_DOMAIN
 	select MFD_SYSCON
 	select PCIE_DW_HOST
+	select PCIE_DW_EP
 	help
 	  Say Y here if you want PCIe controller support on Layerscape SoCs.
 
-- 
2.14.1
