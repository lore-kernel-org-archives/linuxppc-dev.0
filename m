Message-ID: <36D6E58B.947AFE39@wanadoo.fr>
Date: Fri, 26 Feb 1999 19:18:51 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Gary Thomas <gdt@linuxppc.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.2 compilation errors
References: <XFMail.990226173323.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gary Thomas wrote:
> 
> On 26-Feb-99 Martin Costabel wrote:
> >
> > This bug was introduced deliberately by Linus.
> > It was fixed for ppc yesterday by Paul Mackerras and Gary Thomas.
> >
> 
> While I enjoy notoriety as much as the next guy, I must point out that I
> did not actively participate in this fix :-)

I am of course sorry about this, but I have an excuse. What I wrote
comes directly from the source. I quote:

root[225]#head include/asm-ppc/semaphore-helper.h 
#ifndef _PPC_SEMAPHORE_HELPER_H
#define _PPC_SEMAPHORE_HELPER_H

/*
 * SMP- and interrupt-safe semaphores..
 *
 * (C) Copyright 1996 Linus Torvalds
 * Adapted for PowerPC by Gary Thomas and Paul Mackerras
 */

--
Martin



> 
> ------------------------------------------------------------------------
> Gary Thomas                              |
> email: gdt@linuxppc.org                  | "Fine wine is a necessity of
>    ... opinions expressed here are mine  |        life for me"
>        and no one else would claim them! |
>                                          |      Thomas Jefferson
> ------------------------------------------------------------------------

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
