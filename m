Date: Sun, 28 Jan 2001 15:58:15 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: suspicious comment in mesh.c and mac53c94.c
Message-ID: <20010128155815.A21628@allspice.cs.swarthmore.edu>
References: <200101282017.MAA19462@mail.turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200101282017.MAA19462@mail.turbolinux.com>; from brad@turbolinux.com on Sun, Jan 28, 2001 at 08:25:07PM -0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Both of the SCSI drivers for which the complete SCSI lockup upon trying
to burn a CD in DAO mode have been reported have the following comment
at the top (that's mesh.c and mac53c94.c, BTW.)

/*
 * To do:
 * - handle aborts correctly
 * - retry arbitration if lost (unless higher levels do this for us)
 */

Does anyone here understand the implications of this?  Is it plausibly
related to the lockups?  Both drivers appear to have been written by
Paul Mackerras -- is he active on these lists these days, or should I
contact him directly?

-Daniel

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
