Message-ID: <3B95307D.1BE64A98@mvista.com>
Date: Tue, 04 Sep 2001 15:50:21 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 4xx - a question and a patch
References: <20010830175217.H858@zax>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:
>
> First the question: is there a good reason that set_dec() is a no-op
> on 4xx, rather than setting the PIT?

Yes.  The PIT is far from a perfect approximation of the decrementer.
When you "set the PIT" you actually set the reload register, not the
value that is decrementing.


> Second a patch - the below adds floating point emulation to the 4xx.

Got it.  Thanks.  Since we now have libraries built specially for
processors without floating point, emulation isn't necessary.  Try
them out.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
