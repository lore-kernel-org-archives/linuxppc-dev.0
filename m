Message-ID: <388CB96A.6EC5D7A6@netx4.com>
Date: Mon, 24 Jan 2000 15:43:22 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Ralf HECKHAUSEN <RHeckhau@frequentis.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Device driver for SPI
References: <s88c20b1.048@mail.frequentis.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralf HECKHAUSEN wrote:
>
> Did anyone implement a device driver for SPI which we could use as a starting point?

I have one, but the trouble is most 8xx processors need the
microcode patches to relocate the SPI away from things like
Ethernet.  I don't have that working correctly yet, as it also
requires the SPI driver to know about the relocation.

The other question is the application interface to the SPI.
Most SPI implementations have multiple selects based upon some
general purpose register, how do you manage the full duplex
nature of the interface and so on....


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
