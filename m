Return-Path: <andrea.gelmini@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by ozlabs.org (Postfix) with ESMTP id 8DC27B7D2D
	for <linuxppc-dev@ozlabs.org>; Mon, 24 May 2010 05:58:08 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so775949fga.3
	for <linuxppc-dev@ozlabs.org>; Sun, 23 May 2010 12:58:05 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Subject: [PATCH 081/199] Documentation/powerpc/mpc52xx.txt: Checkpatch cleanup
Date: Sun, 23 May 2010 21:56:35 +0200
Message-Id: <1274644605-25181-39-git-send-email-andrea.gelmini@gelma.net>
In-Reply-To: <1274644605-25181-1-git-send-email-andrea.gelmini@gelma.net>
References: <1274644605-25181-1-git-send-email-andrea.gelmini@gelma.net>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-doc@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Documentation/powerpc/mpc52xx.txt:5: ERROR: trailing whitespace
Documentation/powerpc/mpc52xx.txt:13: ERROR: trailing whitespace
Documentation/powerpc/mpc52xx.txt:18: ERROR: trailing whitespace
Documentation/powerpc/mpc52xx.txt:24: ERROR: trailing whitespace
Documentation/powerpc/mpc52xx.txt:25: ERROR: trailing whitespace
Documentation/powerpc/mpc52xx.txt:29: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/powerpc/mpc52xx.txt |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/powerpc/mpc52xx.txt b/Documentation/powerpc/mpc52xx.txt
index 10dd4ab..0d540a3 100644
--- a/Documentation/powerpc/mpc52xx.txt
+++ b/Documentation/powerpc/mpc52xx.txt
@@ -2,7 +2,7 @@ Linux 2.6.x on MPC52xx family
 -----------------------------
 
 For the latest info, go to http://www.246tNt.com/mpc52xx/
- 
+
 To compile/use :
 
   - U-Boot:
@@ -10,23 +10,23 @@ To compile/use :
         if you wish to ).
      # make lite5200_defconfig
      # make uImage
-    
+
      then, on U-boot:
      => tftpboot 200000 uImage
      => tftpboot 400000 pRamdisk
      => bootm 200000 400000
-    
+
   - DBug:
      # <edit Makefile to set ARCH=ppc & CROSS_COMPILE=... ( also EXTRAVERSION
         if you wish to ).
      # make lite5200_defconfig
      # cp your_initrd.gz arch/ppc/boot/images/ramdisk.image.gz
-     # make zImage.initrd 
-     # make 
+     # make zImage.initrd
+     # make
 
      then in DBug:
      DBug> dn -i zImage.initrd.lite5200
-     
+
 
 Some remarks :
  - The port is named mpc52xxx, and config options are PPC_MPC52xx. The MGT5100
-- 
1.7.1.251.gf80a2
