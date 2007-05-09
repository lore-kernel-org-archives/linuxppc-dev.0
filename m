Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 586A0DDE41
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 17:38:16 +1000 (EST)
Date: Wed, 09 May 2007 16:38:03 +0900 (JST)
Message-Id: <200705090738.l497cABK010861@toshiba.co.jp>
Subject: [PATCH 3/4] celleb: fix parsing machine type hack command line
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a bugfix to install Fedora Core 6 by using kernel
command line 'celleb_machine_type_hack=CHRP'.

Yes, this is a one-character fix to add forgotten '='.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c
diff -u linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c:1.1.1.4 linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c:1.28.2.1
--- linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c:1.1.1.4	Tue May  8 09:43:56 2007
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c	Tue May  8 14:36:58 2007
@@ -80,7 +80,7 @@
 	return 0;
 }
 
-__setup("celleb_machine_type_hack", celleb_machine_type_hack);
+__setup("celleb_machine_type_hack=", celleb_machine_type_hack);
 
 static void celleb_progress(char *s, unsigned short hex)
 {
