Message-Id: <200104172137.XAA00843@piglet.grunz.lu>
Date: Tue, 17 Apr 2001 23:37:46 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: TiBook trackpad in benh's kernel?
To: costabel@wanadoo.fr
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3ADCB6A6.D2DBE9AC@wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  17 Apr, this message from Martin Costabel echoed through cyberspace:
> Michel Lanners wrote:
>>
>> Hi all,
>>
>> Anyone else seen this? I can't get the trackpad on my TiBook working
>> with benh's latest tres (rsync'ed a few days ago).
>
> Can it be that the old "booting cmode 32 kills trackpad" bug is still
> alive and bit you? Did you try booting using cmode:16 or cmode:8 ?

Yeah, exactly right. cmode:32 and cmode:16 kill the trackpad; cmode:8
works OK. Plus, I am able to run XF4 in 32 bpp, even with cmode:8 set.

Go figure...

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
