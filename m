Message-Id: <200103062210.XAA00895@piglet.grunz.lu>
Date: Tue, 6 Mar 2001 23:10:43 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: 2.4.2 USB and "mon>" (was Re: All 6 cards!!!)
To: benh@kernel.crashing.org
Cc: jeglin@4pi.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20010306165515.9932@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   6 Mar, this message from Benjamin Herrenschmidt echoed through cyberspace:
>
>>Running 2.4.2 (kfukui) on 9500-class machine with an OrangeMicro USB
>>firewire card [ADB keyboard + USB mouse], have noted 2 things:
>>
>
> Can you try a couple of things:
>
>  - First, check if the kernel works without the USB card

The probelm with the USB card is related to it getting IRQ1. Something
is fishy with assigning PCI interrupts (still or once again, I don't
know...)

>  - Then, edit prom.c, and looks for the code that calls OF "quiesce" call.
>    This code might be inside a if () checking OF version. If it is, then
> remove
>    the if () to force a call on all OF versions

Are you sure this is right? While trying to solve my
2.4-paulus-doesn't-boot-my-7600 probelm, I came across that code; and
sure enough, OF 1.0.5 (whic Stefan has in his 9500 also) doesn't have a
'quiesce' OF word.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
