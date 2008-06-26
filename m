Return-Path: <bwalle@suse.de>
Received: from mx1.suse.de (mx1.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ED5D0DE39F
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 03:01:43 +1000 (EST)
From: Bernhard Walle <bwalle@suse.de>
To: jwboyer@gmail.com
Subject: [PATCH] Remove experimental status of kdump on PPC64
Date: Thu, 26 Jun 2008 19:02:15 +0200
Message-Id: <1214499735-20951-1-git-send-email-bwalle@suse.de>
In-Reply-To: <1214494132.2791.0.camel@weaponx>
References: <1214494132.2791.0.camel@weaponx>
Cc: linuxppc-dev@ozlabs.org, Bernhard Walle <bwalle@suse.de>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch removes the experimental status of kdump on PPC64. kdump is on PPC64
now since more than one year and it has proven to be stable.

For i386/x86_64, a similar patch has been accepted by Ingo Molnar and Vivek
Goyal.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 arch/powerpc/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3934e26..2a116b9 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -308,8 +308,8 @@ config KEXEC
 	  strongly in flux, so no good recommendation can be made.
 
 config CRASH_DUMP
-	bool "Build a kdump crash kernel (EXPERIMENTAL)"
-	depends on PPC_MULTIPLATFORM && PPC64 && EXPERIMENTAL
+	bool "Build a kdump crash kernel"
+	depends on PPC_MULTIPLATFORM && PPC64
 	help
 	  Build a kernel suitable for use as a kdump capture kernel.
 	  The kernel will be linked at a different address than normal, and
-- 
1.5.6
