Date: Mon, 16 Apr 2001 14:53:32 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org, Samuel Rydh <samuel@ibrium.se>
Subject: Re: [PATCH] gettimeofday stability
In-Reply-To: <20010416132503.19175@smtp.wanadoo.fr>
Message-ID: <Pine.HPX.4.10.10104161438420.1891-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 16 Apr 2001, Benjamin Herrenschmidt wrote:

> >
> >Yes, currently the decrementer interrupt assumes that it is the only user.
> >This is quite simple however, use a while() {} instead of a do {}
> >while() in the loop that catches up on pending decrementer interrupts.
>
> Paulus already pushed such a patch to the bk repository (last week I
> think). He rewrote the pmac lost_interrupts stuff to use the DEC to cause
> interrupts.

Fine. I have no problem with using the decrementer as a "please interrupt
me asap" request... And it is nice to see some of the bloat of unmasking
interrupts go away with this (not that this affects me much though, my
sources were patched).

I still object strongly to anything touching the timebase, however.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
