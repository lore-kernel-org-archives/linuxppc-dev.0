Message-ID: <3981A326.39228806@embeddededge.com>
Date: Fri, 28 Jul 2000 11:13:42 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Ralph Blach <rcblach@raleigh.ibm.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: error in assumptions in the handling of interrupts.
References: <398178CF.6AEAF91E@raleigh.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralph Blach wrote:

> This will NOT work because for Level interrupts, the ISR will cannot be
> reset until
> the interrupting source is cleared.

It works for Level interrupts on the 8xx and 8260.......

> The ack to reset the ISR for interrupt must go in the
>
> ppcxxx_aic_enable

So, put it there.  All of these functions should be unique to
the 405GP interrupt controller.  You are free to implement this
as you wish.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
