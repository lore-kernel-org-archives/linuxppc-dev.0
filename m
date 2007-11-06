Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 008EEDDEEA
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Nov 2007 07:36:27 +1100 (EST)
Message-ID: <4730D05D.6080602@anagramm.de>
Date: Tue, 06 Nov 2007 21:36:45 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] add cuImage comment for 'make help'
Content-Type: multipart/mixed; boundary="------------000000000203020107090706"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000000000203020107090706
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

It just take some time to figure out that there is no make cuImage
for the embedded powerpc stuff when you want to embed the
OF device tree into the target.

You have to use 'make zImage' instead.

The following patch adds a comment to the platform specific
'make help' section.

Signed-off-by: Clemens Koller <clemens.koller@anagramm.de>

--------------000000000203020107090706
Content-Type: text/plain;
 name="powerpc-add-cuImage-make-help-comment.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="powerpc-add-cuImage-make-help-comment.patch"

--- arch/powerpc/Makefile~	2007-10-12 18:43:44.000000000 +0200
+++ arch/powerpc/Makefile	2007-11-06 21:27:59.000000000 +0100
@@ -159,6 +159,8 @@ $(BOOT_TARGETS): vmlinux
 
 define archhelp
   @echo '* zImage          - Compressed kernel image (arch/$(ARCH)/boot/zImage.*)'
+  @echo '                    Use this target also when you want to build a cuImage'
+  @echo '                    with an embedded OF device tree.'
   @echo '  install         - Install kernel using'
   @echo '                    (your) ~/bin/installkernel or'
   @echo '                    (distribution) /sbin/installkernel or'

--------------000000000203020107090706--
