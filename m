To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_4_devel rsync access 
In-Reply-To: Message from Murray Jensen <Murray.Jensen@cmst.csiro.au>
   of "Wed, 16 May 2001 14:00:23 +1000." <25691.989985623@msa.cmst.csiro.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 16 May 2001 15:05:48 +1000
Message-ID: <28260.989989548@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 16 May 2001 14:00:23 +1000, Murray Jensen <Murray.Jensen@cmst.csiro.au> writes:
>Hi All, it appears that the linuxppc_2_4_devel rsync tree is not being
>updated from the bk tree. I have diffed the two and there are a lot of
>changes in the bk tree that don't appear in the rsync tree.

Hmm.. Sorry about this - I saw lots of differences, particularly this one:

--- vanilla_devel/Documentation/networking/8139too.txt  Tue May  8 22:24:06 2001+++ linuxppc_2_4_devel/Documentation/networking/8139too.txt     Wed May 16 14:35:30 2001
@@ -185,6 +185,13 @@
 Change History
 --------------

+Version 0.9.17 - May 7, 2001
+
+* Fix chipset wakeup bug which prevent media connection for 8139B
+* Print out "media is unconnected..." instead of
+  "partner ability 0000"
+
+
 Version 0.9.16 - April 14, 2001

 * Complete MMIO audit, disable read-after-every-write

which made me think that the rsync tree didn't have a patch that was
applied on May 7, but checking with

	bk revtool Documentation/networking/8139too.txt

shows that this patch was applied to the bk _devel tree on May 15 (basically
yesterday) and probably hadn't reached the rsync tree yet (BitKeeper is
*very* nice for this sort of thing, isn't it?).

Please ignore my previous message - it appears that a lot of patches are being
applied as we speak and obviously there will be up to 24 hours delay before
they get into the rsync tree.

My apologies for jumping the gun and cluttering up the list with garbage.
Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
