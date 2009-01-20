Return-Path: <jwboyer@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id F378CDDEFF
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 02:16:46 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so758681qwb.15
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 07:16:44 -0800 (PST)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Tue, 20 Jan 2009 10:16:36 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Remove arch/ppc cruft from Kconfig
Message-ID: <20090120151613.GA2379@yoda.jdub.homelinux.org>
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

Remove some leftover cruft from the arch/ppc days

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e39b73b..74cc312 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -876,10 +876,6 @@ source "drivers/Kconfig"
 
 source "fs/Kconfig"
 
-# XXX source "arch/ppc/8xx_io/Kconfig"
-
-# XXX source "arch/ppc/8260_io/Kconfig"
-
 source "arch/powerpc/sysdev/qe_lib/Kconfig"
 
 source "lib/Kconfig"
