Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 4A0D6DDED5
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Jun 2007 16:57:13 +1000 (EST)
Date: Sun, 24 Jun 2007 08:57:08 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] make two xmon variables static
Message-ID: <20070624065708.GA7730@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


xmon_early and xmon_off are only used in this file.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 arch/powerpc/xmon/xmon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2634,7 +2634,7 @@ static int __init setup_xmon_sysrq(void)
 __initcall(setup_xmon_sysrq);
 #endif /* CONFIG_MAGIC_SYSRQ */
 
-int __initdata xmon_early, xmon_off;
+static int __initdata xmon_early, xmon_off;
 
 static int __init early_parse_xmon(char *p)
 {
