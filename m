Message-ID: <20011121185415.3785.qmail@web20407.mail.yahoo.com>
Date: Wed, 21 Nov 2001 10:54:15 -0800 (PST)
From: Venkat Raghu <venkatraghu2002@yahoo.com>
Subject: Re: ppc405_eth_rxde...
To: Armin Kuster <akuster@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3BFAF4E0.6A42BAA0@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  Is there any method to reproduce this interrupt,
  so that "ppc405_eth_rxde" handler is called?

  Please mail to venkatraghu2002@yahoo.com. I did't
  subscribe.

   Raghava.



--- Armin Kuster <akuster@mvista.com> wrote:
> Venkat Raghu wrote:
> >
> >    Hi
> >
> >      I need help in understanding about following
> >    interrupt handlers:
> >    ppc405_eth_txde
> >  and   ppc405_eth_rxde.
> >
> >   What operation exactly triggers these?
>
> AFAIK, when the emac detects a problem with either
> rx or tx descriptors
> after being sent to the MAL then the approperate
> interrupt handler is
> used.
>
> > What is the
> >   effect after these handlers have been called,
> like
> >   whether these handlers reset the drivers etc?
>
> The rx/tx descriptors should be clear/reset for
> normal use.
>
> >What
> >  happens to the traffic that comes when this is in
> >  this interrupt mode.
>
> Packects may be dropped.
>
> >
> >   Any pointer or links wil be helpful.
>
> see 405GP user manual
>
> >
> >   Kindly mail back to venkatraghu2002@yahoo.com.
> >   I didt subscribe to this list.
> >
> >   Thank You
> >   Raghava.
> >
>
>
>  -- armin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
