Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E4875688C2
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Dec 2005 05:07:33 +1100 (EST)
Date: Fri, 9 Dec 2005 19:07:28 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Message-ID: <20051209180728.GA1144@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [PATCH] make ARCH=powerpc the default
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch has to be applied, at some point in the future.


 Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.14/Makefile
===================================================================
--- linux-2.6.14.orig/Makefile
+++ linux-2.6.14/Makefile
@@ -172,7 +172,7 @@ KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$
 SUBARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ \
 				  -e s/arm.*/arm/ -e s/sa110/arm/ \
 				  -e s/s390x/s390/ -e s/parisc64/parisc/ \
-				  -e s/ppc64/powerpc/ )
+				  -e s/ppc\\\(64\\\)\\\?/powerpc/ )
 
 # Cross compiling and selecting different set of gcc/bin-utils
 # ---------------------------------------------------------------------------
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
