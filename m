Message-ID: <3BD0E1BD.7927133@mvista.com>
Date: Fri, 19 Oct 2001 22:30:21 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Neil Wilson <NWILSON@Airspan.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Sandpoint X3 + network
References: <E69FF45ADA3BD511A25900047623CC4F12AB2E@jupiter>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Neil Wilson wrote:

> Whilst I am trying to look at this problem I was wondering if anyone else
> has seen similar or even better knows why & has a cure.

I have seen the problem for all too long and don't yet have a cure.
When speaking to folks at Motorola, it appears they are having more
success than I when the Sandpoint X3 is configured for legacy X2 mode.
If you can determine how to do that successfully (I found it easier to
use the default X3 mode than figure out the switches :-), build a kernel
for the X2 and see how it works.

Due to the pipeline differences in the 7450, I suspect there are some
sync's or eieio's missing, but I haven't had the time to finish all
of the 7450 work.

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
