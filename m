Message-ID: <3BC48D49.6FB5279@mvista.com>
Date: Wed, 10 Oct 2001 14:02:49 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Kevin Fry <kevin@carts.com>
Cc: linuxppc emb3dd3d list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8260 Communications Proccessor overload??
References: <3BC3BC07.D6158215@carts.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kevin Fry wrote:
>
>    Has anyone ever run all 3 FCC ports at the same time with a
> 100Mbit link?

Yeah.....

> ....  I think I'm seeing the Communications Processor get
> overloaded, but Motorola claims there is no problem.

What clock speeds are you running?  Are they full or half duplex
connections?



> the Ethernet PHY (AM79C874) indicates no errors, but the MAC is
> reporting
> CRC errors.

Hmmm...Do you ever see any buffering problems on the Linux driver
side, like the CPU can't keep up with the data?

> .... I have captured the MAC --> PHY transfers on a logic
> analyzer
> and am decoding them at present (I hate computing a CRC-32 by hand).  I
> was
> hoping someone else has experience relative to this situation.

I have seen some noise problems with some boards between the MAC and
PHY.  Some crappy looking layouts worked great, some really pretty
ones had trouble :-).  I don't know if this would be represented as
a CRC error or something else.

Good Luck!  Keep us posted :-).


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
