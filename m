Message-Id: <36CACDEA.9F546221@pop.agri.ch>
Date: Wed, 17 Feb 1999 15:10:53 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Mime-Version: 1.0
To: Gary Thomas <gdt@linuxppc.org>
Cc: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: back to gcc under pre-R5
References: <XFMail.990217133431.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gary Thomas wrote:
> 
> On 17-Feb-99 Andreas Tobler wrote:
> >
> > Hello,
> >
> > is it possible to get back to gcc under pre-R5? If so. where can I get the (S)RPMS?
> >
> > And how much do it affect when I build the libstdc++ with fno-vtable-thunks?
> > Do I have to rebuild the whole system, since the new glibc needs vtables?
> > It's only because egcs has bug which is for my subject killing.
> >
> 
> There are no current RPMs for GCC to my knowledge.  The last ones I made nearly
> two years ago and gave up on shortly thereafter because EGCS was much superior.
> 

I found a rpm with gcc-2.8.0-1.src.rpm, maybe??
I think it was on Linuxppc mirror in uk in the 'linuxppc-delete-me' folder.

> What bug in EGCS is so terrible that you are considering this move?
> Which version of EGCS have you tried?

It's not quite a bug, it's an optimization which is not implemented yet. The
vtable syndrom!
I tried egcs-1.0.3 under R4 there it works.
Also tried egcs-1.1.1.c on pre-R5 no success.
Built egcs -1.1.1ca by myself with vtable thunks off, doesn't work because
glibc needs vtable thunks. (Interpretation from my side when Franz Sirl
suggested to rebuild the glibc) 

The whole story happens when I build JX (http://www.cco.caltech.edu/~jafl/jx/jx2.html)

CC get's a core dump in a few points. 

I'd like to build this Code Crusader out of personal interest, maybe we can
share my experiences with others when they find to JX? 
> 
> There will be EGCS-1.1.2 in the very near future which has many PowerPC problems
> fixed, perhaps you can wait.

I could wait if this thing would be fixed, but as Mike Stump said, it wouldn't
be fixed in the near future.

Thanks
Andreas
-- 
------------------
| Andreas Tobler								
| CH-8004 Zuerich	
| E-mail: toa@pop.agri.ch		
------------------------------------------

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
