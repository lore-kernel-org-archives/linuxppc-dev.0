Message-ID: <3BFAF4E0.6A42BAA0@mvista.com>
Date: Tue, 20 Nov 2001 16:27:12 -0800
From: Armin Kuster <akuster@mvista.com>
MIME-Version: 1.0
To: Venkat Raghu <venkatraghu2002@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc405_eth_rxde...
References: <20011120225157.25787.qmail@web20402.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Venkat Raghu wrote:
>
>    Hi
>
>      I need help in understanding about following
>    interrupt handlers:
>    ppc405_eth_txde
>  and   ppc405_eth_rxde.
>
>   What operation exactly triggers these?

AFAIK, when the emac detects a problem with either rx or tx descriptors
after being sent to the MAL then the approperate interrupt handler is
used.

> What is the
>   effect after these handlers have been called, like
>   whether these handlers reset the drivers etc?

The rx/tx descriptors should be clear/reset for normal use.

>What
>  happens to the traffic that comes when this is in
>  this interrupt mode.

Packects may be dropped.

>
>   Any pointer or links wil be helpful.

see 405GP user manual

>
>   Kindly mail back to venkatraghu2002@yahoo.com.
>   I didt subscribe to this list.
>
>   Thank You
>   Raghava.
>


 -- armin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
