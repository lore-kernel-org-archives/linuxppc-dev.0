Subject: ssh on ppc 405gp?
From: Dave Strout <dstrout@linuxfoundary.com>
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Date: 19 May 2003 15:01:00 -0400
Message-Id: <1053370861.9594.61.camel@dstrout.nsw.enterasys.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Has anybody succeeded in getting ssh to work on a 405GP machine?  I've
checked the archives, and seen a couple of reports of problems, but no
solutions.

I get the following error when trying to connect between a ppc machine
and an intel machine in either direction:

Received disconnect from 192.168.1.2: 2: Corrupted MAC on input.

If I ssh from the ppc to the ppc via 'localhost', it works.  That makes
me think that it's something to do with either byte ordering of
structure alignment, but I don't have any thoughts beyond that...  Any
suggestions on how to tackle this are welcome.

thanks,
dave.

--
Dave Strout

dstrout@linuxfoundary.com    301/869-0818(h)  240/731-2727(c)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
