To: Cort Dougan <cort@persephone.cs.nmt.edu>
Cc: Troy Benjegerdes <hozer@drgw.net>, Dan Malek <dmalek@jlc.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: PReP RTC vs Decrementer accuracy...
References: <Pine.LNX.3.96.981209224800.20040A-100000@persephone.cs.nmt.edu>
Reply-To: minyard@acm.org
From: Corey Minyard <minyard@acm.org>
Date: 10 Dec 1998 10:00:39 -0600
In-Reply-To: Cort Dougan's message of Wed, 9 Dec 1998 22:48:29 -0700 (MST)
Message-ID: <m2af0wyok8.fsf@wf-rch.cirr.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Cort Dougan <cort@persephone.cs.nmt.edu> writes:

> Great!  That's exactly what we need.
> 
> }I would like to make things in the arch/ppc/kernel directory more
> }"polymorphic", meaning I'd like to have a table of function pointers
> }that point to the various procedures to handle things, much like a
> 
> Probably me.
> 
> }Cort, who would I contact for more info on this?
> 

Ok.  I'm going to start doing this work.  I'll reference the m68k code
to see how that works, and I'm going to spend a few days working on it
at work.  Keep in mind that this is going to touch pretty much
everything, if you have patches they will need to be redone.  I assume
if the quality is good this will go into the standard release?

-- 
Corey Minyard               Internet:  minyard@acm.org
  Work: minyard@nortel.ca       UUCP:  minyard@wf-rch.cirr.com

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
