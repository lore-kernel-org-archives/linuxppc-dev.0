Message-ID: <3BD8E662.5090104@mvista.com>
Date: Fri, 26 Oct 2001 00:28:18 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Hzzttbb@aol.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8260 Interrupt Request
References: <15f.2e06c8f.2909f644@aol.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hzzttbb@aol.com wrote:


> The 8260 User's manual says that IRQ1 is interrupt number 19,

That's the correct number to use.  Have you configured the rest of the
interrupt controller properly?  You need to at least configure SIEXR
for level/edge and SIUMCR to enable the IRQ1 pin.  Of course, this means
you can't enable external snooping due to pin multiplexing, so I hope
that's OK in your system design.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
