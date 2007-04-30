Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E1BF1DDF6A
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 07:01:04 +1000 (EST)
Message-ID: <46365908.1010808@am.sony.com>
Date: Mon, 30 Apr 2007 14:00:56 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [patch 3/6] PS3: Remove duplicate variable assignement
References: <20070430202420.872228544@am.sony.com>
In-Reply-To: <20070430202420.872228544@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A minor change to remove a duplicate variable assignement in ps3_mm_shutdown();

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 arch/powerpc/platforms/ps3/mm.c |    1 -
 1 file changed, 1 deletion(-)

--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/mm.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/mm.c
@@ -826,5 +826,4 @@ void __init ps3_mm_init(void)
 void ps3_mm_shutdown(void)
 {
 	ps3_mm_region_destroy(&map.r1);
-	map.total = map.rm.size;
 }

-- 
