Date: Tue, 18 Jul 2000 15:40:55 -0500 (CDT)
From: Nathan Ingersoll <ningerso@d.umn.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Malloc bug?
Message-ID: <Pine.SO4.4.02.10007181457570.7001-100000@ub.d.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've been working on a GTK program for a while now, and I've been
experiencing segfaults within malloc. I was under the impression that
malloc should always return successfully (at least that's what the man
page says). Any ideas what may be causing this? I don't know if this has
anything to do with it, but the kernel I was using generated lots of
vm_do_try_free_pages failed error logs but not necessarily during program
execution.

---------------------------------------------------------------------------
|   Nathan Ingersoll             |   Computer Science/Mathematics         |
|   mailto: ningerso@d.umn.edu   |   University of Minnesota-Duluth       |
|   http://umn.edu/~ningerso     |   http://www.d.umn.edu                 |
---------------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
