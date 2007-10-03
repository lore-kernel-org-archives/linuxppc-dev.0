Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2A1D3DDE1B
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 01:46:08 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l93Fk3Ns027144
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Oct 2007 10:46:05 -0500
Date: Wed, 3 Oct 2007 10:45:36 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Update .gitignore for new vdso generated files
Message-ID: <Pine.LNX.4.64.0710031045130.21851@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We now generate vdso[32,64].so.dbg as part of the build so
add them to .gitignore

---
 arch/powerpc/kernel/vdso32/.gitignore |    1 +
 arch/powerpc/kernel/vdso64/.gitignore |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

in my git tree.

diff --git a/arch/powerpc/kernel/vdso32/.gitignore b/arch/powerpc/kernel/vdso32/.gitignore
index e45fba9..fea5809 100644
--- a/arch/powerpc/kernel/vdso32/.gitignore
+++ b/arch/powerpc/kernel/vdso32/.gitignore
@@ -1 +1,2 @@
 vdso32.lds
+vdso32.so.dbg
diff --git a/arch/powerpc/kernel/vdso64/.gitignore b/arch/powerpc/kernel/vdso64/.gitignore
index 3fd18cf..77a0b42 100644
--- a/arch/powerpc/kernel/vdso64/.gitignore
+++ b/arch/powerpc/kernel/vdso64/.gitignore
@@ -1 +1,2 @@
 vdso64.lds
+vdso64.so.dbg
-- 
1.5.2.4
