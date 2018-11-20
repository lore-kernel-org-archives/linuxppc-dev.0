Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EEBC32788
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 15:15:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D22020851
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 15:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D22020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zq4S0fj4zF3GN
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 02:14:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=bootlin.com
 (client-ip=62.4.15.54; helo=mail.bootlin.com;
 envelope-from=alexandre.belloni@bootlin.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=bootlin.com
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 42zq2K5PdgzF3PS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 02:12:34 +1100 (AEDT)
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 68EFB2074F; Tue, 20 Nov 2018 16:12:32 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
 by mail.bootlin.com (Postfix) with ESMTPSA id 3F3B8206D8;
 Tue, 20 Nov 2018 16:12:32 +0100 (CET)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/fsl-rio: fix spelling mistake "reserverd" ->
 "reserved"
Date: Tue, 20 Nov 2018 16:12:30 +0100
Message-Id: <20181120151230.32159-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fix a spelling mistake in a register description.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/powerpc/sysdev/fsl_rio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.h b/arch/powerpc/sysdev/fsl_rio.h
index 12dd18fd4795..6c13d9a7b7b2 100644
--- a/arch/powerpc/sysdev/fsl_rio.h
+++ b/arch/powerpc/sysdev/fsl_rio.h
@@ -41,7 +41,7 @@
 #define DOORBELL_ROWAR_PCI	0x02000000 /* PCI window */
 #define DOORBELL_ROWAR_NREAD	0x00040000 /* NREAD */
 #define DOORBELL_ROWAR_MAINTRD	0x00070000  /* maintenance read */
-#define DOORBELL_ROWAR_RES	0x00002000 /* wrtpy: reserverd */
+#define DOORBELL_ROWAR_RES	0x00002000 /* wrtpy: reserved */
 #define DOORBELL_ROWAR_MAINTWD	0x00007000
 #define DOORBELL_ROWAR_SIZE	0x0000000b /* window size is 4k */
 
-- 
2.19.1

