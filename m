Date: Sun, 17 Sep 2000 20:59:35 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: __ioremap_at() in 2.4.0-test9-pre2
Message-ID: <Pine.LNX.4.10.10009172058340.715-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


While reading the test9-pre2 diff, I saw

--- native-2.4.0-test9-pre1/include/asm-ppc/io.h	Sat Jun 24 10:37:42 2000
+++ native-2.4.0-test9-pre2/include/asm-ppc/io.h	Sun Sep 17 19:59:42 2000
@@ -123,6 +181,8 @@
  */
 extern void *__ioremap(unsigned long address, unsigned long size,
 		       unsigned long flags);
+extern void *__ioremap_at(unsigned long phys, unsigned long size,
+			  unsigned long flags);
 extern void *ioremap(unsigned long address, unsigned long size);
 #define ioremap_nocache(addr, size)	ioremap((addr), (size))
 extern void iounmap(void *addr);

and wondered what __ioremap_at() is used for? It's nowhere defined.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
