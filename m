From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: <linuxppc-dev@lists.linuxppc.org>, Samuel Rydh <samuel@ibrium.se>
Subject: Re: [PATCH] gettimeofday stability
Date: Mon, 16 Apr 2001 15:25:03 +0200
Message-Id: <20010416132503.19175@smtp.wanadoo.fr>
In-Reply-To: <Pine.HPX.4.10.10104161339130.1891-100000@gra-ux1.iram.es>
References: <Pine.HPX.4.10.10104161339130.1891-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Yes, currently the decrementer interrupt assumes that it is the only user.
>This is quite simple however, use a while() {} instead of a do {}
>while() in the loop that catches up on pending decrementer interrupts.

Paulus already pushed such a patch to the bk repository (last week I
think). He rewrote the pmac lost_interrupts stuff to use the DEC to cause
interrupts.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
