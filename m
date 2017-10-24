Return-Path: <xiaowei.bao@nxp.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0065.outbound.protection.outlook.com [104.47.36.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLn4W2ZyTzDqZ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 19:48:55 +1100 (AEDT)
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
Subject: [PATCH 0/3] dts: Add the property of IB and OB 
Date: Tue, 24 Oct 2017 16:30:42 +0800
Message-ID: <20171024083045.31135-1-xiaowei.bao@nxp.com>
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

Depend on http://patchwork.ozlabs.org/patch/815382/

Bao Xiaowei (3):
  ARMv8: dts: ls1046a: add the property of IB and OB
  ARMv8: layerscape: add the pcie ep function support
  ARMv8: pcie: make the DWC EP driver support for layerscape

 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   6 ++
 drivers/pci/dwc/Kconfig                        |   1 +
 drivers/pci/dwc/pci-layerscape.c               | 137 +++++++++++++++++++++++--
 3 files changed, 138 insertions(+), 6 deletions(-)

-- 
2.14.1
