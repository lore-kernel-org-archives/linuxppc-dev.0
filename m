Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AE74568863
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2005 07:10:16 +1100 (EST)
Date: Thu, 1 Dec 2005 21:10:10 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Message-ID: <20051201201010.GA2741@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [PATCH] powerpc: correct the NR_CPUS description text
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Update the help text to match the allowed range.

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.15-rc4-olh/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.15-rc4-olh.orig/arch/powerpc/Kconfig
+++ linux-2.6.15-rc4-olh/arch/powerpc/Kconfig
@@ -227,7 +227,7 @@ config SMP
 	  If you don't know what to do here, say N.
 
 config NR_CPUS
-	int "Maximum number of CPUs (2-32)"
+	int "Maximum number of CPUs (2-128)"
 	range 2 128
 	depends on SMP
 	default "32" if PPC64
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
