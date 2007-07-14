Return-Path: <rpjday@mindspring.com>
Received: from rubicon.netdirect.ca (nic.NetDirect.CA [216.16.235.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9795BDDF0F
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Jul 2007 08:23:24 +1000 (EST)
Date: Sat, 14 Jul 2007 18:21:20 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>
Subject: [PATCH] POWERPC:  Correct misspelled config variable in
	arch/powerpc/Kconfig.
Message-ID: <Pine.LNX.4.64.0707141820150.9894@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6beee32..0e59024 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -391,7 +391,7 @@ config NOT_COHERENT_CACHE
 	depends on 4xx || 8xx || E200
 	default y

-config CONFIG_CHECK_CACHE_COHERENCY
+config CHECK_CACHE_COHERENCY
 	bool
 endmenu


-- 
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://fsdev.net/wiki/index.php?title=Main_Page
========================================================================
