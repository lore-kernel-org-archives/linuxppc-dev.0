Return-Path: <jonsmirl@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 05A25B71A5
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Jun 2009 11:26:09 +1000 (EST)
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 4CCD5DDDA0
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2009 11:26:06 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1260781ywt.39
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Jun 2009 18:26:05 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by terra with esmtp (Exim 4.69) (envelope-from <jonsmirl@gmail.com>)
	id 1MIYIN-0008D2-53
	for linuxppc-dev@ozlabs.org; Sun, 21 Jun 2009 21:26:03 -0400
Subject: [PATCH] Have git ignore generated files from dtc compile
To: linuxppc-dev@ozlabs.org
From: Jon Smirl <jonsmirl@gmail.com>
Date: Sun, 21 Jun 2009 21:26:03 -0400
Message-ID: <20090622012603.31524.1342.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


---
 arch/powerpc/boot/.gitignore |   10 ++++++++++
 scripts/dtc/.gitignore       |    5 +++++
 2 files changed, 15 insertions(+), 0 deletions(-)
 create mode 100644 scripts/dtc/.gitignore

diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
index d57aa5c..dab1b41 100644
--- a/arch/powerpc/boot/.gitignore
+++ b/arch/powerpc/boot/.gitignore
@@ -37,3 +37,13 @@ zImage.pseries
 zconf.h
 zlib.h
 zutil.h
+fdt.c
+fdt.h
+fdt_ro.c
+fdt_rw.c
+fdt_strerror.c
+fdt_sw.c
+fdt_wip.c
+libfdt.h
+libfdt_internal.h
+
diff --git a/scripts/dtc/.gitignore b/scripts/dtc/.gitignore
new file mode 100644
index 0000000..095acb4
--- /dev/null
+++ b/scripts/dtc/.gitignore
@@ -0,0 +1,5 @@
+dtc
+dtc-lexer.lex.c
+dtc-parser.tab.c
+dtc-parser.tab.h
+
