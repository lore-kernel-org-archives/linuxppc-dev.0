Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428h2413nTzF36V
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 20:27:55 +1000 (AEST)
Subject: Patch "powerpc/platforms/85xx: fix t1042rdb_diu.c build errors &
 warning" has been added to the 4.18-stable tree
To: alexander.levin@microsoft.com, benh@kernel.crashing.org,
 galak@kernel.crashing.org, gregkh@linuxfoundation.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, oss@buserror.net,
 paulus@samba.org, rdunlap@infradead.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 11 Sep 2018 12:14:59 +0200
Message-ID: <1536660899131191@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

    powerpc/platforms/85xx: fix t1042rdb_diu.c build errors & warning

to the 4.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     powerpc-platforms-85xx-fix-t1042rdb_diu.c-build-errors-warning.patch
and it can be found in the queue-4.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo@baz Tue Sep 11 12:05:55 CEST 2018
From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 15 Jul 2018 10:34:46 -0700
Subject: powerpc/platforms/85xx: fix t1042rdb_diu.c build errors & warning

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit f5daf77a55ef0e695cc90c440ed6503073ac5e07 ]

Fix build errors and warnings in t1042rdb_diu.c by adding header files
and MODULE_LICENSE().

../arch/powerpc/platforms/85xx/t1042rdb_diu.c:152:1: warning: data definition has no type or storage class
 early_initcall(t1042rdb_diu_init);
../arch/powerpc/platforms/85xx/t1042rdb_diu.c:152:1: error: type defaults to 'int' in declaration of 'early_initcall' [-Werror=implicit-int]
../arch/powerpc/platforms/85xx/t1042rdb_diu.c:152:1: warning: parameter names (without types) in function declaration

and
WARNING: modpost: missing MODULE_LICENSE() in arch/powerpc/platforms/85xx/t1042rdb_diu.o

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Scott Wood <oss@buserror.net>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/85xx/t1042rdb_diu.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/powerpc/platforms/85xx/t1042rdb_diu.c
+++ b/arch/powerpc/platforms/85xx/t1042rdb_diu.c
@@ -9,8 +9,10 @@
  * option) any later version.
  */
 
+#include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 
@@ -150,3 +152,5 @@ static int __init t1042rdb_diu_init(void
 }
 
 early_initcall(t1042rdb_diu_init);
+
+MODULE_LICENSE("GPL");


Patches currently in stable-queue which might be from rdunlap@infradead.org are

queue-4.18/scripts-modpost-check-memory-allocation-results.patch
queue-4.18/um-fix-parallel-building-with-o-option.patch
queue-4.18/mm-make-deferred_struct_page_init-explicitly-depend-on-sparsemem.patch
queue-4.18/platform-x86-intel_punit_ipc-fix-build-errors.patch
queue-4.18/powerpc-platforms-85xx-fix-t1042rdb_diu.c-build-errors-warning.patch
