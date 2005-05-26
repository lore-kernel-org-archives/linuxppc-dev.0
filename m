Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9A1E4679FB
	for <linuxppc-dev@ozlabs.org>; Thu, 26 May 2005 22:52:57 +1000 (EST)
Date: Thu, 26 May 2005 14:52:53 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Message-ID: <20050526125253.GA26621@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [PATCH] update comment about gzip scratch size
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


fix a comment about the array size.

Signed-off-by: Olaf Hering <olh@suse.de>

Index: linux-2.6.12-rc5-olh/arch/ppc/boot/openfirmware/chrpmain.c
===================================================================
--- linux-2.6.12-rc5-olh.orig/arch/ppc/boot/openfirmware/chrpmain.c
+++ linux-2.6.12-rc5-olh/arch/ppc/boot/openfirmware/chrpmain.c
@@ -39,7 +39,7 @@ char *avail_high;
 
 #define SCRATCH_SIZE	(128 << 10)
 
-static char scratch[SCRATCH_SIZE];	/* 1MB of scratch space for gunzip */
+static char scratch[SCRATCH_SIZE];	/* 128k of scratch space for gunzip */
 
 typedef void (*kernel_start_t)(int, int, void *, unsigned int, unsigned int);
 
