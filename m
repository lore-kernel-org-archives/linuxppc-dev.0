To: Ron Flory <ron.flory@adtran.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: embedded gcc PPC toolchain questions 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 29 May 2003 13:56:16 CDT."
             <3ED657D0.4070200@adtran.com>
Date: Thu, 29 May 2003 22:21:19 +0200
Message-Id: <20030529202124.C010EC5492@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3ED657D0.4070200@adtran.com> you wrote:
>
> Jerry Van Baren wrote:
> > As a piece of very important trivia, note that Wolfgang's example
> > initialized the variable in the declaration.  If you don't initialize the
> > variable, it won't end up in the desired section.  Yes, that is in the gcc
> > manuals, just easy to miss :-).
>
>   Thanks- I've been surprised by this cute little 'feature' on other
> compilers.  Discovering it the hard way was a 'fun' way to blow a
> day or two.  ;)

Actually it should be no big surprise. I  think  every  (?)  standard
conforming  C  compiler  will  put  uninitialized  data  into the BSS
segment (usually .bss in the linker scripts).

> P.S.  Looking through past postings, are gcc 2.95.3 and binutils-2.10.1
>        still the recommended versions for embedded use?  Has confidence
>        in more modern versions been established yet?  I'll choose
>        reliability over optimization every time, but i've heard of subtle
>        issues with 2.95.3 as well.

We used 2.95.3 a long time for the ELDK, now we use 2.95.4.

No problems were reported (yet).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
There's no sense in being precise  when  you  don't  even  know  what
you're talking about.                             -- John von Neumann

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
