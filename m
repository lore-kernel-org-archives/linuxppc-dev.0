Message-ID: <3EC33507.8020302@embeddededge.com>
Date: Thu, 15 May 2003 02:34:47 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Jeremy Bowen <Jeremy.Bowen@opennw.com>
Cc: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>,
	support@abatron.ch
Subject: Re: Problems with MMU: address translation for 0xXXXXXXXX failed
References: <DEA23DB61B62D4118B5900508B323B84012CC7D9@OPENMAIL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jeremy Bowen wrote:

> The old firmware doesn't work. The new firmware does. I'd call that a bug.

Abatron was very good at working with us through a couple of different
Linux support implementations.  We (well, I) decided how to do it, Abatron
provided the support, then we (I) changed our mind to add more support.

Some versions of the PPC kernel require v1.08 of the BDI-2000 firmware,
others require v1.09, and I think with v1.10 we finally got it right.
It's not Abatron's fault, and I didn't keep track of which versions of
firmware worked with what kernels.  I'm running v1.10, and I guess I
could make a kernel configuration so v1.09 of their firmware works.

Abatron should be given a "best vendor to support Linux" award.  They
are kind and patient with us, and gave us exactly the tool we asked
for.  I'm certain if you asked Abatron support for assistance, they
will provide what you need.


> Wrong. You have been unable to demonstrate anything illegal.
> I still believe I'm completely and entirely innocent here. I have acted in
> good faith and cannot find any evidence of a license agreement you say I've
> breached.

Did you actually ask Abatron for an update?  :-)  Sorry, I've unfortunately
had to spend too much time with lawyers while in the software business.

I don't want to get involved in this argument.  I just want to say that
most of us have to work for a living and like to get paid for the work
we do.  The few hundred dollars they may have asked for would have already
saved you many times more than that.  I'm particularly sensitive to this
because some of the largest corporations in the world have expected me
to work for free, taken forever to pay invoices of a few thousand dollars,
for work I've done that has made them millions of dollars on the product.
We shouldn't treat each other that way.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
