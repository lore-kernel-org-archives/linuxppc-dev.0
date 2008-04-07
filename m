Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D7CEADDF5E
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 01:22:50 +1000 (EST)
Date: Mon, 7 Apr 2008 10:33:07 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Remove unused __max_memory variable
Message-ID: <20080407153307.GA21671@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove the __max_memory variable, it is not referenced anywhere
in the tree besides some code in arch/ppc.


Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 5f55399..82edd63 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -72,9 +72,6 @@
 #warning TASK_SIZE is smaller than it needs to be.
 #endif
 
-/* max amount of RAM to use */
-unsigned long __max_memory;
-
 void free_initmem(void)
 {
 	unsigned long addr;
