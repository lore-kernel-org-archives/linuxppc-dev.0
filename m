Message-Id: <200110142053.f9EKq3Y43599@aslan.scsiguy.com>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: now random kernel panics with aic7xxx driver 6.2.4 in kernel 2.4.12 
In-Reply-To: Your message of "Sun, 14 Oct 2001 09:17:11 EDT."
             <20011014131455.VGFQ17332.tomts11-srv.bellnexxia.net@there>
Date: Sun, 14 Oct 2001 14:52:03 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Hi Justin,
>
>Well, the idea of passing tag_info to the aic7xxx did help me boot but now
>I am getting random kernel panics.  So I upgraded to your latest 6.2.4
>with Ben's 2.4.12 and overnight when no activity was present, I got a
>panic.

It would be interesting to know what type of panics you saw prior
to 6.2.4.  It might help me track down where this problem began.

>Would you please take a look at the log and let me know if there is
>anything that jumps out at you?

The card seems to be loosing some of its resources.  I can't say
why yet.  I think it may be a regression in some of the abort
code in the kernel.  Could you try running with AHC_DEBUG_SEQUENCER
enabled?  You can just #define this to 1 in aic7xxx.c.

--
Justin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
