Message-ID: <39E294F4.E3FD24DB@mvista.com>
Date: Tue, 10 Oct 2000 00:03:00 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: clark@esteem.com
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hanging in the Delay loop
References: <1.5.4.32.20001010001658.006ba8f4@pop.esteem.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


clark@esteem.com wrote:

>         Does anybody know why a machine would hang in the Calibration Delay
> Loop just before it spits out the BogoMIPs rating.

This happens if the decrementer isn't running.  Is this an 8xx or 8260?
They both have the ability to disable the timebase, which includes the
decrementer (other processors don't do this).  An ICE often does more
than you know, which could be an unexpected register setting that causes
this to happen.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
