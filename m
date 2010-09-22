Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	by ozlabs.org (Postfix) with ESMTP id 4CDA8B70AE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Sep 2010 19:47:07 +1000 (EST)
Date: Wed, 22 Sep 2010 11:22:40 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] fix two typos in Documentation/powerpc/booting-without-of.txt
Message-ID: <20100922092240.GM27439@mail.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-doc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 302db5d..3272ed5 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -131,7 +131,7 @@ order to avoid the degeneration that had become the ppc32 kernel entry
 point and the way a new platform should be added to the kernel. The
 legacy iSeries platform breaks those rules as it predates this scheme,
 but no new board support will be accepted in the main tree that
-doesn't follows them properly.  In addition, since the advent of the
+doesn't follow them properly.  In addition, since the advent of the
 arch/powerpc merged architecture for ppc32 and ppc64, new 32-bit
 platforms and 32-bit platforms which move into arch/powerpc will be
 required to use these rules as well.
@@ -1025,7 +1025,7 @@ dtc source code can be found at
 
 WARNING: This version is still in early development stage; the
 resulting device-tree "blobs" have not yet been validated with the
-kernel. The current generated bloc lacks a useful reserve map (it will
+kernel. The current generated block lacks a useful reserve map (it will
 be fixed to generate an empty one, it's up to the bootloader to fill
 it up) among others. The error handling needs work, bugs are lurking,
 etc...
