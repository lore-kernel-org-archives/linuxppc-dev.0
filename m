Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: BK... a little help please
Date: Mon, 27 May 2002 20:34:58 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFMEKLDHAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I recently cloned the linuxppc_2_4_devel tree and started working with it
but now the repository is locked and the messages say to contact BitKeeper.
Could someone take a look at the below messages and tell me what needs to be
done.

What was done:
1. make htmldocs - this failed because I am missing "fig2dev"
2. bk pull - results in the messages below
3. bk -r check -acf
   Unfortunately, this did not auto-matically correct my problem.
4. bk pull - says that the repository is locked by RESYNC directory

All help and pointers on using BK welcome.

TIA

========================================================================
Applying   1 revisions to ChangeSet
Applying   1 revisions to BitKeeper/deleted/.del-ocp-dma.h~39362d3f62392136
Applying   1 revisions to include/asm-ppc/ocp.h
takepatch: 3 new revisions, 0 conflicts in 3 files
624 bytes uncompressed to 2116, 3.39X expansion
Running resolve to apply new work ...
Using :0 as graphical display
Verifying consistency of the RESYNC tree...
resolve: found 2 renames in pass 1
resolve: resolved 2 renames in pass 2
resolve: applied 4 files in pass 4
resolve: running consistency check, please wait...
=========================================================================
check: ``scripts/docgen'' writable but not checked out.
This means that a file has been modified without first doing a "bk edit".
        bk -R edit -g scripts/docgen
will fix the problem by changing the  file to checked out status.
Running "bk -r check -acf" will fix most problems automatically.
=========================================================================
=========================================================================
check: ``scripts/gen-all-syms'' writable but not checked out.
This means that a file has been modified without first doing a "bk edit".
        bk -R edit -g scripts/gen-all-syms
will fix the problem by changing the  file to checked out status.
Running "bk -r check -acf" will fix most problems automatically.
=========================================================================
=========================================================================
check: ``scripts/kernel-doc'' writable but not checked out.
This means that a file has been modified without first doing a "bk edit".
        bk -R edit -g scripts/kernel-doc
will fix the problem by changing the  file to checked out status.
Running "bk -r check -acf" will fix most problems automatically.
=========================================================================
Check failed.  Resolve not completed.
SCCS/s.ChangeSet
include/asm-ppc/SCCS/s.ocp-dma.h
BitKeeper/etc/SCCS/s.gone
BitKeeper/deleted/SCCS/s..del-ocp.h~73a8dba61594f2
Your repository should be back to where it was before the resolve started.
We are running a consistency check to verify this.
=========================================================================
check: ``scripts/docgen'' writable but not checked out.
This means that a file has been modified without first doing a "bk edit".
        bk -R edit -g scripts/docgen
will fix the problem by changing the  file to checked out status.
Running "bk -r check -acf" will fix most problems automatically.
=========================================================================
=========================================================================
check: ``scripts/gen-all-syms'' writable but not checked out.
This means that a file has been modified without first doing a "bk edit".
        bk -R edit -g scripts/gen-all-syms
will fix the problem by changing the  file to checked out status.
Running "bk -r check -acf" will fix most problems automatically.
=========================================================================
=========================================================================
check: ``scripts/kernel-doc'' writable but not checked out.
This means that a file has been modified without first doing a "bk edit".
        bk -R edit -g scripts/kernel-doc
will fix the problem by changing the  file to checked out status.
Running "bk -r check -acf" will fix most problems automatically.
=========================================================================
Check FAILED, contact BitMover.
resolve: RESYNC directory left intact.
====================================================
[acurtis@ws01 linuxppc_2_4_devel]$ bk -r check -acf
[acurtis@ws01 linuxppc_2_4_devel]$ bk pull
Entire repository is locked by:
        RESYNC directory.
ERROR-Unable to lock repository for update.

--
All things come to those who wait. Some of us just have to wait a little
longer...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
