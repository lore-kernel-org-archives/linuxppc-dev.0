Message-ID: <XFMail.990217133431.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <36CA7AC0.F2F7596D@pop.agri.ch>
Date: Wed, 17 Feb 1999 13:34:31 -0000 (GMT)
From: Gary Thomas <gdt@linuxppc.org>
To: Andreas Tobler <toa@pop.agri.ch>
Subject: RE: back to gcc under pre-R5
Cc: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 17-Feb-99 Andreas Tobler wrote:
> 
> Hello,
> 
> is it possible to get back to gcc under pre-R5? If so. where can I get the (S)RPMS?
> 
> And how much do it affect when I build the libstdc++ with fno-vtable-thunks?
> Do I have to rebuild the whole system, since the new glibc needs vtables?
> It's only because egcs has bug which is for my subject killing.
> 

There are no current RPMs for GCC to my knowledge.  The last ones I made nearly
two years ago and gave up on shortly thereafter because EGCS was much superior.

What bug in EGCS is so terrible that you are considering this move?
Which version of EGCS have you tried?

There will be EGCS-1.1.2 in the very near future which has many PowerPC problems
fixed, perhaps you can wait.

------------------------------------------------------------------------
Gary Thomas                              |
email: gdt@linuxppc.org                  | "Fine wine is a necessity of
   ... opinions expressed here are mine  |        life for me"
       and no one else would claim them! |
                                         |      Thomas Jefferson
------------------------------------------------------------------------



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
