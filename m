Message-ID: <3AF98CF5.8360A2C2@mvista.com>
Date: Wed, 09 May 2001 14:31:17 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Brian Kuschak <brian.kuschak@skystream.com>
Cc: "'Gabriel Paubert'" <paubert@iram.es>,
	Eli Chen <eli@routefree.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()
References: <B25E2E5A003CD311B61E00902778AF2A0204465E@SERVER1>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian Kuschak wrote:

> ... that's how I noticed the one-bit difference between bne and bne-.

That's the branch target hint due to the use of the '-' in the instruction.

> .... that lwarx r11,0,r31 shows up as lwarx r11,r0,r31.

That's because it really is a register field, with r0 handled as
a special case.

I've dumped out lots of your kernel image around atomic ops, and I
haven't seen anything wrong with the generated code.  That would be
too easy :-).



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
