Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 25AB868373
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Sep 2005 23:05:26 +1000 (EST)
Date: Mon, 26 Sep 2005 15:05:17 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, Paul Mackeras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
Message-ID: <20050926130517.GA15109@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [PATCH] update xmon help text for ppc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


mention a few more commands in xmon.
System.map processing was replaced with kallsyms.

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/ppc/xmon/xmon.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

Index: linux-2.6.13.orig/arch/ppc/xmon/xmon.c
===================================================================
--- linux-2.6.13.orig.orig/arch/ppc/xmon/xmon.c
+++ linux-2.6.13.orig/arch/ppc/xmon/xmon.c
@@ -148,9 +148,14 @@ Commands:\n\
   r	print registers\n\
   S	print special registers\n\
   t	print backtrace\n\
-  la	lookup address in system.map\n\
-  ls	lookup symbol in system.map\n\
+  la	lookup address\n\
+  ls	lookup symbol\n\
+  C	checksum\n\
+  P	call function with arguments\n\
+  T	print time\n\
   x	exit monitor\n\
+  zr    reboot\n\
+  zh    halt\n\
 ";
 
 static int xmon_trace[NR_CPUS];
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
