Message-ID: <39819D52.DAC049B4@embeddededge.com>
Date: Fri, 28 Jul 2000 10:48:50 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: daniel.marmier@lightning.ch
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Altivec on 2.4.xx?
References: <3980DEAF.ACFB0C43@embeddededge.com> <39813520.673CF3E0@lightning.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Daniel Marmier wrote:

> If my understanding of Motorola's docs is correct, the only MPC8xx
> exception that has a valid DSISR setting is the implementation
> specific data TLB error interrupt

This is a PowerPC architecture definition. It isn't unique to the MPC8xx,
as I am obviously using a 7400 with Altivec here.

Having the common page fault handler is a good thing, we just have
to make sure we extract the information properly from the appropriate
register.

I thought there was more (than none :-) development happening with
Altivec on PowerPC Linux.  Maybe tiny test applications will work,
but my MPEG-2 decoder won't.

I'm just adding one instruction to the Instruction Exception handler
to mask the bit, so I will just check it in.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
