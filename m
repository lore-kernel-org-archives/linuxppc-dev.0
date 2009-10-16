Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 68565B875B
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Oct 2009 04:21:55 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/5] powerpc: Cleanup lib/Kconfig.debug
Date: Fri, 16 Oct 2009 12:21:39 -0500
Message-Id: <1255713699-21852-6-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1255713699-21852-5-git-send-email-galak@kernel.crashing.org>
References: <1255713699-21852-1-git-send-email-galak@kernel.crashing.org>
	<1255713699-21852-2-git-send-email-galak@kernel.crashing.org>
	<1255713699-21852-3-git-send-email-galak@kernel.crashing.org>
	<1255713699-21852-4-git-send-email-galak@kernel.crashing.org>
	<1255713699-21852-5-git-send-email-galak@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We don't need an explicit PPC64 in the DEBUG_PREEMPT dependancies as all
PPC platforms now support TRACE_IRQFLAGS_SUPPORT.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 lib/Kconfig.debug |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 30df586..234ceb1 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -392,7 +392,7 @@ config DEBUG_KMEMLEAK_TEST
 
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
-	depends on DEBUG_KERNEL && PREEMPT && (TRACE_IRQFLAGS_SUPPORT || PPC64)
+	depends on DEBUG_KERNEL && PREEMPT && TRACE_IRQFLAGS_SUPPORT
 	default y
 	help
 	  If you say Y here then the kernel will use a debug variant of the
-- 
1.6.0.6
