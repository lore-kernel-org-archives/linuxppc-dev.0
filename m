Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 04359DDFA3
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 06:51:01 +1100 (EST)
Date: Wed, 28 Jan 2009 14:50:57 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Ignore vmlinux.strip
Message-ID: <20090128145057.7ff2d12a@lappy.seanm.ca>
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

Not sure if this is PPC specific or not. I use the following patch to
get a clean git status. Does nobody else see this file? Or am I missing
a step somewhere?

Cheers,
   Sean

Ignore the vmlinux.strip file.

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
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
