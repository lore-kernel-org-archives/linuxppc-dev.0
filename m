Return-Path: <>
Received: from asclepius.site5.com (asclepius.site5.com [70.47.36.37])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 55703DDF61
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 14:10:46 +1100 (EST)
Date: Thu, 22 Mar 2007 22:44:31 -0400
From: Sonny Rao <sonny@burdell.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [TRIVIAL] Remove stale comment from head_64.S
Message-ID: <20070323024431.GA8349@kevlar.boston.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove a stale comment in head_64.S

This is now inaccurate because we may not have entered prom_init() and
r3 is overwritten immediately anyway.

Signed-off-by: Sonny Rao <sonny@burdell.org>

--- linux/arch/powerpc/kernel/head_64.S.orig	2007-03-22 21:40:53.000000000 -0500
+++ linux/arch/powerpc/kernel/head_64.S	2007-03-22 21:44:31.000000000 -0500
@@ -1735,10 +1735,6 @@ _STATIC(__boot_from_prom)
 	/* We never return */
 	trap
 
-/*
- * At this point, r3 contains the physical address we are running at,
- * returned by prom_init()
- */
 _STATIC(__after_prom_start)
 
 /*
