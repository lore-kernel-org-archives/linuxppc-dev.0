Date: Thu, 2 Oct 2003 18:37:16 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Stefan Berndtsson <stefan@nocrew.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Typo fix in 2.6.0-test5
In-Reply-To: <20030930230828.GA12343@ip68-0-152-218.tc.ph.cox.net>
Message-ID: <Pine.LNX.4.44.0310021828010.23664-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > linux-2.6.0-test5, rsynced from source.mvista.com::linuxppc-2.5 (is there
> > a more recently updated source than that?) doesn't seem to have a working
> > sleep-mode in an ibook2 (late 2001, 600MHz, M3/R128).
>
> It's as up to date as the bk tree as no one has pulled -test6 into it
> yet.  The rsync trees on source.mvista.com lag ~1 hour (or less) behind
> the bitkeeper versions of the trees.

Seeing as linuxppc-2.5 is the latest for those stuck with rsync, can we
get this typo fix in?

--- drivers/net/pcnet32.c.org	2003-10-02 18:22:58.000000000 +0200
+++ drivers/net/pcnet32.c	2003-10-02 18:21:38.000000000 +0200
@@ -544,6 +544,7 @@
 	} else {
 		printk(KERN_INFO "pcnet32: probe at %lx failed\n", ioaddr);
 		goto err_release_region;
+	}
     }

     chip_version = a->read_csr(ioaddr, 88) | (a->read_csr(ioaddr,89) << 16);

Also, include/video/macmodes.h is missing (used by matroxfb).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
