Message-ID: <38FE3C2B.7C09F77B@wanadoo.fr>
Date: Thu, 20 Apr 2000 01:07:23 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: aty128 and offb and linux-2.3.99pre6
References: <Pine.LNX.4.10.10004192247200.436-100000@cassiopeia.home>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:

> I'd really like to get rid of all these:
>
>     s3triofb_init_of()
>     imsttfb_of_init()
>     chips_of_init()
>     matrox_of_init()
>     control_of_init()
>     valkyrie_of_init()
>     platinum_of_init()
>     clgen_of_init()
>
> These are all PCI based, so they can be found using PCI probing and marked
> busy using PCI resource management.

Please leave the support for valkyriefb as it is. It may not be perfect,
but it works well enough, even with 2.3.99-pre6. My attempts to  switch
it to the new PCI resource management failed miserably. I am not sure if
it has everything that makes a true PCI card.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
