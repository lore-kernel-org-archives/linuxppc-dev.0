Message-ID: <37E10DA8.4E819A64@netx4.com>
Date: Thu, 16 Sep 1999 11:32:56 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: Dan Malek <dmalek@jlc.net>, bsimon@ctam.com.au,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: mpc8xx-2.3.10 configuration questions.
References: <19990916073633.38BA67B8@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:


> Accordingly, I offer the following changes, which were necessary to build a
> kernel for the RPCg CLLF board with an 860T.

The CLLF isn't a really a lite...it's a Classic with less stuff.
I am currently working on this now, and if you actually have a
CLLF (I don't know how you would) the FEC isn't going to work
because of the faulty magnetics on the board (not RPCg fault, the
manufacturer acknowledged an error after we found it).  The new
CLLFs will be available within a few days.



> *** arch/ppc/8xx_io/fec.c.dist  Wed Sep 15 17:32:26 1999

What is fec.c.dist?  It seems like I am always fixing this one.
I pretty sure I got it right in the 2.3.18 kernel.



> + /* Interrupt level assignments.
> + */
> + #define FEC_INTERRUPT SIU_LEVEL1      /* FEC interrupt */
> +

The CLLF will be built from the Classic configuration, so it
isn't appropriate to put this here.  There is also more that needs
to be added for the MII interrupts through a Port C bit.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
