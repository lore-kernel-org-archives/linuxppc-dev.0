MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: cramfs for root filesystem?
Date: Tue, 25 Jun 2002 15:30:08 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E10640128142C@cceexc18.americas.cpqcorp.net>
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "Cameron, Steve" <Steve.Cameron@hp.com>, <ssh@sgi.com>,
	<blythe@broadon.com>, <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I wrote:

> I have tried to fix up the endian-swapping patch for
> the mkcramfs from sourceforge CVS, circa Mon Jun 24, 2002
> :pserver:anonymous@cvs.cramfs.sourceforge.net:/cvsroot/cramfs

Well, I missed one thing, at least, so here is
an additional patch, below. There must be more to it
still as I haven't yet got it working.  (not sure
if problem is in mkcramfs or my kernel).

-- steve

diff -u -r1.2 mkcramfs.c
--- mkcramfs.c	25 Jun 2002 16:12:58 -0000	1.2
+++ mkcramfs.c	25 Jun 2002 20:09:45 -0000
@@ -573,6 +573,7 @@
 				stack_entries++;
 			}
 			entry = entry->next;
+			fix_inode(inode);
 		}

 		/*

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
