Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CE099DDF14
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 01:40:01 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id mAJEdsAa021340
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 08:39:54 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add MSR[CE,
	DE] to the MSR bits we print on show_regs()
Date: Wed, 19 Nov 2008 08:39:53 -0600
Message-Id: <1227105593-29462-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/process.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 957bded..b038323 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -467,6 +467,8 @@ static struct regbit {
 	{MSR_VEC,	"VEC"},
 	{MSR_VSX,	"VSX"},
 	{MSR_ME,	"ME"},
+	{MSR_CE,	"CE"},
+	{MSR_DE,	"DE"},
 	{MSR_IR,	"IR"},
 	{MSR_DR,	"DR"},
 	{0,		NULL}
-- 
1.5.6.5
