Subject: [PATCH] fix bad merge in drivers/video/Config.in (linuxppc-2.4)
From: Andreas Oberritter <obi@saftware.de>
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Content-Type: multipart/mixed; boundary="=-RpMEd7TQfFp88SJqrH+g"
Message-Id: <1066071151.1582.2.camel@shiva.eth.saftware.de>
Mime-Version: 1.0
Date: Mon, 13 Oct 2003 20:52:32 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-RpMEd7TQfFp88SJqrH+g
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

menuconfig didn't work anymore because of invalid syntax in Config.in.
Please apply.

Regards,
Andreas

--=-RpMEd7TQfFp88SJqrH+g
Content-Disposition: attachment; filename=video_config.diff
Content-Type: text/plain; name=video_config.diff; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

===== drivers/video/Config.in 1.34 vs edited =====
--- 1.34/drivers/video/Config.in	Tue Sep 16 07:20:21 2003
+++ edited/drivers/video/Config.in	Mon Oct 13 20:48:45 2003
@@ -425,7 +425,7 @@
 	      "$CONFIG_FB_INTEL" = "m" -o \
 	      "$CONFIG_FB_SGIVW" = "m" -o "$CONFIG_FB_SIS" = "m" -o \
 	      "$CONFIG_FB_PVR2" = "m" -o "$CONFIG_FB_VOODOO1" = "m" -o \
-	      "$CONFIG_FB_CYBER2000" = "m" -o "$CONFIG_FB_STI" = "m" ]; then
+	      "$CONFIG_FB_CYBER2000" = "m" -o "$CONFIG_FB_STI" = "m" -o \
 	      "$CONFIG_FB_XILINX" = "m" ]; then
 	    define_tristate CONFIG_FBCON_CFB32 m
 	 fi

--=-RpMEd7TQfFp88SJqrH+g--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
