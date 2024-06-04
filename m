Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B065C25B78
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Jun 2024 18:05:30 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bVboMyeb;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vtz605Jqsz3d8Y
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Jun 2024 04:05:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bVboMyeb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=mwalle@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vtt9H3YJwz3cRB
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2024 00:22:59 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 89A8B61299;
	Tue,  4 Jun 2024 14:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4A1C2BBFC;
	Tue,  4 Jun 2024 14:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717510976;
	bh=FdTguazvLu4tk48L/f04l3yuEnV7aGDYYNx41+us/Qs=;
	h=From:To:Cc:Subject:Date:From;
	b=bVboMyebn/DjvMsctpWLi974VTBEL/aKCCC5I0DgmNuozf1Md35JJCLQktC6Wer3z
	 PByFBdgAa9WtP6+oRMrvboGhnMVIHK5QgsFVEvQERePUsNaLlNNP68HvC6RshNXl/c
	 2coTsbpXsx7hvdRoBOH/jmWg90CqxoypisXTpmr11Ekv4IYKrjKnH/OLWBLBQA+p6F
	 o+V/1qhPlFc+DoXqf2Fh4RdrP54TEvIDz3T2uwng5eEFXmeojosH/V6r2u/n6D264L
	 bTdfmg50w9CbICCssMpgU/wL/CGRUDo8vxZHLWAXahNxe52If3hSJDfx2J+aQSSaP9
	 T6d2LDfn4fIlw==
From: Michael Walle <mwalle@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 1/2] dt-bindings: Drop Li Yang as maintainer for all bindings
Date: Tue,  4 Jun 2024 16:22:48 +0200
Message-Id: <20240604142249.1957762-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Jun 2024 03:59:10 +1000
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
Cc: devicetree@vger.kernel.org, Michael Walle <mwalle@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Remove Li Yang from all device tree bindings because mails to this
address are bouncing.

Commit fbdd90334a62 ("MAINTAINERS: Drop Li Yang as their email address
stopped working") already removed the entry from the MAINTAINERS but
didn't address all the in-file entries of the device tree bindings.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml                   | 1 -
 .../devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml  | 1 -
 .../devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml         | 1 -
 .../devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml         | 1 -
 4 files changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index f731fb5b5e2a..8a1f8e387a61 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -8,7 +8,6 @@ title: Freescale i.MX Platforms
 
 maintainers:
   - Shawn Guo <shawnguo@kernel.org>
-  - Li Yang <leoyang.li@nxp.com>
 
 properties:
   $nodename:
diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
index 887e565b9573..199b34fdbefc 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
@@ -8,7 +8,6 @@ title: Freescale Layerscape External Interrupt Controller
 
 maintainers:
   - Shawn Guo <shawnguo@kernel.org>
-  - Li Yang <leoyang.li@nxp.com>
 
 description: |
   Some Layerscape SOCs (LS1021A, LS1043A, LS1046A LS1088A, LS208xA,
diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
index ce1a6505eb51..3fb0534ea597 100644
--- a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
+++ b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
@@ -8,7 +8,6 @@ title: Freescale Layerscape Device Configuration Unit
 
 maintainers:
   - Shawn Guo <shawnguo@kernel.org>
-  - Li Yang <leoyang.li@nxp.com>
 
 description: |
   DCFG is the device configuration unit, that provides general purpose
diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml
index a6a511b00a12..2a456c8af992 100644
--- a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml
+++ b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml
@@ -8,7 +8,6 @@ title: Freescale Layerscape Supplemental Configuration Unit
 
 maintainers:
   - Shawn Guo <shawnguo@kernel.org>
-  - Li Yang <leoyang.li@nxp.com>
 
 description: |
   SCFG is the supplemental configuration unit, that provides SoC specific
-- 
2.39.2

