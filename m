Date: Fri, 16 Jan 2004 17:18:55 +0100
To: linuxppc-dev@lists.linuxppc.org
Subject: radeon 9200SE device id support for 2.4 and 2.6.
Message-ID: <20040116161855.GA10373@iliana>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hello,

Here is a smallish patch which can be added to both the 2.4 and 2.6
trees (altough the patch is against tag v2.4.24 of the linuxppc-2.4
tree).

It adds support for the Radeon 9200Se Ya, Yb, Yc and Yd variants, works
fine for me, and i think i have seen it also used by some other
debian/ppc users.

Friendly,

Sven Luther

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="radeon9200se.diff"

diff -urN linuxppc-2.4.24/drivers/video/radeonfb.c linux-2.4.24-pegasos/drivers/video/radeonfb.c
--- linuxppc-2.4.24/drivers/video/radeonfb.c	2004-01-11 18:43:09.000000000 +0100
+++ linux-2.4.24-pegasos/drivers/video/radeonfb.c	2004-01-14 10:59:39.000000000 +0100
@@ -202,6 +202,10 @@
 	RADEON_If,
 	RADEON_Ig,
 	RADEON_Y_,
+	RADEON_Ya,
+	RADEON_Yb,
+	RADEON_Yc,
+	RADEON_Yd,
 	RADEON_Ld,
 	RADEON_Le,
 	RADEON_Lf,
@@ -261,6 +265,10 @@
 	{ "9000 If", RADEON_RV250 },
 	{ "9000 Ig", RADEON_RV250 },
 	{ "9200 Y", RADEON_RV280 },
+	{ "9200 Ya", RADEON_RV280 },
+	{ "9200 Yb", RADEON_RV280 },
+	{ "9200 Yc", RADEON_RV280 },
+	{ "9200 Yd", RADEON_RV280 },
 	{ "M9 Ld", RADEON_M9 },
 	{ "M9 Le", RADEON_M9 },
 	{ "M9 Lf", RADEON_M9 },
@@ -326,6 +334,10 @@
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_NH, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_NH},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_NI, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_NI},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Y_, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Y_},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Ya, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Ya},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Ya, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Yb},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Ya, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Yc},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Yd, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Yd},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_AD, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_AD},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_AP, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_AP},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_AR, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_AR},
diff -urN linuxppc-2.4.24/include/linux/pci_ids.h linux-2.4.24-pegasos/include/linux/pci_ids.h
--- linuxppc-2.4.24/include/linux/pci_ids.h	2004-01-11 18:41:11.000000000 +0100
+++ linux-2.4.24-pegasos/include/linux/pci_ids.h	2004-01-14 10:59:39.000000000 +0100
@@ -287,6 +287,10 @@
 #define PCI_DEVICE_ID_ATI_RADEON_Ig	0x4967
 /* Radeon RV280 (9200) */
 #define PCI_DEVICE_ID_ATI_RADEON_Y_	0x5960
+#define PCI_DEVICE_ID_ATI_RADEON_Ya    0x5961
+#define PCI_DEVICE_ID_ATI_RADEON_Yb    0x5962
+#define PCI_DEVICE_ID_ATI_RADEON_Yc    0x5963
+#define PCI_DEVICE_ID_ATI_RADEON_Yd    0x5964
 /* Radeon R300 (9700) */
 #define PCI_DEVICE_ID_ATI_RADEON_ND	0x4e44
 #define PCI_DEVICE_ID_ATI_RADEON_NE	0x4e45

--J2SCkAp4GZ/dPZZf--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
