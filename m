Date: Mon, 1 Mar 1999 10:18:36 +1100
Message-Id: <199902282318.KAA01501@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: costabel@wanadoo.fr
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <36D6E58B.947AFE39@wanadoo.fr> (message from Martin Costabel on
	Fri, 26 Feb 1999 19:18:51 +0100)
Subject: Re: 2.2.2 compilation errors
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <XFMail.990226173323.gdt@linuxppc.org> <36D6E58B.947AFE39@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Martin Costabel <costabel@wanadoo.fr> wrote:

> I am of course sorry about this, but I have an excuse. What I wrote
> comes directly from the source. I quote:
[snip]
> /*
>  * SMP- and interrupt-safe semaphores..
>  *
>  * (C) Copyright 1996 Linus Torvalds
>  * Adapted for PowerPC by Gary Thomas and Paul Mackerras
>  */

Since semaphore-helper.h consists of material taken from the old
semaphore.h, I just took the copyright notice from semaphore.h and put
it on the top of semaphore-helper.h.  I don't know whether there are
actually any lines of code written by Gary in semaphore-helper.h, but
I don't think that matters particularly.

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
