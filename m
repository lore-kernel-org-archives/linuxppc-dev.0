Date: Fri, 22 Sep 2000 23:10:55 -0400
Message-Id: <200009230310.XAA08258@asgard.cs.columbia.edu>
From: "Robert M. Fuhrer" <rmf@asgard.cs.columbia.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Compile errors on kernel source from ppc.samba.org::linux-pmac-stable
Reply-to: rmf@cs.columbia.edu
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I rsync'ed twice from ppc.samba.org, and although it clearly got many
files (the first time around), the source wouldn't compile.  The first of
many batches of errors cropped up in

  drivers/block/ll_rw_blk.c

which sees no definition of the type 'elevator_t', as well as a few other
"elevator"-related types.

Granted, I rsync'ed on top of an existing 2.2.15pre9 source tree, but I
gave rsync the "--delete" and "-u" flags, which I thought should have
given me a fairly clean and up-to-date tree.  No?

The precise rsync cmd I used was

  rsync -avuz ppc.samba.org::linux-pmac-stable .

If my rsync cmd was ok, am I wrong in expecting the linux-pmac-stable
tree to compile cleanly?

Or, failing all of the above, what's wrong?

 -------------------------------------------------------------------------
 >                   "Smooth Jazz" is no jazz at all...                  <
 > Dr. Robert M. Fuhrer                           rfuhrer@watson.ibm.com <
 > Computer Music Center                 IBM T.J. Watson Research Center <
 -------------------------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
