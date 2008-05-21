Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 69271DE75C
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 04:41:19 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m4LIfDZf024762
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 11:41:14 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m4LIfD8w011990
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 13:41:13 -0500 (CDT)
Date: Wed, 21 May 2008 13:41:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH] Add cuImage.mpc866ads to the bootwrapper as a cuboot-8xx
	target.
Message-ID: <20080521184113.GB3583@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, bunk@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As pointed out by Adrian Bunk.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/wrapper |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index d6c96d9..3b59e33 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -159,7 +159,7 @@ cuboot*)
     binary=y
     gzip=
     case "$platform" in
-    *-mpc885ads|*-adder875*|*-ep88xc)
+    *-mpc866ads|*-mpc885ads|*-adder875*|*-ep88xc)
         platformo=$object/cuboot-8xx.o
         ;;
     *5200*|*-motionpro)
-- 
1.5.3
