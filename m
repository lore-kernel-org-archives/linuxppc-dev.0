Date: Fri, 14 Jan 2000 14:51:00 -0600
From: Grant Erickson <grant@lcse.umn.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: *_find_end_of_memory Mach Dep?
Message-ID: <Pine.SGI.4.10.10001141448520.254646-100000@brule.borg.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Instead of having a mess of ifdef's and such in MMU_init for {apus, pmac,
m8xx, oak, chrp, etc}_find_end_of_memory, is there any compelling reason
not to make a ppc_md machine dependency entry for these?

If no one is in disagreement, I'd like to put a patch together for it.

Regards,

Grant


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
