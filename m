From: "Chris Backas" <cbackas@rcn.com>
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Date: Wed, 20 Dec 2000 09:43:08 -0500 (EST)
Reply-To: "Chris Backas" <cbackas@bigfoot.com>
In-Reply-To: <20001220081857.A12174@missioncriticallinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: 2.2.18 and Dual G4
Message-Id: <E148kwY-0006Gl-00@smtp01.mrf.mail.rcn.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all,

I got kernel 2.2.18 from kernel.org yesterday, and built it as an SMP kernel on my Dual G4 450 machine.  This is the first Linux kernel I've run in SMP 'mode'.  Both
processors are detected, and it seems to be using the both of them.  I've noticed a downside though; programs seem to coredump out of the blue.  Mozilla 0.6 which
hadn't crashed since I installed it a week ago suddenly core dumps every hour or so.  The GNOME Panel dies periodically now, and the X Server once core dumped.

My question is, are these weird core dumps due to flakey SMP support for the Dual G4 in the kernel, or are these bugs in these programs that don't show up on a
Uni-Processor machine/kernel?

I'm not sure whether I should be reporting these crashes or not ;)

Thanks!
Chris Backas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
