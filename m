To: Tom Rini <trini@kernel.crashing.org>
Cc: Kumar Gala <kumar.gala@motorola.com>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mpc5xxx support (Was: Re: Proposed Kconfig update patch for help text) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 01 Apr 2004 09:16:22 PDT."
             <20040401161622.GA26876@smtp.west.cox.net>
Date: Thu, 01 Apr 2004 19:05:10 +0200
Message-Id: <20040401170515.E5C8EC10A4@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20040401161622.GA26876@smtp.west.cox.net> you wrote:
>
> In all seriousness, when the 52xx code for 2.4 was brought up, there
> were a number of objections to the Motorola provided code, from it's
> buggy to it being unacceptable crap.  Finally, 2.4 is about to enter a

So far, it's all we have, right? Or do you have anything significant-
ly better?

> "deep freeze", or so Marcelo intends at least, so I think it's out of
> the question for the mainline.  I don't mind keeping the

So why made you me submit all the stuff in the first place  when  you
were going to put it on hold until it was too late for inclusion?

> linux-2.4-mpc5xxx tree up to date so others can pull for what they need,
> but it's a dead end.

Indeed. Develpment continues in our CVS tree. I will  not  waste  the
time and effort to produce any new patches if they get dumped anyway.

> For 2.6, I think one of the following options needs to be done.
> - Motorola code, cleaned up with input from the community (and the bits
>   Linux just doesn't need, left out).

I think this is the only option there is.

> - Ignore the Motorola code, or since it's GPL (must be to be in the
>   kernel, so I'm just making the assumption here...) use it as a guide
>   for how things work to implement a clean Linux implementation of the
>   code.   I know there's someone working on this (who pops up on
>   #mklinux on freenode from time to time) but I don't know how far
>   they've gotten.

Ummm... Why is there no discussion about this on  any  mailing  list?
And don't you think that that at least Motorola should be included in
any  such  attempts? [AFAICT they are not, at least not until today.]
Also, isn't this kind of wasted effort as the target is still moving?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
There are no data that cannot be plotted on a straight  line  if  the
axis are chosen correctly.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
