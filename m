Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CBE57B720D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2011 16:44:14 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Mon, 14 Nov 2011 05:32:17 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pAE5caU83461234
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2011 16:38:36 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pAE5fcQW003867
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2011 16:41:41 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v3 1/8] [44x] Fix typo in KEXEC Kconfig dependency
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 14 Nov 2011 11:11:36 +0530
Message-ID: <20111114054129.23410.57513.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20111114053749.23410.63745.stgit@suzukikp.in.ibm.com>
References: <20111114053749.23410.63745.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>, Alan Modra <amodra@au1.ibm.com>,
 Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kexec is not supported on 47x. 47x is a variant of 44x with slightly
different MMU and SMP support. There was a typo in the Kconfig
dependency for KEXEC. This patch fixes the same.

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
Cc:	Kumar Gala <galak@kernel.crashing.org>
Cc:	Josh Boyer <jwboyer@gmail.com>
Cc:	linux ppc dev <linuxppc-dev@lists.ozlabs.org>
---

 arch/powerpc/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8523bd1..d7c2d1a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -345,7 +345,7 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
 
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
-	depends on (PPC_BOOK3S || FSL_BOOKE || (44x && !SMP && !47x)) && EXPERIMENTAL
+	depends on (PPC_BOOK3S || FSL_BOOKE || (44x && !SMP && !PPC_47x)) && EXPERIMENTAL
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
