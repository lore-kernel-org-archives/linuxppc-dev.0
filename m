Message-ID: <38DA7CF0.BC2E49D9@mandrakesoft.com>
Date: Thu, 23 Mar 2000 15:22:08 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Request for Tulip 2.2.x testing...
Content-Type: multipart/mixed;
 boundary="------------8A337BF4B7BEEF600A79CF79"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------8A337BF4B7BEEF600A79CF79
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi all!

I was wondering if I could find anyone on here with a Tulip 21041 chip
that could do some simple testing under 2.2.15-pre15?

Questions for which answers are sought:

Does tulip.c work with your 21041 chip unmodified?
If yes, does the below patch break the tulip driver?
If no, does the below patch get your 21041 working again?

Thanks!

	Jeff




--
Jeff Garzik              | Tact is the ability to tell a man
Building 1024            | he has an open mind when he has a
MandrakeSoft, Inc.       | hole in his head.  (-random fortune)
--------------8A337BF4B7BEEF600A79CF79
Content-Type: text/plain; charset=us-ascii;
 name="tulip-2.2.15p15.patch"
Content-Disposition: inline;
 filename="tulip-2.2.15p15.patch"
Content-Transfer-Encoding: 7bit

Index: tulip.c
===================================================================
RCS file: /g/cvslan/linux_2_2/drivers/net/tulip.c,v
retrieving revision 1.1.1.6
diff -u -r1.1.1.6 tulip.c
--- tulip.c	2000/01/22 13:52:13	1.1.1.6
+++ tulip.c	2000/03/21 17:22:08
@@ -420,7 +420,7 @@
 {0,0,0,16,  3,19,16,24,  27,4,7,5, 0,20,23,20 };
 static u8 t21040_csr13[] = {2,0x0C,8,4,  4,0,0,0, 0,0,0,0, 4,0,0,0};
 /* 21041 transceiver register settings: 10-T, 10-2, AUI, 10-T, 10T-FD*/
-static u16 t21041_csr13[] = { 0xEF01, 0xEF09, 0xEF09, 0xEF01, 0xEF09, };
+static u16 t21041_csr13[] = { 0xEF05, 0xEF0D, 0xEF0D, 0xEF05, 0xEF05, };
 static u16 t21041_csr14[] = { 0xFFFF, 0xF7FD, 0xF7FD, 0x7F3F, 0x7F3D, };
 static u16 t21041_csr15[] = { 0x0008, 0x0006, 0x000E, 0x0008, 0x0008, };


--------------8A337BF4B7BEEF600A79CF79--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
