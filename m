Message-ID: <3CE087F0.3040907@embeddededge.com>
Date: Mon, 13 May 2002 23:43:44 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Conn Clark <clark@esteem.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Overclocking the Motorola 860 family
References: <3CE0464A.C94BE21@esteem.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Conn Clark wrote:


> 	Has anybody overclocked a MPC860 or a MPC850?

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
