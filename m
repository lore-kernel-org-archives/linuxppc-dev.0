Return-Path: <msm@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142]) by ozlabs.org (Postfix) with ESMTP id CC7D3B6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Sep 2010 04:49:15 +1000 (EST)
Received: from mail69-db3 (localhost.localdomain [127.0.0.1])	by
	mail69-db3-R.bigfish.com (Postfix) with ESMTP id 74B6114980EB	for
	<linuxppc-dev@lists.ozlabs.org>; Tue,  7 Sep 2010 18:49:05 +0000 (UTC)
Received: from DB3EHSMHS003.bigfish.com (unknown [10.3.81.244])	by
	mail69-db3.bigfish.com (Postfix) with ESMTP id 488FAD80053	for
	<linuxppc-dev@lists.ozlabs.org>; Tue,  7 Sep 2010 18:49:05 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o87In1Be001933	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 7 Sep 2010 11:49:01 -0700 (MST)
From: Matthew McClintock <msm@freescale.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC] arch/powerpc: Remove duplicate/redundant Altivec entries
Date: Tue, 7 Sep 2010 13:56:55 -0500
Message-ID: <1283885815-11175-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Matthew McClintock <msm@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In lieu of having multiple similiar lines, we can just have one
generic cpu-as line for CONFIG_ALTIVEC

---
Was hoping to get comments about this change and if anyone sees any potential
problems?

 arch/powerpc/Makefile |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index e07d499..4e88b42 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -131,8 +131,7 @@ KBUILD_CFLAGS		+= -mno-sched-epilog
 endif
 
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
-cpu-as-$(CONFIG_6xx)		+= -Wa,-maltivec
-cpu-as-$(CONFIG_POWER4)		+= -Wa,-maltivec
+cpu-as-$(CONFIG_ALTIVEC)	+= -Wa,-maltivec
 cpu-as-$(CONFIG_E500)		+= -Wa,-me500
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 
-- 
1.6.6.1
