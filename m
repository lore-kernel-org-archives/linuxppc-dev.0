Date: Mon, 14 Feb 2000 12:26:30 -0500 (EST)
From: Pavel Roskin <pavel_roskin@geocities.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Warning fix
Message-ID: <Pine.LNX.4.21.0002141221550.19395-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

This patch fixes a warning in the kernel (2.2.13)
Anyway, warnings are not quite useful to anybody except those who wrote
this code.

Pavel Roskin

=== cut here ===
diff -u -r1.1.1.1 misc.c
--- arch/ppc/mbxboot/misc.c	2000/01/03 20:10:39	1.1.1.1
+++ arch/ppc/mbxboot/misc.c	2000/02/14 16:53:30
@@ -261,7 +261,7 @@
 	/* Set end of memory available to us.  It is always the highest
 	 * memory address provided by the board information.
 	 */
-	end_avail = bp->bi_memsize;
+	end_avail = (char *)bp->bi_memsize;
 #endif

 	puts("loaded at:     "); puthex(load_addr);
=== cut here ===


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
