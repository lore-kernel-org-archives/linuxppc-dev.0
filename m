Return-Path: <SRS0=ugyh=4N=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416E0C35DF9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Feb 2020 09:28:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D6C21556
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Feb 2020 09:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="FUlv3fZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D6C21556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (unknown [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48RYWg67FzzDqX6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Feb 2020 20:28:15 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48RYTM0W11zDqP1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2020 20:26:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=FUlv3fZ+; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 48RYTL45kYz9sRR; Tue, 25 Feb 2020 20:26:14 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 48RYTL3Sfpz9sRY; Tue, 25 Feb 2020 20:26:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1582622774;
 bh=jbfzr2M6A+jTeQwdntKxfIc4449d/AjVct4CSjQ++gk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FUlv3fZ+h+fhSNOQhYP5X71RuYaWZ5xsXbtOdIgY2bmMC+lMvJOGVLl93Ol+jhK6C
 YQQrrlQadrBwGMGhPS1c/Klm/78bTLXB9Z2e7giYRMa59/RxI3bB0UoK0j0U2gWPRJ
 TAGMxVvCyIr1kUujy/t3KkRMn1kX9NkLvJ++ITAEig+ZxbzgmpCNNUwiy3zqq04nk3
 Z4KEjIyggMNyaJzJL96EEVV9JJYbDlad4EI3pK6M9FDSZ4BwTPyN8knvuT40IzIL5z
 AIRdzv6tE0TYExWwihf/VyDPA8z5zQ+SBGYZ282NCd9zaRn4q8tjg4N8uITb5SnR3s
 IrVXiEOmKlmcg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 9/8] powerpc: Switch 8xx MAINTAINERS entry to Christophe
Date: Tue, 25 Feb 2020 20:25:34 +1100
Message-Id: <20200225092534.9587-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200224233146.23734-1-mpe@ellerman.id.au>
References: <20200224233146.23734-1-mpe@ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

It's over 10 years since the last commit from Vitaly, so I suspect
he's moved on to other things.

Christophe has been the primary contributor to 8xx in the last several
years, so anoint him as the maintainer.

Remove the dead penguingppc.org link.

Cc: Vitaly Bordug <vitb@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2e917116ef6a..0c1266afb52a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9658,8 +9658,7 @@ F:	arch/powerpc/platforms/85xx/
 F:	Documentation/devicetree/bindings/powerpc/fsl/
 
 LINUX FOR POWERPC EMBEDDED PPC8XX
-M:	Vitaly Bordug <vitb@kernel.crashing.org>
-W:	http://www.penguinppc.org/
+M:	Christophe Leroy <christophe.leroy@c-s.fr>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	arch/powerpc/platforms/8xx/
-- 
2.21.1

