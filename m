Message-ID: <37E14372.3A908C42@netx4.com>
Date: Thu, 16 Sep 1999 15:22:26 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Robert Lee <Robert_Lee@inter-tel.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Embedded Linux newbie, seeks advice
References: <072567EE.00613186.00@nsts.inter-tel.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Robert Lee wrote:


> We're exploring the possibility of doing an embedded Linux project, based on
> custom Motorola 750 PPC hardware.

Depending upon your product, there may be more suitable processor
selections.  One of the advantages of Motorola processors is their
standard PPC cores with integrated controllers that target specific
technology needs.


> 1. Can you recommend a PPC board suitable for initial software development, i.e.
> how to bootstrap, etc?  Brightstar Engineering advertises the "ipEngine-1".
> It's 823 based, but looks promising otherwise.

The 823 is a very different processor from the 750.  The folks
at Embedded Planet (www.embeddedplanet.com) have a wider selection
of Motorola embedded products.


> 2. Will designing to CHRP or PREP significantly cut porting time?


If you are using anything from the "IBM" family of processor, like
the 6xx or 7xx, it is pretty hard not to develop something close
to CHRP or PREP.  The 5xx, 8xx and 82xx embedded PPC family from
Motorola are different because of their integrated features.


> 3. Any gotcha's we should be especially aware of?

The bits are numbered correctly :-).  It's pretty hard to guess
without knowing what you are doing.  Some of us have been providing
support to some very powerful products using embedded PPC technology.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
