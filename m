Message-ID: <XFMail.990430054951.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <199904300255.WAA16851@blastula.phys.columbia.edu>
Date: Fri, 30 Apr 1999 05:49:51 +0100 (BST)
From: Gary Thomas <gdt@linuxppc.org>
To: Zack Weinberg <zack@rabi.columbia.edu>
Subject: Re: PATCH: Fix 2 PPC/SYSV varargs problems
Cc: linuxppc-dev@lists.linuxppc.org, David Edelsohn <dje@watson.ibm.com>,
        meissner@cygnus.com, Richard Henderson <rth@cygnus.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 30-Apr-99 Zack Weinberg wrote:
> 
> On Thu, 29 Apr 1999 19:48:17 -0700, Richard Henderson wrote:
>>On Fri, Apr 30, 1999 at 02:09:09AM +0200, Franz Sirl wrote:
>>> 1. the varargs save area calculation bug, this is a hack and Richard ;-) 
>>> probably won't like it, but maybe it's good enough for egcs-1.2
>>
>>You're right -- I hate it.  You'll have made it so I can't build a
>>ppc cross compiler on my Alphas, and you'll have killed the compiler
>>for a ppc64-linux.
> 
> ObDumbQuestion: Is this a bug we really need to fix for 1.2?  It's
> been around for awhile and all the proposed solutions are either dirty
> kludges or too invasive.
> 

It's a serious problem that has caused trouble in the past.  Fixing it
would be very nice, indeed.

However, I provide a patch for the compiler that detects potential 
occurrances and print a warning.  At least it's not a slient killer.

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
