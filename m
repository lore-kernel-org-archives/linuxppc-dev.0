Message-ID: <3ED4998F.8010108@embeddededge.com>
Date: Wed, 28 May 2003 07:12:15 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: Seb James <s.james@magtech.co.uk>, rtai@rtai.org,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: timebase interrupts on an mpc8xx
References: <20030527200329.D7EEFC6162@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Wolfgang Denk wrote:

> I disagree. I think Wolfgang Grandegger  is  right;

Sorry, I didn't see any other replies to this message.

> ...  it's  caused  by
> reading  sivec without a pending interrupt.

What?  That had been updated a long time ago, is it missing again?

> BTW: it seems the interrupt handling code becomes worse. I guess  you
> don't  care  about  this  any  more?

I care alot.  There have been changes I have totally disagreed with,
but they were checked in anyway.  Not much I can do about it but hope
I get time to fix it in the future.

> ... At least it was working when you
> did... Now the 2_4_devel code is  crap.

I agree, but it wasn't my choice.  People that don't even use the code
seemed to this was the way to go..........


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
