Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71506C0044C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 02:52:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F342D2082D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 02:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F342D2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kbcL0ysNzF14t
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 13:52:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.21; helo=inva021.nxp.com; envelope-from=peng.ma@nxp.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kbL8554qzF14d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 13:40:32 +1100 (AEDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 42BAC20020F;
 Tue, 30 Oct 2018 03:40:29 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CDB3F20014E;
 Tue, 30 Oct 2018 03:40:22 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C80D440327;
 Tue, 30 Oct 2018 10:40:10 +0800 (SGT)
From: Peng Ma <peng.ma@nxp.com>
To: vkoul@kernel.org
Subject: [v11 7/7] dt-bindings: fsl-qdma: Add NXP Layerscpae qDMA controller
 bindings
Date: Tue, 30 Oct 2018 10:36:04 +0800
Message-Id: <20181030023604.34027-7-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20181030023604.34027-1-peng.ma@nxp.com>
References: <20181030023604.34027-1-peng.ma@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Wen He <wen.he_1@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, Peng Ma <peng.ma@nxp.com>,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, zw@zh-kernel.org,
 robh+dt@kernel.org, dmaengine@vger.kernel.org, dan.j.williams@intel.com,
 shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Document the devicetree bindings for NXP Layerscape qDMA controller
which could be found on NXP QorIQ Layerscape SoCs.

Signed-off-by: Wen He <wen.he_1@nxp.com>
Signed-off-by: Peng Ma <peng.ma@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
change in v11:
	- no

 Documentation/devicetree/bindings/dma/fsl-qdma.txt |   57 ++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-qdma.txt

diff --git a/Documentation/devicetree/bindings/dma/fsl-qdma.txt b/Documentation/devicetree/bindings/dma/fsl-qdma.txt
new file mode 100644
index 0000000..6a0ff90
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl-qdma.txt
@@ -0,0 +1,57 @@
+NXP Layerscape SoC qDMA Controller
+==================================
+
+This device follows the generic DMA bindings defined in dma/dma.txt.
+
+Required properties:
+
+- compatible:		Must be one of
+			 "fsl,ls1021a-qdma": for LS1021A Board
+			 "fsl,ls1043a-qdma": for ls1043A Board
+			 "fsl,ls1046a-qdma": for ls1046A Board
+- reg:			Should contain the register's base address and length.
+- interrupts:		Should contain a reference to the interrupt used by this
+			device.
+- interrupt-names:	Should contain interrupt names:
+			 "qdma-queue0": the block0 interrupt
+			 "qdma-queue1": the block1 interrupt
+			 "qdma-queue2": the block2 interrupt
+			 "qdma-queue3": the block3 interrupt
+			 "qdma-error":  the error interrupt
+- fsl,dma-queues:	Should contain number of queues supported.
+- dma-channels:	Number of DMA channels supported
+- block-number:	the virtual block number
+- block-offset:	the offset of different virtual block
+- status-sizes:	status queue size of per virtual block
+- queue-sizes:		command queue size of per virtual block, the size number
+			based on queues
+
+Optional properties:
+
+- dma-channels:		Number of DMA channels supported by the controller.
+- big-endian:		If present registers and hardware scatter/gather descriptors
+			of the qDMA are implemented in big endian mode, otherwise in little
+			mode.
+
+Examples:
+
+	qdma: dma-controller@8390000 {
+			compatible = "fsl,ls1021a-qdma";
+			reg = <0x0 0x8388000 0x0 0x1000>, /* Controller regs */
+			      <0x0 0x8389000 0x0 0x1000>, /* Status regs */
+			      <0x0 0x838a000 0x0 0x2000>; /* Block regs */
+			interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "qdma-error",
+				"qdma-queue0", "qdma-queue1";
+			dma-channels = <8>;
+			block-number = <2>;
+			block-offset = <0x1000>;
+			fsl,dma-queues = <2>;
+			status-sizes = <64>;
+			queue-sizes = <64 64>;
+			big-endian;
+		};
+
+DMA clients must use the format described in dma/dma.txt file.
-- 
1.7.1

