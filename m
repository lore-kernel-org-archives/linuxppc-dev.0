Message-ID: <XFMail.990305100624.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <9903050401.AA41152@marc.watson.ibm.com>
Date: Fri, 05 Mar 1999 10:06:24 -0000 (GMT)
From: Gary Thomas <gdt@linuxppc.org>
To: David Edelsohn <dje@watson.ibm.com>
Subject: Re: Problem with egcs and denormalized constants?
Cc: egcs@egcs.cygnus.com, linuxppc-dev@lists.linuxppc.org, sbb@gnu.org,
        kbhend@business.wm.edu, Randy Gobbel <gobbel@andrew.cmu.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 05-Mar-99 David Edelsohn wrote:
> 
>>>>>> Randy Gobbel writes:
> 
> Randy> I've been poking around in binutils a bit, and it looks to me like the
> Randy> badness is actually in gas.  Somewhere in expr.c is my current best
> Randy> guess.  As far as I can tell, gas doesn't actually call glibc to
> Randy> translate numbers, it has its own hairy platform-independent stuff for
> Randy> that.
> 
>       Has anyone created a small, self-contained testcase and reported
> it as a bug to binutils?
> 
> David
> 

I'm looking into it.  Note: it was only in the last few hours that this
problem with GAS/BINUTILS/??? became known.


------------------------------------------------------------------------
Gary Thomas                              |
email: gdt@linuxppc.org                  | "Fine wine is a necessity of
   ... opinions expressed here are mine  |        life for me"
       and no one else would claim them! |
                                         |      Thomas Jefferson
------------------------------------------------------------------------



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
