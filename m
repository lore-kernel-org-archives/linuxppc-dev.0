Message-ID: <37E2C3EE.A935D240@netx4.com>
Date: Fri, 17 Sep 1999 18:42:54 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Cleanup thought.
References: <199909172225.AAA28226@denx.local.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:


> Sorry. Re-reading what I posted this sounds a lot more negative

That startup code is intended to work for every 8xx processor.
All you need to do is set up the memory controller and get these
bits into memory (if the controller isn't set up, you can't get
them there anyway).

Then decide how you want to build the board information structure,
which can be hard coded if you wish.  It's all downhill from there.


> 
> Oops! I must have missed this (I  even  can't  find  it  here  in  my
> archives). Can you please re-post a pointer? TIA!

ftp://ftp.ppc.kernel.org/pub/linuxppc/embedded/fadsrom.tgz


> Maybe I/we can do a bit more than just talking?

I have your SMC console stuff underway, what else do you want
to add?  Write it, test it, send it.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
