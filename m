Date: Thu, 28 Mar 2002 14:37:34 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: crash on sleep with 2.4.19-pre4-ben0
To: benh@kernel.crashing.org
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020328122437.7210@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E16qa5v-0000NT-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  28 Mar, this message from benh@kernel.crashing.org echoed through cyberspace:
>>Per System.map, I was able to verify that at least one previous crash
>>(with 2.4.18-rc4-benh) was in the same place.
>>
>>When these crashes started, I had changed, modulo kernel version of
>>course, these things:
>>
>>- started to use unmasq_irq on the hd,
>>- installed pbbuttonsd & gtkpbbuttons
>>
>>Removing both doesn't help. Also, it seems I need to power-off after a
>>crash to get airport back to life.
>>
>>Anybody with more insight?
>
> Can you get a backtrace ?

How? The keyboard doesn't work under xmon.... I need to power-cycle.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
