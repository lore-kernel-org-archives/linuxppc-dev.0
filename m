Message-ID: <39788564.5F9E2282@embeddededge.com>
Date: Fri, 21 Jul 2000 13:16:20 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Paolo Scaffardi <arsenio@tin.it>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: What kernel for a MPC823FADS and PCMCIA?
References: <001101bff2ec$b3efbce0$640a0a0a@server>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paolo Scaffardi wrote:
>
> I have a MPC823FADS and i want to make a simple Linux box with ETHERNET and
> PCMCIA support.

OK.

> What is the right kernel to use and patches to make the PCMCIA working on
> the board?

I don't know of any kernel ready to run for this.  You may want to
scan the mailing list archives looking for some patches for the FADS
boards.


> I'm very confused... i probably had to buy another board... MVista doesn't
> support my board... why?!?!?!

The FADS boards have always been a challenge to support.  The hardware
wasn't terribly reliable (just look at the "floating" lines that are
supposed to be tied to some power or ground), and you spend lots of time
debugging what you think is a software problem that really isn't.

MontaVista has a variety of support and service options.  Have you
contacted one of their business development or sales people to ask
this question?  You get free support when people like me have free time,
or generous people pay for the development of open source software.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
