Return-Path: <jonsmirl@gmail.com>
Received: from vms044pub.verizon.net (vms044pub.verizon.net [206.46.252.44])
	by ozlabs.org (Postfix) with ESMTP id 2B0F9DDF86
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 13:39:47 +1100 (EST)
Received: from terra.home ([96.233.72.204])
	by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01
	(built Apr
	3 2006)) with ESMTPA id <0JT8007K14PSLAA2@vms044.mailsrvcs.net> for
	linuxppc-dev@ozlabs.org; Mon, 17 Dec 2007 20:39:29 -0600 (CST)
Date: Mon, 17 Dec 2007 21:39:28 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH 7/7] Makefile
In-reply-to: <20071218023913.8530.46661.stgit@terra.home>
To: i2c@lm-sensors.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Message-id: <20071218023928.8530.25171.stgit@terra.home>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071218023913.8530.46661.stgit@terra.home>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---

 Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)


diff --git a/Makefile b/Makefile
index c1825aa..15ada3f 100644
--- a/Makefile
+++ b/Makefile
@@ -35,6 +35,9 @@ MAKEFLAGS += -rR --no-print-directory
 # To put more focus on warnings, be less verbose as default
 # Use 'make V=1' to see the full commands
 
+ARCH=powerpc
+CROSS_COMPILE=powerpc-603e-linux-gnu-
+
 ifdef V
   ifeq ("$(origin V)", "command line")
     KBUILD_VERBOSE = $(V)
