Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 87F7FDDF30
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 09:13:02 +1000 (EST)
Message-Id: <200805142312.m4ENCsdu026262@imap1.linux-foundation.org>
Subject: [patch 3/4] macintosh: replace deprecated __initcall with
	device_initcall
To: paulus@samba.org
From: akpm@linux-foundation.org
Date: Wed, 14 May 2008 16:12:53 -0700
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, rpjday@crashcourse.ca
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: "Robert P. J. Day" <rpjday@crashcourse.ca>

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/macintosh/adb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/macintosh/adb.c~macintosh-replace-deprecated-__initcall-with-device_initcall drivers/macintosh/adb.c
--- a/drivers/macintosh/adb.c~macintosh-replace-deprecated-__initcall-with-device_initcall
+++ a/drivers/macintosh/adb.c
@@ -334,7 +334,7 @@ int __init adb_init(void)
 	return 0;
 }
 
-__initcall(adb_init);
+device_initcall(adb_init);
 
 static int
 do_adb_reset_bus(void)
_
