To: linuxppc-embedded@lists.linuxppc.org
Subject: linuxppc_2_4_devel rsync access
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 16 May 2001 14:00:23 +1000
Message-ID: <25691.989985623@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All, it appears that the linuxppc_2_4_devel rsync tree is not being
updated from the bk tree. I have diffed the two and there are a lot of
changes in the bk tree that don't appear in the rsync tree. Could someone
check if the update is happening please? Thanks in advance. Cheers!
								Murray...

PS: if you're wondering why I don't just use the bk tree, I like using the
rsync tree because I import the sources into a local CVS repository and I
don't have to worry about doing a bk get, and then ignoring bk control files
and SCCS directories etc. (I will do this now, but the rsync is easier for
me - if it is up to date).
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
