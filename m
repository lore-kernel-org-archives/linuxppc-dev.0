Message-Id: <200108261754.TAA02887@piglet.grunz.lu>
Date: Sun, 26 Aug 2001 19:54:13 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Call for help: altivec-enabled vlc
To: k_fukui@highway.ne.jp
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20010827013941.Postino-000926@smtp01.highway.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  27 Aug, this message from Kaoru Fukui echoed through cyberspace:
>> I've sat down a bit ;-) and came up with an Altivec-optimised IDCT
>
> I don't know much.
> Altivec-gcc need "-fvec" as gcc option.

It's not altivec-enabled gcc; just plain asm which the assembler knows
about (if you pass the right option which I'm doing ;-).

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
