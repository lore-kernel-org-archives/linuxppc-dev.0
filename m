Message-Id: <200003242241.XAA00516@piglet.grunz.lu>
Date: Fri, 24 Mar 2000 23:41:32 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: LongTrail PCI resource assignment
To: bh40@calva.net
cc: tas@mindspring.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000324141255.013260@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  24 Mar, this message from Benjamin Herrenschmidt echoed through cyberspace:
>
> On Fri, Mar 24, 2000, Timothy A. Seufert <tas@mindspring.com> wrote:
>
>>If there was a really, really good reason to keep OF up to date
>>(like, say, if we could break back into the OF console like you can
>>on Sparcs), then it would be OK.  Otherwise it is most likely
>>unnecessary bloat, and leads to potential confusion (and bugs).  Is
>>there any such reason on ppc?
>
> After thinking a bit more about this, I beleive we could simply add a
> property to the nodes of cards for which we change the bus number,
> indicating the new linux pci dev infos. The way, we keep the "reg"
> property intact (it may be useful for rebuilding OF path).

Good idea. Fits what I said before about special code ;-)

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
