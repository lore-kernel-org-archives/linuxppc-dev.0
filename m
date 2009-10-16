Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 409C4B8476
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Oct 2009 04:21:52 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/5] powerpc: clean up sound/ppc/Kconfig
Date: Fri, 16 Oct 2009 12:21:38 -0500
Message-Id: <1255713699-21852-5-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1255713699-21852-4-git-send-email-galak@kernel.crashing.org>
References: <1255713699-21852-1-git-send-email-galak@kernel.crashing.org>
	<1255713699-21852-2-git-send-email-galak@kernel.crashing.org>
	<1255713699-21852-3-git-send-email-galak@kernel.crashing.org>
	<1255713699-21852-4-git-send-email-galak@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can replace PPC32 || PPC64 as a dependancy with just PPC as all
powerpc platforms (32-bit and 64-bit) define PPC now.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 sound/ppc/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/ppc/Kconfig b/sound/ppc/Kconfig
index bd2338a..0519c60 100644
--- a/sound/ppc/Kconfig
+++ b/sound/ppc/Kconfig
@@ -2,7 +2,7 @@
 
 menuconfig SND_PPC
 	bool "PowerPC sound devices"
-	depends on PPC64 || PPC32
+	depends on PPC
 	default y
 	help
 	  Support for sound devices specific to PowerPC architectures.
-- 
1.6.0.6
