Message-Id: <200011212148.WAA00753@piglet.grunz.lu>
Date: Tue, 21 Nov 2000 22:48:25 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: whacked out 2.2.18preX - last gasp
To: Stefan Jeglinski <jeglin@4pi.com>
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19341016094934.2031@192.168.1.2>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> _2_5 will help configs with multiple PCI busses except for IO ports which
> will still be available on the first bus only. This may get fixed for PCI
> IO BARs if we end up mapping virtually all the IO spaces appended together.

... which prompts me to ask: have you tried the 2940 in the three upper
    slots _and_ in the three lower slots? Same result both times?

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
