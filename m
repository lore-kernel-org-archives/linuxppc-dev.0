Message-ID: <3A31306A.8E8A900A@mvista.com>
Date: Fri, 08 Dec 2000 14:03:06 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Brian Ford <ford@vss.fsi.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 66 Mhz bus clock for EST8260?
References: <Pine.GSO.4.21.0012081225350.24199-100000@eos>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian Ford wrote:

> .... I have made a few corrections to the
> bootrom so the decrementer frequency is set correctly from the user
> dip switches in addition to setting the core, cpm, and bus speeds.

You are going to have to reprogram the memory controller timing.......

> Has anyone had any luck with the 66 Mhz bus clock?

Yes, on boards with processor/memory interface properly initialized
to run at that speed.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
