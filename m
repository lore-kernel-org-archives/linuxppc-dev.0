Return-Path: <SRS0=4kvs=MX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7958C32788
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 11:23:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 228E120835
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 11:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228E120835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42W7qh5QBGzDqnG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 22:22:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.13; helo=inva020.nxp.com; envelope-from=peng.ma@nxp.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42W5xG5bDfzF2Dx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 20:57:38 +1100 (AEDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6BB941A019A;
 Thu, 11 Oct 2018 11:50:53 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9D8B41A0014;
 Thu, 11 Oct 2018 11:50:47 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 483C4402D8;
 Thu, 11 Oct 2018 17:50:40 +0800 (SGT)
From: Peng Ma <peng.ma@nxp.com>
To: vkoul@kernel.org,
	leoyang.li@nxp.com
Subject: [PATCH 7/7] dt-bindings: fsl-qdma: Add NXP Layerscpae qDMA controller
 bindings
Date: Thu, 11 Oct 2018 17:46:55 +0800
Message-Id: <20181011094655.45707-7-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20181011094655.45707-1-peng.ma@nxp.com>
References: <20181011094655.45707-1-peng.ma@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Thu, 11 Oct 2018 22:04:00 +1100
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Peng Ma <peng.ma@nxp.com>,
 linux-kernel@vger.kernel.org, zw@zh-kernel.org, robh+dt@kernel.org,
 dmaengine@vger.kernel.org, dan.j.williams@intel.com, shawnguo@kernel.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Document the devicetree bindings for NXP Layerscape qDMA controller
which could be found on NXP QorIQ Layerscape SoCs.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
 Documentation/devicetree/bindings/dma/fsl-qdma.txt |   53 ++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-qdma.txt

diff --git a/Documentation/devicetree/bindings/dma/fsl-qdma.txt b/Documentation/devicetree/bindings/dma/fsl-qdma.txt
new file mode 100644
index 0000000..7e2160b
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl-qdma.txt
@@ -0,0 +1,53 @@
+NXP Layerscape SoC qDMA Controller
+==================================
+
+The qDMA supports channel virtualization by allowing DMA jobs to be enqueued into
+different command queues. Core can initiate a DMA transaction by preparing a command
+descriptor for each DMA job and enqueuing this job to a command queue.
+
+Required properties:
+- compatible:	Must be one of
+	"fsl,ls1021a-qdma": for LS1021A Board
+	"fsl,ls1043a-qdma": for ls1043A Board
+	"fsl,ls1046a-qdma": for ls1046A Board
+- reg : Specifies base physical address(s) and size of the qDMA registers.
+	The 1st region is qDMA control register's address and size.
+	The 2nd region is status queue control register's address and size.
+	The 3rd region is virtual block control register's address and size.
+- interrupts : A list of interrupt-specifiers, one for each entry in
+	interrupt-names.
+- interrupt-names : Should contain:
+	"qdma-queue0" - the block0 interrupt
+	"qdma-queue1" - the block1 interrupt
+	"qdma-queue2" - the block2 interrupt
+	"qdma-queue3" - the block3 interrupt
+	"qdma-error"  - the error interrupt
+- channels : Number of DMA channels supported
+- block-number : the virtual block number
+- block-offset : the offset of different virtual block
+- queues : the number of command queue per virtual block
+- status-sizes : status queue size of per virtual block
+- queue-sizes : command queue size of per virtual block, the size number based on queues
+- big-endian: If present registers and hardware scatter/gather descriptors
+	of the qDMA are implemented in big endian mode, otherwise in little
+	mode.
+
+Examples:
+	qdma: qdma@8390000 {
+				compatible = "fsl,ls1021a-qdma";
+				reg = <0x0 0x8388000 0x0 0x1000>, /* Controller regs */
+				      <0x0 0x8389000 0x0 0x1000>, /* Status regs */
+				      <0x0 0x838a000 0x0 0x2000>; /* Block regs */
+				interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "qdma-error",
+					"qdma-queue0", "qdma-queue1";
+				channels = <8>;
+				block-number = <2>;
+				block-offset = <0x1000>;
+				queues = <2>;
+				status-sizes = <64>;
+				queue-sizes = <64 64>;
+				big-endian;
+			};
-- 
1.7.1

