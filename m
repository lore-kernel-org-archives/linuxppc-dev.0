Message-Id: <200007120131.CAA24936@hyperion.valhalla.net>
Date: Wed, 12 Jul 2000 02:31:59 +0100
Subject: Re: 2.4.0-test3 tree
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: toa@pop.agri.ch
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tue, Jul 11, 2000 Andreas Tobler wrote:
> Iain Sandoe wrote:
>>
>> The bk rsync 2.4.0-test3 tree is not compiling (timer.c)
>> rsynced 16:00 BST [15:00 UTC/GMT]
>
> kernel/timer.c line 580: if (p->nice > DEF_NICE) (ok)
> arch/ppc/kernel/idle.c line 51: current->nice = 0; (not sure)
>
> Runs here on a wallstreet.

Thnx.
and now on a G3/Beige :-))

[doesn't solve the problem I have - no sound - but at least I can now try
and fix that :-) ]

Iain

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
