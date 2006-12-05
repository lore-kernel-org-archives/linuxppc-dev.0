Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound8-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7908C67BD9
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Dec 2006 08:39:42 +1100 (EST)
Message-ID: <4575E712.5020103@am.sony.com>
Date: Tue, 05 Dec 2006 13:39:30 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] cell: fix missing spu.h header export
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add spu.h to the list of exported headers.  Fixes this error when
using 'make headers_check' or when CONFIG_HEADERS_CHECK=y:

  asm/spu_info.h requires asm/spu.h, which does not exist in exported headers


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 include/asm-powerpc/Kbuild |    1 +
 1 files changed, 1 insertion(+)

--- cell--common--7.orig/include/asm-powerpc/Kbuild
+++ cell--common--7/include/asm-powerpc/Kbuild
@@ -37,6 +37,7 @@ unifdef-y += posix_types.h
 unifdef-y += ptrace.h
 unifdef-y += seccomp.h
 unifdef-y += signal.h
+unifdef-y += spu.h
 unifdef-y += termios.h
 unifdef-y += types.h
 unifdef-y += unistd.h
