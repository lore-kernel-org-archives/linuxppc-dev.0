Message-ID: <3ADB6E8B.4D6D7565@mvista.com>
Date: Mon, 16 Apr 2001 18:13:31 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: David Blythe <blythe@routefree.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 4xx tlbmiss renables interrupts while in kgdb
References: <3AD78DB3.6077A539@routefree.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Blythe wrote:
>
> The 4xx tlbmiss handler reenables interrupts while handling a page
> fault.

I have completely rewritten the 4xx TLB software, and this no
longer happens.  Please use the linuxppc_2_5 tree from the FSM Labs
BitKeeper tree.

> ...  Sometimes kgdb

Unfortunately, I'm not sure of the state of KGDB in this same
linuxppc_2_5 software.  You should be able to do things like
set breakpoints and examine memory, but some of the single stepping
may not work correctly (yet).


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
