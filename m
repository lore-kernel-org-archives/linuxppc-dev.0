From: John_McRoberts@Mitel.COM
Subject: Re: Overclocking the Motorola 860 family
To: Dan Malek <dan@embeddededge.com>
Cc: Conn Clark <clark@esteem.com>,
	linuxppc-embedded@lists.linuxppc.org,
	owner-linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF554482C7.24E65621-ON80256BB9.0034A5E8@mitel.com>
Date: Tue, 14 May 2002 10:39:06 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have run 80/40 parts at 100/50Mhz. There are however now available MPC862
parts which are rated at 100/50Mhz. When talking previously to Motorola
they were quite surprised when at that point we hadn't tried overclocking
the 80/40 part.

You do however have to play around with things like the SPI/I2C interfaces
to get the right clocking speeds.

One other thing pull ups on the interrupt lines have to be at about 1K
otherwise spurious interrupts can occur at 100Mhz.

regards,

John




                    Dan Malek <dan@embeddededge.com>
                    Sent by:                              To:     Conn Clark <clark@esteem.com>
                    owner-linuxppc-embedded@lists.li      cc:     linuxppc-embedded@lists.linuxppc.org
                    nuxppc.org                            Subject:     Re: Overclocking the Motorola 860 family


                    05/14/02 04:43 AM







Conn Clark wrote:


>          Has anybody overclocked a MPC860 or a MPC850?

I've tried cranking up the PLLs beyond the chip spec.  None of them
have ever worked.  I could only get 4 MHz steps, so I tried the 80 MHz
at 84MHz, which didn't work (including all UPM timing changes to ensure
memory was OK).  Maybe it would run at 81 or 82 MHz....

> .... Right now we run our 850 at
> 49.1MHz and I want to double it.

No way.  I've tried lots of different speed spec parts at higher than
rated values, none has ever worked for me.  It appears Motorola has a
pretty good screening process, and when they state 50 MHz it isn't likely
to run beyond that.  Even if one appears to work, I wouldn't expect a
product or volume manufacturing to be successful.


           -- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
