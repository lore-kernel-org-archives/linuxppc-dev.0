Message-Id: <9903050401.AA41152@marc.watson.ibm.com>
To: Randy Gobbel <gobbel@andrew.cmu.edu>
Cc: kbhend@business.wm.edu, gdt@linuxppc.org, sbb@gnu.org,
        linuxppc-dev@lists.linuxppc.org, egcs@egcs.cygnus.com
Subject: Re: Problem with egcs and denormalized constants? 
In-Reply-To: Message from Randy Gobbel <gobbel@andrew.cmu.edu>
   of "Thu, 04 Mar 1999 21:42:14 EST." <36DF4486.6E098903@andrew.cmu.edu>
Date: Thu, 04 Mar 1999 23:01:56 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Randy Gobbel writes:

Randy> I've been poking around in binutils a bit, and it looks to me like the
Randy> badness is actually in gas.  Somewhere in expr.c is my current best
Randy> guess.  As far as I can tell, gas doesn't actually call glibc to
Randy> translate numbers, it has its own hairy platform-independent stuff for
Randy> that.

	Has anyone created a small, self-contained testcase and reported
it as a bug to binutils?

David

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
