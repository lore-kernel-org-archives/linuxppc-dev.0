Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D08F667BB1
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2006 10:24:29 +1000 (EST)
Date: Sat, 23 Sep 2006 01:24:25 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] aoa is pmac-only
Message-ID: <20060923002425.GY29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 sound/aoa/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/aoa/Kconfig b/sound/aoa/Kconfig
index 2f4334d..5d5813c 100644
--- a/sound/aoa/Kconfig
+++ b/sound/aoa/Kconfig
@@ -1,5 +1,5 @@
 menu "Apple Onboard Audio driver"
-	depends on SND!=n && PPC
+	depends on SND!=n && PPC_PMAC
 
 config SND_AOA
 	tristate "Apple Onboard Audio driver"
-- 
1.4.2.GIT
