From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15608.22619.81123.994767@argo.ozlabs.ibm.com>
Date: Sat, 1 Jun 2002 15:15:07 +1000 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: S3 trio config
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


We have this difference between drivers/video/Config in linuxppc_2_4
compared to the official tree:

diff -urN linux-2.4.19-pre9/drivers/video/Config.in linuxppc_2_4/drivers/video/Config.in
--- linux-2.4.19-pre9/drivers/video/Config.in	Tue May 28 22:39:29 2002
+++ linuxppc_2_4/drivers/video/Config.in	Sat Jun  1 14:40:58 2002
@@ -73,7 +73,7 @@
       dep_bool '  Apple "valkyrie" display support' CONFIG_FB_VALKYRIE $CONFIG_ALL_PPC
       bool '  Chips 65550 display support' CONFIG_FB_CT65550
       bool '  IMS Twin Turbo display support' CONFIG_FB_IMSTT
-      bool '  S3 Trio display support' CONFIG_FB_S3TRIO
+      dep_bool '  S3 Trio display support' CONFIG_FB_S3TRIO $CONFIG_ALL_PPC
       tristate '  VGA 16-color graphics console' CONFIG_FB_VGA16
    fi
    if [ "$CONFIG_PARISC" = "y" ]; then

Does anyone know why we have this?  Is the S3 Trio display really only
used on PReP or CHRP machines, not on any PCs?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
