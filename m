Message-Id: <199902171250.HAA00182@darkstar.prodigy.com>
From: davidsen@prodigy.com (Bill Davidsen)
Date: Wed, 17 Feb 1999 07:50:25 -0500
In-Reply-To: <Pine.LNX.4.04.9902162012560.432-100000@narn.local.drgw.net> from hozer@drgw.net
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: [ppc-dev] Re: Restructuring Efforts
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Troy Benjegerdes <hozer@drgw.net> noted:

> ifdefs are evil ;) 
> OTOH, I don't know if I like a ton of 'if _machine' from a readability
> standpoint. I would like something similiar to the Alpha's and Corey
> Minyards rework with a structure for various machines with any code that
> would have been inside an #ifdef , switch(_machine) if _machine. 

Well, you can preserve readability if you are willing to put the
machine types in an enum and make use of "pointer to function
returning" arrays. So instead of doing something like init_mem() you
would use (*init_mem[_machine])() instead.

Another trick is to have a set if defines which you provide for each
machine type, and then call. Either of these provide easy extensibility
without ifdefs.

-- 
   -bill davidsen (davidsen@prodigy.com)
"The secret to procrastination is to put things off until the
 last possible moment - but no longer"  -me


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
