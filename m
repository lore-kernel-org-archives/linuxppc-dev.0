Message-ID: <3814641B.5A628170@netx4.com>
Date: Mon, 25 Oct 1999 10:07:23 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Mark S. Mathews" <mark@absoval.com>
CC: Dan Malek <dan@penguin.netx4.com>,
        "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC8xx updates to 2.2.13
References: <Pine.LNX.3.96.991025005407.16660D-100000@tristar.cc.absoval.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark S. Mathews wrote:
> 
> Hey Dan,
> 
> We just got done getting the 2.2.13 running on the RPX-lite.  We had to
> add CONFIG_ENET_SCC2 to its config to make it work.  Thanks for the
> update!

You are welcome....but didn't 'make config' ask you which SCC
to use for the Ethernet?  You really shouldn't edit .config by
hand, as there are other files updated during the 'make config'
procedure.


> BTW: have you compiled any of these with CONFIG_MODULES turned on? 

Yes, and......

 We've
> tried with a couple of different kernels and generally get syntax errors


...I know.  I just haven't kept this up to date as I don't use
it all of the time.  I guess I will from now on.....


> Oh well, we'll just go back to a static kernel and work from there, no big
> deal.

Which is usually what I use in an embedded environment as it requires
less file system space and structure.  That is why I don't get
around to keeping the modules up to date as often as I should.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
