Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews09.kpnxchange.com (cpsmtpb-ews09.kpnxchange.com
 [213.75.39.14]) by ozlabs.org (Postfix) with ESMTP id 86F7D2C0183
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jul 2013 21:15:49 +1000 (EST)
Message-ID: <1373799735.1370.5.camel@x61.thuisdomein>
Subject: [PATCH] powerpc/pseries: drop "select HOTPLUG"
From: Paul Bolle <pebolle@tiscali.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Date: Sun, 14 Jul 2013 13:02:15 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Kconfig symbol HOTPLUG was removed with commit 40b313608a ("Finally
eradicate CONFIG_HOTPLUG"). But there's still one select statement for
that symbol. It seems that select statement was added after the patch to
remove CONFIG_HOTPLUG was submitted. Anyhow, it is useless and can be
dropped.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Not tested.

 arch/powerpc/platforms/pseries/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 1bd3399..62b4f80 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -19,7 +19,6 @@ config PPC_PSERIES
 	select ZLIB_DEFLATE
 	select PPC_DOORBELL
 	select HAVE_CONTEXT_TRACKING
-	select HOTPLUG if SMP
 	select HOTPLUG_CPU if SMP
 	default y
 
-- 
1.8.1.4
