From: benh@kernel.crashing.org
To: Gabriel Paubert <paubert@iram.es>
Cc: Val Henson <val@nmt.edu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: EV-64260-BP & GT64260 bi_recs
Date: Tue, 26 Mar 2002 13:18:26 +0100
Message-Id: <20020326121826.22174@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.33.0203261249210.26486-100000@gra-lx1.iram.es>
References: <Pine.LNX.4.33.0203261249210.26486-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Won't fly, this is a byte wide register and there are machines with more
>than 256 interrupt lines. And they are even more likely with PCI 2.2+ so
>called message passing interrupts, which is a simple way to admit that the
>way of doing interrupts was so dumb that even (one physical PCB trace per
>vector) the Cro-Magnon man would have done better

Well, I would expect such machines to have a device-tree :) Anyway, a
bi_rec would indeed help if really needed here but again, it's optional
and I would expect embedded not to require it for PCI routing.

>Basically, PCI is going to implement interrupts in the way similar to waht
>VME/m68k (and even Z80) hardware have done for over 25 years. The
>electrical details are different, but it is the device that puts the
>interrupt vector on the bus, not some PIC (where P stands for
>paleolithic) through a maze of PCB traces.
>
>BTW, I don't even allow sharing VME interrupt vectors in my PCI<->VME
>bridge driver, because I have something like 1792 (7*256) separately
>identifiable interrupt sources.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
