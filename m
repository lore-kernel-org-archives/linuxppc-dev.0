Return-Path: <SRS0=Ic/D=XV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E5FC432C2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Sep 2019 02:56:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB2C9222BD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Sep 2019 02:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB2C9222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46f01M2VfxzDqZ3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Sep 2019 12:56:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.21; helo=inva021.nxp.com; envelope-from=biwen.li@nxp.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46dzwl0W4kzDqht
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2019 12:52:05 +1000 (AEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C0A502004E3;
 Thu, 26 Sep 2019 04:52:01 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2F2DC2001DC;
 Thu, 26 Sep 2019 04:51:57 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 41E45402DE;
 Thu, 26 Sep 2019 10:51:51 +0800 (SGT)
From: Biwen Li <biwen.li@nxp.com>
To: leoyang.li@nxp.com, shawnguo@kernel.org, robh+dt@kernel.org,
 mark.rutland@arm.com, ran.wang_1@nxp.com
Subject: [v4, 3/3] Documentation: dt: binding: fsl: Add 'fsl,
 ippdexpcr1-alt-addr' property
Date: Thu, 26 Sep 2019 10:41:18 +0800
Message-Id: <20190926024118.15931-3-biwen.li@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190926024118.15931-1-biwen.li@nxp.com>
References: <20190926024118.15931-1-biwen.li@nxp.com>
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
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Biwen Li <biwen.li@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The 'fsl,ippdexpcr1-alt-addr' property is used to handle an errata A-008646
on LS1021A

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
Change in v4:
	- rename property name
	  fsl,ippdexpcr-alt-addr -> fsl,ippdexpcr1-alt-addr

Change in v3:
	- rename property name
	  fsl,rcpm-scfg -> fsl,ippdexpcr-alt-addr

Change in v2:
	- update desc of the property 'fsl,rcpm-scfg'

 .../devicetree/bindings/soc/fsl/rcpm.txt      | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
index 5a33619d881d..751a7655b694 100644
--- a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
+++ b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
@@ -34,6 +34,13 @@ Chassis Version		Example Chips
 Optional properties:
  - little-endian : RCPM register block is Little Endian. Without it RCPM
    will be Big Endian (default case).
+ - fsl,ippdexpcr1-alt-addr : The property is related to a hardware issue
+   on SoC LS1021A and only needed on SoC LS1021A.
+   Must include 1 + 2 entries.
+   The first entry must be a link to the SCFG device node.
+   The non-first entry must be offset of registers of SCFG.
+   The second and third entry compose an alt offset address
+   for IPPDEXPCR1(SCFG_SPARECR8)
 
 Example:
 The RCPM node for T4240:
@@ -43,6 +50,20 @@ The RCPM node for T4240:
 		#fsl,rcpm-wakeup-cells = <2>;
 	};
 
+The RCPM node for LS1021A:
+	rcpm: rcpm@1ee2140 {
+		compatible = "fsl,ls1021a-rcpm", "fsl,qoriq-rcpm-2.1+";
+		reg = <0x0 0x1ee2140 0x0 0x8>;
+		#fsl,rcpm-wakeup-cells = <2>;
+
+		/*
+		 * The second and third entry compose an alt offset
+		 * address for IPPDEXPCR1(SCFG_SPARECR8)
+		 */
+		fsl,ippdexpcr1-alt-addr = <&scfg 0x0 0x51c>;
+	};
+
+
 * Freescale RCPM Wakeup Source Device Tree Bindings
 -------------------------------------------
 Required fsl,rcpm-wakeup property should be added to a device node if the device
-- 
2.17.1

