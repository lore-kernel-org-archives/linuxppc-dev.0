Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id D0A27DDF7A
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 09:41:29 +1100 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: containers@lists.osdl.org
Subject: [PATCH 3/3] allow checkpoint/restart on powerpc
Date: Wed, 28 Jan 2009 16:41:18 -0600
Message-Id: <1233182478-27113-4-git-send-email-ntl@pobox.com>
In-Reply-To: <1233182478-27113-1-git-send-email-ntl@pobox.com>
References: <1233182478-27113-1-git-send-email-ntl@pobox.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 checkpoint/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/checkpoint/Kconfig b/checkpoint/Kconfig
index ffaa635..00036aa 100644
--- a/checkpoint/Kconfig
+++ b/checkpoint/Kconfig
@@ -1,7 +1,7 @@
 config CHECKPOINT_RESTART
 	prompt "Enable checkpoint/restart (EXPERIMENTAL)"
 	def_bool n
-	depends on X86_32 && EXPERIMENTAL
+	depends on (X86_32 || PPC) && EXPERIMENTAL
 	help
 	  Application checkpoint/restart is the ability to save the
 	  state of a running application so that it can later resume
-- 
1.5.5
