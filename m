Message-ID: <3B80187C.4743F780@mvista.com>
Date: Sun, 19 Aug 2001 15:50:20 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: John Francis <johnfrancsis@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Using IDMA1 ( or IDMA2 ) on 860
References: <20010819190624.51260.qmail@web20105.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John Francis wrote:


> ..... on hardware
> side I do see the DREQ line going low and I have
> verified that RCCR register for CPM is set correctly
> to level trigger the interrupt.
>
> Any ideas on why IDMA1 interrupt handler is not
> getting invoked?

The DREQ has nothing to do with generating an interrupt, it
is a data transfer handshake signal.  The configuration of
this pin is determined by the system design, connection to
the peripheral for data transfer and the configuration of
the memory controller.

The configuration of the IDMA channel, including the buffer
descriptors, will determine how and when the CPM interrupt
will occur.

	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
