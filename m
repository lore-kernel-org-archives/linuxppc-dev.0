Message-ID: <3A6CDC43.A18641DC@mvista.com>
Date: Mon, 22 Jan 2001 20:20:03 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: frowand@mvista.com
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
References: <3A68F7A0.693639F1@mvista.com> <3A6CDA97.A9C3FFE2@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Frank Rowand wrote:


> ....The only "context_overflow" I
> find is mmu_context_overflow() in arch/ppc/mm/init.c.  You obviously
> aren't talking about the 8xx version of this function.

That's the one.  As part of the 4xx merge I made the 8xx work as
well, so there is now only this one function for all PowerPC ports.

> This is the code we are talking about, correct?  The reason I'm
> confused is that I was being literal in my reading of "current->mm"
> as opposed to "tsk->mm".

The code you posted looks pretty old.  This function has more guts
to it now, including a 'set_context' of 'current->mm', the source
of the bug we are discussing.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
