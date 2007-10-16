Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 99FBADDE43
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 23:32:49 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1IhmXN-0003CC-39
	for linuxppc-dev@ozlabs.org; Tue, 16 Oct 2007 08:32:46 -0500
To: linuxppc-dev@ozlabs.org
Subject: DTC Updates
Date: Tue, 16 Oct 2007 08:32:45 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IhmXN-0003CC-39@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Guys and Dolls,

I pushed out all of David's recent DTC and libfdt patches.
I also jammed the following patch into the mix as well.

HTH,
jdl



commit 9e32930ebcacfcf7cb7c1c2b8e776eb3957cf6cb
Author: Jon Loeliger <jdl@freescale.com>
Date:   Tue Oct 16 07:35:38 2007 -0500

    Restore warning message about bison expected output.

    It was dropped in ad9593f229362782b953da4b805df713e8468df0.

    Signed-off-by: Jon Loeliger <jdl@jdl.com>

diff --git a/Makefile b/Makefile
index 84f0efe..d7d1af5 100644
--- a/Makefile
+++ b/Makefile
@@ -207,6 +207,7 @@ clean: libfdt_clean tests_clean

 %.tab.c %.tab.h %.output: %.y
        @$(VECHO) BISON $@
+       @$(VECHO) ---- Expect 2 s/r and 2 r/r. ----
        $(BISON) -d $<

 FORCE:
