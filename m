To: Leonardo Pereira Santos <lsantos@pd3.com.br>
Cc: Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Card Services in a FADS850SAR board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 12 Nov 2002 19:26:07 -0200."
             <200211121926.09433.lsantos@pd3.com.br>
Date: Tue, 12 Nov 2002 22:47:28 +0100
Message-Id: <20021112214733.91B3710162@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200211121926.09433.lsantos@pd3.com.br> you wrote:
>
> 	After all this, my questions are:
> 	Should I tell my boss to give me a new board RIGHT NOW?

Yes. And ask for a BDI2000, too.

> 	If there is hope of making it work on my card, why the orinoco_cs module is
> unused?
> 	I got the powerpc kernel in bitkeeper, there is another kernel with a more
> recent version of CS?

The kernel we have in the CVS (2.4.4) plus ELDK 2.0 works find  on  a
couple of boards with PCMCIA cards, including WLAN (tested with DLink
and Elsa Airlancer [= orinoco]).

> 	Now the question that I fear: There is need of a ISA bus? If yes, where do I

No.

> 	I'm configuring my kernel to support:
> 	- hot plugable devies,
> 	- CardBus,

Do _not_ include cardbus support.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
See us @ electronica 2002 in Munich, Nov 12-15, Hall A3, Booth A3.325

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
