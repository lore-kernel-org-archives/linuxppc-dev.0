Message-Id: <200103070649.HAA00777@piglet.grunz.lu>
Date: Wed, 7 Mar 2001 07:49:55 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: 2.4.2 USB and "mon>" (was Re: All 6 cards!!!)
To: benh@kernel.crashing.org
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20010306230649.31714@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   7 Mar, this message from Benjamin Herrenschmidt echoed through cyberspace:
>
>>Are you sure this is right? While trying to solve my
>>2.4-paulus-doesn't-boot-my-7600 probelm, I came across that code; and
>>sure enough, OF 1.0.5 (whic Stefan has in his 9500 also) doesn't have a
>>'quiesce' OF word.
>
> It doesn't, yes, but did it break ?

Oh yes, sure enough. However, I am unable to tell you _where_ exactly it
breaks.

I've been unable to boot _any_ 2.3/2.4 kernels on my machine since
around 2.3.99 or a bit earlier. Some revisions would boot part of the
time, but most of them not at all. Symtom is always the same: hang
before initializing the framebuffer, i.e. still on the OF screen.

I get the 'retunring 0x... from prom_init' string, but nothing after
that.....

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
