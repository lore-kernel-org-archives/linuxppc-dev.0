Date: Tue, 8 Jan 2002 09:59:56 -0500 (EST)
From: Jack Howarth <howarth@bromo.med.uc.edu>
Message-Id: <200201081459.JAA51702@bromo.msbb.uc.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: guppi3
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,
   Has anyone on YDL or SuSe ppclinux successfully built
guppi3 for use with gnumeric 1.0? We are finding that
there are apparent ppc specific crashes in guppi-gnumeric
as well as the guppi demo program. It looks to be difficult
to debug because the crash occurs in a library. I've tried
the obvious stuff of making sure we compile with -fsigned-char
but that didn't help. Just curious if this problem is specific
to Debian ppc sid at the moment or if other ppclinux distros
exhibit the same problem.
                 Jack
ps You can crash guppi on debian ppc sid by running gnumeric 1.0
, creating some two columns and three rows of data, selecting
these cells and clicking on the graph icon in the gnumeric tool
bar. On debian ppc sid, this results in a crash in guppi-gnumeric.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
