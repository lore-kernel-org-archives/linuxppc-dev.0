Message-Id: <199904300255.WAA16851@blastula.phys.columbia.edu>
To: Richard Henderson <rth@cygnus.com>
cc: meissner@cygnus.com, David Edelsohn <dje@watson.ibm.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: PATCH: Fix 2 PPC/SYSV varargs problems 
In-reply-to: Your message of "Thu, 29 Apr 1999 19:48:17 PDT."
             <19990429194817.B20300@cygnus.com>
Date: Thu, 29 Apr 1999 22:55:36 -0400
From: Zack Weinberg <zack@rabi.columbia.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 29 Apr 1999 19:48:17 -0700, Richard Henderson wrote:
>On Fri, Apr 30, 1999 at 02:09:09AM +0200, Franz Sirl wrote:
>> 1. the varargs save area calculation bug, this is a hack and Richard ;-) 
>> probably won't like it, but maybe it's good enough for egcs-1.2
>
>You're right -- I hate it.  You'll have made it so I can't build a
>ppc cross compiler on my Alphas, and you'll have killed the compiler
>for a ppc64-linux.

ObDumbQuestion: Is this a bug we really need to fix for 1.2?  It's
been around for awhile and all the proposed solutions are either dirty
kludges or too invasive.

zw

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
