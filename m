Message-ID: <3ABB54DF.83D364D4@mpifr-bonn.mpg.de>
Date: Fri, 23 Mar 2001 14:51:27 +0100
From: Albrecht =?iso-8859-1?Q?Dre=DF?= <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: Takashi Oe <toe@unlserve.unl.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: anyone with bmac network problem?
References: <Pine.A41.3.96LJ1.1b7.1010315122129.41552B-100000@unlserve.unl.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Takashi Oe wrote:
> I'm looking for testers on a possible workaround for bmac network problem.
> As some of you might know, bmac tx dies abruptly when network environment
> is very busy and never recovers.  A patch enclosed might alleviate the
> situation, and I want to know if it works for anybody else.
>
> This problem is hard to reproduce in that it takes time and you must have
> busy traffic.  I can say I have not been able to reproduce the problem
> when the patch is applied, whereas I could eventually reproduce the bmac
> hang without the patch, but YMMV.

IT WORKS!!! My test is to run the security scanner nessus against several hosts
in parallel, and it *always* crashed the network. Now it works like a dream,
absolutely stable. Good work, indeed!!! When does it go into the standard
kernel?

Thanks, Albrecht.

--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
