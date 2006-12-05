Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 532A567B6C
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Dec 2006 09:30:22 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [PATCH] cell: fix spu_info.h header export
Date: Tue, 5 Dec 2006 23:30:16 +0100
References: <4575E712.5020103@am.sony.com> <200612052306.42632.arnd@arndb.de>
	<4575F092.8060604@am.sony.com>
In-Reply-To: <4575F092.8060604@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200612052330.16986.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It uses #ifdef __KERNEL__, so needs to be processes with unifdef

Signed-off-by: Arnd Bergann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/include/asm-powerpc/Kbuild
===================================================================
--- linux-2.6.orig/include/asm-powerpc/Kbuild
+++ linux-2.6/include/asm-powerpc/Kbuild
@@ -17,7 +17,6 @@ header-y += ipc.h
 header-y += poll.h
 header-y += shmparam.h
 header-y += sockios.h
-header-y += spu_info.h
 header-y += ucontext.h
 header-y += ioctl.h
 header-y += linkage.h
@@ -37,6 +36,7 @@ unifdef-y += posix_types.h
 unifdef-y += ptrace.h
 unifdef-y += seccomp.h
 unifdef-y += signal.h
+unifdef-y += spu_info.h
 unifdef-y += termios.h
 unifdef-y += types.h
 unifdef-y += unistd.h
