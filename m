Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3ED657D0.4070200@adtran.com>
Date: Thu, 29 May 2003 13:56:16 -0500
From: Ron Flory <ron.flory@adtran.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: embedded gcc PPC toolchain questions
References: <5.1.0.14.2.20030529125224.03782278@falcon.si.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jerry Van Baren wrote:
> As a piece of very important trivia, note that Wolfgang's example
> initialized the variable in the declaration.  If you don't initialize the
> variable, it won't end up in the desired section.  Yes, that is in the gcc
> manuals, just easy to miss :-).

  Thanks- I've been surprised by this cute little 'feature' on other
compilers.  Discovering it the hard way was a 'fun' way to blow a
day or two.  ;)

>
> References:
> http://sunsite.ualberta.ca/Documentation/Gnu/
> http://sunsite.ualberta.ca/Documentation/Gnu/gcc-3.0.2/html_node/gcc_100.html#SEC100

  The refs are most useful.  I was unaware that such low-level details of
gcc and friends had finally been documented, previous searches (a few years
ago) had turned up nada- or maybe i just didn't try hard enough...

thanks to all.


P.S.  Looking through past postings, are gcc 2.95.3 and binutils-2.10.1
       still the recommended versions for embedded use?  Has confidence
       in more modern versions been established yet?  I'll choose
       reliability over optimization every time, but i've heard of subtle
       issues with 2.95.3 as well.

ron


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
