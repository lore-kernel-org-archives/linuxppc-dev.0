Date: Wed, 4 Aug 2004 14:14:24 +0200
From: Wolfram Quester <wolfi@mittelerde.physik.uni-konstanz.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Comment in backlight.h
Message-ID: <20040804121424.GA1430@halley.zuhause>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi alltogether!

While digging into rivafb a little, I found the comment in backlight.h
misleading. I hope the attached patch points to the right direction.

With best regards,

Wolfi

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="backlight-cmt.diff"


Signed-Off-By: Wolfram Quester <wolfi@mittelerde.physik.uni-konstanz.de>

--- include/asm-ppc/backlight.h.orig	2004-08-04 14:02:14.000000000 +0200
+++ include/asm-ppc/backlight.h	2004-08-04 14:03:44.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * Routines for handling backlight control on PowerBooks
  *
- * For now, implementation resides in arch/ppc/kernel/pmac_support.c
+ * For now, implementation resides in arch/ppc/platforms/pmac_backlight.c
  *
  */
 #ifdef __KERNEL__

--CE+1k2dSO48ffgeK--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
