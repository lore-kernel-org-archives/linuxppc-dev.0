Message-ID: <38544B23.24E35D4B@netx4.com>
Date: Sun, 12 Dec 1999 20:25:55 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: FEC ERROR 41200000 on CLLF-860T
References: <19991212235604.AF1D4F4E5@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:


> Marcus is right;


My apologies.


> ....... Can anyone elaborate or provide pointers to more
> information on the FEC throughput issue? Is there really a hardware problem in
> the CPU, or is it a board specific issue?

The FEC must transfer data at the Ethernet rate because it doesn't
have enough FIFO for an entire packet (it has some clever
optimizations for collision and retrasmit).  The SDMA is always
to system memory, so if the buffers are there, the bits will fly.

It all comes down to what your application is doing, and if
the PPC core has enough computes to provide buffers at the
rate you require.  I am sure I can write a demo application
that will run at the maximum rate, and maybe it will represent
what you are trying to accomplish......I am working on it.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
