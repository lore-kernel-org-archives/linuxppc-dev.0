Date: Wed, 10 Nov 1999 00:42:25 -0500
Message-Id: <199911100542.AAA08374@tiktok.cygnus.com>
From: Michael Meissner <meissner@cygnus.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Linux 2.2.13 on an original PowerStack-I
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have an original PowerStack-I (66 Mhz 603 with no cache) that has
been sitting idle since about January, and I thought I would turn it
into a web server.  I did the usual boot with my carefully preserved
FD_SETUP, base tools, build tools, FD_BOOT diskettes, and set up a R4
system, and tried to boot with the 2.2.13 kernel I'm running on my
PowerStack-II (a 'UTAH' 200 Mhz 604e, 512K Cache).  It seemed to fail
miserably looking for hda/hdb.  Is there a known patch to make the
older PowerStack-I boot?  I vaguelly recall having this problem except
reversed in the January time frame (standard kernel would boot on the
older machine but not boot on the newer machine, but there was a patch
available to make it boot on the new machine which broke the old
machine -- evidently that patch went into the tree).  Ideally, I could
run the same kernel on both machines, but I could live with different
kernels.

Thanks in advance.

-- 
Michael Meissner, Cygnus Solutions
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886
email: meissner@cygnus.com	phone: 978-486-9304	fax: 978-692-4482

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
