Return-Path: <rutger@wingding.demon.nl>
Received: from post-26.mail.nl.demon.net (post-26.mail.nl.demon.net
	[194.159.73.196]) by ozlabs.org (Postfix) with ESMTP id 4C64667F5E
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 07:19:38 +1100 (EST)
Received: from wingding.demon.nl ([82.161.27.36]:57573)
	by post-26.mail.nl.demon.net with esmtp (Exim 4.51)
	id 1GmDpY-000IM2-7F
	for linuxppc-dev@ozlabs.org; Mon, 20 Nov 2006 18:25:20 +0000
Received: from rutger by wingding.demon.nl with local (Exim 4.63)
	(envelope-from <rutger@wingding.demon.nl>) id 1GmDpX-00083F-H1
	for linuxppc-dev@ozlabs.org; Mon, 20 Nov 2006 19:25:19 +0100
Date: Mon, 20 Nov 2006 19:25:19 +0100
From: Rutger Nijlunsing <rutger@nospam.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Add generated powerpc files to .gitignore
Message-ID: <20061120182519.GA24789@nospam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Reply-To: linuxppc-dev@tux.tmfweb.nl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Is this the right place for patches like this to be digisted?  This
patch adds files generated on a G3 PowerBook built of 2.6-git...


Author: Rutger Nijlunsing <linuxppc-dev@tux.tmfweb.nl>
Date:   Mon Nov 20 18:52:56 2006 +0100

    Add generated powerpc files to .gitignore

diff --git a/arch/powerpc/.gitignore b/arch/powerpc/.gitignore
new file mode 100644
index 0000000..a1a869c
--- /dev/null
+++ b/arch/powerpc/.gitignore
@@ -0,0 +1 @@
+include
diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
index 45c9ad2..dadf873 100644
--- a/arch/powerpc/boot/.gitignore
+++ b/arch/powerpc/boot/.gitignore
@@ -1,20 +1,30 @@
 addnote
+empty.c
+hack-coff
 infblock.c
 infblock.h
 infcodes.c
 infcodes.h
 inffast.c
 inffast.h
+inffixed.h
 inflate.c
+inflate.h
 inftrees.c
 inftrees.h
 infutil.c
 infutil.h
 kernel-vmlinux.strip.c
 kernel-vmlinux.strip.gz
 uImage
 zImage
+zImage.chrp
+zImage.coff
+zImage.coff.lds
+zImage.lds
+zImage.miboot
+zImage.pmac
 zImage.vmode
 zconf.h
 zlib.h
 zutil.h


-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
