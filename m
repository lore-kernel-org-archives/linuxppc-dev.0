Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 79E9D679FB
	for <linuxppc-dev@ozlabs.org>; Mon,  2 May 2005 14:47:22 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 02 May 2005 14:45:12 +1000
Message-Id: <1115009112.6030.1.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] ppc32: More fixlet for pmac sound
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

As Al Viro noticed, my previous fix missed one instance of "device" in
the driver local debug code. Harmless unless you tweak the #define's in
there but still work fixing.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 Index: linux-work/sound/ppc/toonie.c
===================================================================
--- linux-work.orig/sound/ppc/toonie.c	2005-05-02 12:14:14.000000000 +1000
+++ linux-work/sound/ppc/toonie.c	2005-05-02 14:01:01.000000000 +1000
@@ -320,7 +320,7 @@
 	}
 
 	DBG("(I) GPIO device %s found, offset: %x, active state: %d !\n",
-	    device, gp->addr, gp->active_state);
+	    name, gp->addr, gp->active_state);
 
 	return (np->n_intrs > 0) ? np->intrs[0].line : 0;
 }
