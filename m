Message-ID: <3AE06E61.78B14266@mvista.com>
Date: Fri, 20 Apr 2001 10:14:09 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Michael Habermann <MHabermann@gmx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8xxFADS support
References: <5.0.2.1.0.20010420083110.009f5850@pop.gmx.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Michael Habermann wrote:
>
> I intend to use the MPC8xxFADS board with an 855T. I've read in this
> newsgroup several times that the FADS are causing problems.
> Which kind of problems do I have to expect? Is PCMCIA supported reliable?
>

I still don't have a FADS board so I don't know how well PCMCIA works on
it.  The support for the 860 FADS is in the code.  Give it a try and let
me know if find any issues. use the latest pcmcia-cs 3.1.26

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
