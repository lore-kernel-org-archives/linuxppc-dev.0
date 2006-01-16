Return-Path: <olh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 00B8768A1B
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jan 2006 23:12:51 +1100 (EST)
Date: Mon, 16 Jan 2006 13:12:44 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] drop linuxppc64-dev
Message-ID: <20060116121244.GB7171@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Everything is merged into arch/powerpc now.
Stop cross-posting.

Signed-off-by: Olaf Hering <olh@suse.de>

 Documentation/powerpc/hvcs.txt |    2 +-
 MAINTAINERS                    |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.15-olh/Documentation/powerpc/hvcs.txt
===================================================================
--- linux-2.6.15-olh.orig/Documentation/powerpc/hvcs.txt
+++ linux-2.6.15-olh/Documentation/powerpc/hvcs.txt
@@ -560,7 +560,7 @@ The proper channel for reporting bugs is
 distribution company that provided your OS or by posting issues to the
 ppc64 development mailing list at:
 
-linuxppc64-dev@lists.linuxppc.org
+linuxppc-dev@ozlabs.org
 
 This request is to provide a documented and searchable public exchange
 of the problems and solutions surrounding this driver for the benefit of
Index: linux-2.6.15-olh/MAINTAINERS
===================================================================
--- linux-2.6.15-olh.orig/MAINTAINERS
+++ linux-2.6.15-olh/MAINTAINERS
@@ -527,7 +527,7 @@ S:   Supported
 BROADBAND PROCESSOR ARCHITECTURE
 P:	Arnd Bergmann
 M:	arnd@arndb.de
-L:	linuxppc64-dev@ozlabs.org
+L:	linuxppc-dev@ozlabs.org
 W:	http://linuxppc64.org
 S:	Supported
 
@@ -1606,7 +1606,7 @@ P:	Anton Blanchard
 M:	anton@samba.org
 M:	anton@au.ibm.com
 W:	http://linuxppc64.org
-L:	linuxppc64-dev@ozlabs.org
+L:	linuxppc-dev@ozlabs.org
 S:	Supported
 
 LINUX SECURITY MODULE (LSM) FRAMEWORK
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
