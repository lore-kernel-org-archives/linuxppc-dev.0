Message-ID: <3EFB5D4C.8070605@esteem.com>
Date: Thu, 26 Jun 2003 13:53:32 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: (Sudo off topic)Simple cheap IDE intrerface for IBM 405
References: <3EF8CDF4.3050700@esteem.com> <3EFABFF4.9010707@esd-electronics.com>
In-Reply-To: <3EFABFF4.9010707@esd-electronics.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Matthias,

	Actualy it was a quest for a compact flash interface that started me on
this IDE interface saga to begin with. I knew you could build an adapter
to access compact flash cheaply/easily.

	Would it be posssible to give me ( or post ) a list of signal names of
what 405 signal connects to what compact flash signal in your interface?
I can understand if you say no.

	Also was the compact flash connected dirrectly to the data and address
bus or did you need to buffer it in some way?

Matthias Fuchs wrote:
> Hi Conn,
>
> we attached a CompactFlash socket to the 405's external bus on our CPCI405
> CompactPCI board. The board is directly supported by the
> linuxppc_2_4_devel tree.
> The tree includes a driver for simple memorymapped CompactFlash cards.
>
> Matthias
>

	Just the fact that I now know it can be done is of great help.

Thanks

	Conn

--

*****************************************************************
   If you live at home long enough, your parents will move out.
  (Warning they may try to sell their house out from under you.)
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
