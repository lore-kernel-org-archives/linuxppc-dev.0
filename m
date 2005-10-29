Return-Path: <akpm@osdl.org>
Message-Id: <200510290046.j9T0kmQY030006@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:17 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, olh@suse.de,
	linuxppc64-dev@ozlabs.org
Subject: [patch 07/43] ppc32: update xmon help text
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Olaf Hering <olh@suse.de>

Mention a few more commands in xmon.  System.map processing was replaced
with kallsyms.

Signed-off-by: Olaf Hering <olh@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc/xmon/xmon.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff -puN arch/ppc/xmon/xmon.c~ppc32-update-xmon-help-text arch/ppc/xmon/xmon.c
--- devel/arch/ppc/xmon/xmon.c~ppc32-update-xmon-help-text	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/arch/ppc/xmon/xmon.c	2005-10-28 17:44:02.000000000 -0700
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
_
