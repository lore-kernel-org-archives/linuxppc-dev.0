Date: Thu, 17 Dec 1998 13:46:00 -0500 (EST)
From: "Mark S. Mathews" <mark@absoval.com>
To: Corey Minyard <minyard@acm.org>
cc: linuxppc-dev@lists.linuxppc.org, Cort Dougan <cort@persephone.cs.nmt.edu>
Subject: Re: Restructure of arch/ppc/kernel and include/asm-ppc, part 2
In-Reply-To: <m2ww3sd422.fsf@wf-rch.cirr.com>
Message-ID: <Pine.LNX.3.96.981217133832.9446E-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi Corey,

Just a suggestion here.

>   * Lots of CONFIG_8xx still occur.  I'm not sure what to do for these,
>     it's hard to tell exactly what is 8xx specific and MBX specific.
>     Are all MBX cards 8xx based?  I'd assume so, from the code.  And
>     I doubt we are going to be able to get rid of these.

Would it be possible to keep in mind that the MBX is _not_ the only board
that uses the MPC8xx.  We're doing some work here with two different
boards that use MPC8xx processors, but are definitely _not_ MBX boards.
Perhaps have separate config options for the 8xx processor and the board
design.


i.e.
CONFIG_8xx
CONFIG_MBX  

Thanks,
Mark 


Mark S. Mathews

AbsoluteValue Software     Web:    http://www.absoval.com
P.O. Box 941149            e-mail: mark@absoval.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
