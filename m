To: Tom Rini <trini@kernel.crashing.org>
Cc: Robin Gilks <robin.gilks@tait.co.nz>,
	linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem of concurrency in arch/ppc/8260_io/uart.c 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 01 Oct 2003 16:51:58 PDT."
             <20031001235158.GD17768@ip68-0-152-218.tc.ph.cox.net>
Date: Thu, 02 Oct 2003 02:47:27 +0200
Message-Id: <20031002004732.17B59C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20031001235158.GD17768@ip68-0-152-218.tc.ph.cox.net> you wrote:
>
> For the moment it's "whatever you have now is probably fine".  For
> 2.4.23 I would like to get most of _devel cleaned out, wrt 8xx.  This
> will probably leave out some 'new' boards that Wolfgang sent out a long
> time ago (FWIW, once I get everything else out I do plan to ask Wolfgang
> if he wants to re-submit those boards or verify there's nothing new
> needed to what's in _devel or something).

It would be much easier for us if we knew which tree we should watch.
It seems this is changing every week or see. One  it  was  2.4,  then
_devel, then 2.5, then back _devel, now ...

I see no method in all this.

> If you have a new board, or a bug fix, current kernel.org (BK, snapshots
> of BK, just official releases) is best.

Ummm... Since when has this been the case?



Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Plan to throw one away.  You will anyway."
                              - Fred Brooks, "The Mythical Man Month"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
