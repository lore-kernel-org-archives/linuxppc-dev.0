Date: Sat, 15 May 1999 10:13:34 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: VGER kernels
Message-ID: <Pine.LNX.4.05.9905151011150.651-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've noticed a few mails recently about problems compiling 2.3.x from
vger.  I think it should be pointed out that you most likely (Unless Cort
or Paul wishes to contradict me) don't want to be running 2.3.x on your
machine for day to day use.  It's the devel branch, and it subject to
crashing and other problems.  You will most likekly want (and I hope Cort
and/or Paul will keep up w/ the 2.2.x branch as well..) to run your cvs
updates as:
cvs update -dP -rlinux_2_2

So that you get the current stable version.

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
