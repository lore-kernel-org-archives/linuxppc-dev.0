Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 0BD2CDE0E9
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 08:56:34 +1000 (EST)
Date: Mon, 11 Aug 2008 18:56:29 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: some vmlinux files that should be ignored
Message-ID: <20080811185629.11ed547f@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A couple of vmlinux output files that should be ignored: vmlinux.strip
and vmlinux.lds.

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/.gitignore b/.gitignore
index 869e1a3..f7e924a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -32,6 +32,7 @@
 tags
 TAGS
 vmlinux
+vmlinux.strip
 System.map
 Module.markers
 Module.symvers
diff --git a/arch/powerpc/kernel/.gitignore b/arch/powerpc/kernel/.gitignore
new file mode 100644
index 0000000..c5f676c
--- /dev/null
+++ b/arch/powerpc/kernel/.gitignore
@@ -0,0 +1 @@
+vmlinux.lds
