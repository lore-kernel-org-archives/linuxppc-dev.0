Return-Path: <SRS0=vDV2=4M=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB478C35DEB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Feb 2020 23:47:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B4F22176D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Feb 2020 23:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="mnsO4rES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4F22176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48RJdh41tZzDqVk
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Feb 2020 10:47:36 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48RJHd6RV7zDq9p
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2020 10:31:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=mnsO4rES; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 48RJHd2BVzz9sRl; Tue, 25 Feb 2020 10:31:57 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 48RJHc4FLjz9sRN; Tue, 25 Feb 2020 10:31:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1582587116;
 bh=e+3S5c2g5Nka9xFqjuZ71WCKyjhhE+9WODC+LK78bD8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mnsO4rESThUzbouiP/Ygtw9wkEaYY7Tu9u2nvdJOILEdxeoPcT+rkxwa35wyNoYwY
 O/7R81Ij+KqHvu6v7/AHce+9syqNu+emDTOX0x2GRlo7Ip0uCISfYjhiGW/052iudU
 P3hsWzqJaDbsh942QuA9YmETjLxe9TxQwej5s1C6Ttd1TzMiEvRttnG8YqL3ViQxdu
 VZHth2JulDJ7DpLRxUWXawl5WzRJiiKKdjeqDoyzanP1V6DakM9TyMAAp9rcsX9DNA
 uraTO/ZHZ4XDphJCiLfV3yT9mux9zT5U7Cqdl4aBvV8JeXe4nt/dZ+bign5QVIAZak
 D5mka8sRLtKoQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 8/8] powerpc: Update 83xx/85xx MAINTAINERS entry
Date: Tue, 25 Feb 2020 10:31:46 +1100
Message-Id: <20200224233146.23734-8-mpe@ellerman.id.au>
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
Cc: Scott Wood <oss@buserror.net>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Scott said he was still maintaining this "sort of", so change the
status to Odd Fixes.

Kumar has long ago moved on to greener pastures.

Remove the dead penguinppc.org link.

Cc: Scott Wood <oss@buserror.net>
Cc: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index febffee28d00..2e917116ef6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9650,11 +9650,9 @@ F:	arch/powerpc/platforms/44x/
 
 LINUX FOR POWERPC EMBEDDED PPC83XX AND PPC85XX
 M:	Scott Wood <oss@buserror.net>
-M:	Kumar Gala <galak@kernel.crashing.org>
-W:	http://www.penguinppc.org/
 L:	linuxppc-dev@lists.ozlabs.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git
-S:	Maintained
+S:	Odd fixes
 F:	arch/powerpc/platforms/83xx/
 F:	arch/powerpc/platforms/85xx/
 F:	Documentation/devicetree/bindings/powerpc/fsl/
-- 
2.21.1

