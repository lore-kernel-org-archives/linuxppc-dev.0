Date: Sat, 30 Mar 02 21:58:33 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0203310558.AA21170@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: linuxppc_2_4_alt started
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Linux/PPC developers and users,

Having had no success in getting my work accepted into linuxppc_2_4_devel, I
have decided to start my own alternative tree which I have called
linuxppc_2_4_alt. The BK URL for anonymous access (should work, but I couldn't
really test access from outside) is:

bk://helium.Harhan.ORG:5000

This tree has linuxppc_2_4_devel as its BK parent. I have had this BK tree for
a while but I've just now made it publicly accessible. (The patches in my CVS
were generated from this tree with bk export -tpatch between the last cset
pulled from 2_4_devel and the very top cset.)

I have set it up to post to linuxppc-commit@source.mvista.com on incoming just
like the trees at BitMover. This way y'all will now what I'm doing in there and
see if you like it. If enough people like it maybe we'll take over. Anyone who
likes this tree, wants to do development in it, and wants read/write access
should contact me.

Have fun!

MS

P.S. It's on a 33.6 Kbps modem connection, so it's going to be *really* slow.
Any volunteers to host it for me on a machine with a better net connection? :-)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
