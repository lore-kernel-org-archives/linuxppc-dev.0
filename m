Date: Mon, 25 Oct 1999 23:42:38 -0500 (CDT)
From: Kumar Gala <kumar@chaos.ph.utexas.edu>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: question about altivec registers
In-Reply-To: <199910252051.NAA07105@sade.ddi.com>
Message-ID: <Pine.LNX.4.10.9910252336320.2381-100000@chaos.ph.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The linux kernel as is will not effect the AltiVec registers in any way.
However, there is a minor change to the kernel that will be required.  You
will need to enable the MSR VEC bit (bit 6 in the MSR) to tell the
processor that the AltiVec Unit is available (this is similar to the MSR
FP bit).  If the bit is not set the processor will generate an AltIVec
Unavailable exception which will be trapped (incorrectly) as an unknown
0xf00 exception

the 0xf00 exception is for the performance monitors
and 0xf20 in the AltiVec unavailable exception.

All if these details are documented in the AltiVec Programming Environ
Manual (available from the Motorola Website).  

If you need any help getting a simple kernel up and running for running
single altiVec enabled processes let me know.

- kumar gala


ignorance is bliss.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
