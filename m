Date: Thu, 29 Mar 2001 20:16:35 -0600 (CST)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Tom Gall <gall@rochcivictheatre.org>
Cc: Kaoru Fukui <k_fukui@highway.ne.jp>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Success kernel-243pre8-SMP(patch)(Re: spin_lock problem in recent  kernel
In-Reply-To: <3AC3ECE5.1B65198F@rochcivictheatre.org>
Message-ID: <Pine.A41.3.96LJ1.1b7.1010329201445.24912C-100000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 29 Mar 2001, Tom Gall wrote:

> Hi Kaoru,
>
>   I tried your patch on my 2 way Power3 Model 270 RS/6000 just before I
> left but didn't have enough time to write this note until now.
>
>   Your patch amazingly booted my box quite a bit further... it still
> dies for me but in a new and interesting way, that doesn't appear to be
> related to the page_table_lock. (Token Ring and shared memory
> ...sigh...)
>
>   The part that REALLY REALLY bothers me tho is why does this patch
> work? I *HAVE* CONFIG_SMP on... least I think I do... there's two
> penguins on my screen ... two processors grinding away ... that's
> CONFIG_SMP right??? I'm not losing my mind am I?
>
>   So assuming that CONFIG_SMP is on, this patch shouldn't yeild anything
> different what so ever from a codegen perspective with or without the
> patch for an SMP kernel build. It doesn't make sense.

He is just commenting out those lines.  They are not "#ifdef CONFIG_SMP".


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
