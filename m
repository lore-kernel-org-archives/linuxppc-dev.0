Message-Id: <9907082101.AA30380@marc.watson.ibm.com>
To: Nicholas Coult <coult@ima.umn.edu>
Cc: David DeHaven <daved@trestle.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: HINT for LinuxPPC 
In-Reply-To: Message from Nicholas Coult <coult@ima.umn.edu>
   of "Thu, 08 Jul 1999 10:51:20 CDT." <Pine.LNX.4.10.9907081049550.6723-100000@pc19.ima.umn.edu>
Date: Thu, 08 Jul 1999 17:01:52 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Nicholas Coult writes:

Nicholas> Yes, I ran the Hint benchmark on my LinuxPPC machine.  My hint benchmark
Nicholas> page compares the results to a PII/300 running Linux:

Nicholas> http://www.ima.umn.edu/~coult/hint.html

	egcs-1.1.2 does not actually know about the PPC750, so -mcpu=750
did not actually help.  gcc-2.95 knows about PPC750 scheduling, makes
better use of indexed addressing, and utilizes the CTR register for loops
which should improve performance.  Other PowerPC improvement are coming
down the pike as soon as they can be cleaned up and added to GCC.

	Also, once the new p2 backend contributed to GCC by Cygnus is
installed and stable, that should provide a better test of PII
performance. 

David

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
