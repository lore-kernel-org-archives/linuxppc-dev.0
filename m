Return-Path: <bunk@kernel.org>
Received: from smtp4.pp.htv.fi (smtp4.pp.htv.fi [213.243.153.38])
	by ozlabs.org (Postfix) with ESMTP id 4CA52DDF4A
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 02:11:19 +1000 (EST)
Date: Thu, 31 Jul 2008 19:10:22 +0300
From: Adrian Bunk <bunk@kernel.org>
To: paulus@samba.org, benh@kernel.crashing.org
Subject: [2.6 patch] Add cuImage.mpc866ads to the bootwrapper as a
	cuboot-8xx target
Message-ID: <20080731161020.GD20212@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Scott Wood <scottwood@freescale.com>

This patch fixes the following build error with mpc866_ads_defconfig:

<--  snip  -->

...
  WRAP    arch/powerpc/boot/cuImage.mpc866ads
powerpc64-linux-ld: arch/powerpc/boot/cuboot-mpc866ads.o: No such file: No such file or directory
make[2]: *** [arch/powerpc/boot/cuImage.mpc866ads] Error 1

<--  snip  -->

Reported-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

This patch was sent by Scott Wood on:
- 21 May 2008

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
