Return-Path: <joe@perches.com>
Received: from perches.com (DSL022.labridge.com [206.117.136.22])
	by ozlabs.org (Postfix) with ESMTP id 9DE27DDEE0
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 16:32:21 +1000 (EST)
Date: Sun, 12 Aug 2007 23:31:22 -0700
From: joe@perches.com
To: torvalds@linux-foundation.org, paulus@samba.org, paulus@au.ibm.com,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, anton@samba.org,
	anton@au.ibm.com, akpm@linux-foundation.org
Subject: [PATCH] [298/2many] MAINTAINERS - LINUX FOR 64BIT POWERPC
Message-ID: <46bffaba.dVM9Q/vXNeROaC6B%joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 6d10932..36c4960 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2857,6 +2857,9 @@ M:	anton@au.ibm.com
 W:	http://www.penguinppc.org/ppc64/
 L:	linuxppc-dev@ozlabs.org
 S:	Supported
+F:	arch/powerpc/configs/ppc64_defconfig
+F:	arch/powerpc/kernel/proc_ppc64.c
+F:	include/asm-powerpc/pgtable-ppc64.h
 
 LINUX SECURITY MODULE (LSM) FRAMEWORK
 P:	Chris Wright
