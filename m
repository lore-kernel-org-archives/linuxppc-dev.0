Message-ID: <3674B40A.8B152375@jlc.net>
Date: Mon, 14 Dec 1998 01:45:30 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: PReP RTC vs Decrementer accuracy...
References: <Pine.HPP.3.96.981213172728.17076D-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:

> Yes, the problem is the good old 601. The TB uses different register
> numbers (it's called the RTC, split into RTCU and RTCL like TBU and TBL).

I'll take a look at this.  I don't think it is a problem.  I only use the
lower part to count 10 millisecond timer interrupts, and as long
as I know where it wraps around, it should be fine.  As long as
there are timebase compare registers that interrupt when a match
occurs on either upper or lower, we are all set.  Different register
numbers are OK because all get/set operations are implementation
defined functions.


    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
