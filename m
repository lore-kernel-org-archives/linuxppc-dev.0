Return-Path: <xenidis@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2E29AB6F95
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 30 Sep 2011 08:05:34 +1000 (EST)
Received: by yxk8 with SMTP id 8so1234265yxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Sep 2011 15:05:32 -0700 (PDT)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
From: Jimi Xenidis <jimix@pobox.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: xmon: Fix #if typo for systems without MSR[RI]
Date: Thu, 29 Sep 2011 17:05:28 -0500
Message-Id: <1317333928-17987-1-git-send-email-jimix@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry, there was a typo in the #if

signed-off-by: Jimi Xenidis <jimix@pobox.com>
---
 arch/powerpc/xmon/xmon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 13f82f8..e88e7f5 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -340,7 +340,7 @@ int cpus_are_in_xmon(void)
 
 static inline int unrecoverable_excp(struct pt_regs *regs)
 {
-#if defined(CONFIG_4xx) || defined(CONFIG_BOOK3E)
+#if defined(CONFIG_4xx) || defined(CONFIG_PPC_BOOK3E)
 	/* We have no MSR_RI bit on 4xx or Book3e, so we simply return false */
 	return 0;
 #else
-- 
1.7.0.4
