Message-Id: <200105062011.WAA00674@piglet.grunz.lu>
Date: Sun, 6 May 2001 22:11:33 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Airport in BenH's kernels
To: linuxppc-dev@lists.linuxppc.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134458388-1804289383-989179897=:672"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134458388-1804289383-989179897=:672
Content-Type: TEXT/plain; charset=us-ascii

Hi all,

For a few days airport doesn't work in BenH's kernels, due do an
unresolved symbol in orinoco.o.

Below is a two-line patch that fixes the problem.

Have fun!

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134458388-1804289383-989179897=:672
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Disposition: attachment; filename="orinoco.patch"

--- /usr/src/sources/2.4/linux-2.4.benh/drivers/net/wireless/orinoco.c	Sun May  6 18:32:27 2001
+++ drivers/net/wireless/orinoco.c	Sun May  6 22:00:56 2001
@@ -3520,7 +3520,9 @@
 	return 0;
 }

+#ifdef ORINOCO_DEBUG
 EXPORT_SYMBOL(dldwd_debug);
+#endif
 EXPORT_SYMBOL(dldwd_init);
 EXPORT_SYMBOL(dldwd_xmit);
 EXPORT_SYMBOL(dldwd_tx_timeout);

--134458388-1804289383-989179897=:672--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
