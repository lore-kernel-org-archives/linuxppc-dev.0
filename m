Message-Id: <200009130608.IAA00768@piglet.grunz.lu>
Date: Wed, 13 Sep 2000 08:08:55 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: zeroing pages in the idle task?
To: paulus@linuxcare.com.au
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <14782.63625.633424.277661@argo.linuxcare.com.au>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Paul,

On  13 Sep, this message from Paul Mackerras echoed through cyberspace:
> Michel Lanners writes:
>
>> clock           : 195MHz
>>                   ^^^^^^
>> (by the way, this is wrong. Anybody with a fix?)
>
> I'm pretty sure that this is the number that OF is telling us, so if
> it's wrong, blame OF.  You don't have a G3 upgrade card in an older
> machine perhaps?

Yes, right. And I've seen OF report this before, and indeed, this info
comes out of OF.

> Since the only use of this number is for oohs and aahs, there's not a
> lot of motivation to try and work out if OF is wrong and work out the
> correct number.

Somebody might want to unify and come up with a routine that can
calculate clock frequency across all PPC machines. I don't know if
something like this can be done with only the processor, and no
motherboard hardware support...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
