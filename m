Date: Mon, 26 Mar 2001 05:26:05 +0100
Subject: Re: Sound stoppage
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>,
	"Michael R. Zucca" <mrz5149@acm.org>
Cc: "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010326043026.49B822F06E@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mon, Mar 26, 2001,  Hollis R Blanchard wrote:
> On Sun, 25 Mar 2001, Michael R. Zucca wrote:
>>
>> I'm having a problem with sound stopping when I'm trying to use it at the
>> same time as X.
>>
>> Machine lowdown:
>> PowerCenter 132 with a Sonnet 750 upgrade.
>
> I used to have this problem, also on a PowerCenter 132.
>
> I haven't used that machine in a while, but I believe such problems were
> fixed with Iain Sandoe's dmasound patches & backport. I don't remember the
> link offhand; check http://penguinppc.org/dev/pmac.

the last 2.2.x stuff is linked from: (and also via penguinppc.org).

http://www.drfruitcake.com/linux/linuxppc.html

*note* there is a dbdma problem that is *not* fixed with the ed21 patch to
2.2.18. (one day I'll apply the 2.4.x stuff back to the 2.2.18) - or if
someone else is interested in trying a merge - I can point them in the right
direction.

===== as of now...

You'd be better off with 2.4.x: (patches + a kernel binary/mods at)

ftp://ftp.penguinppc.org/users/iain/kernel/2_4_x/

==== Gotchas that remain:

1/ the 2.4.x patches will not build-in (stupid mistake on my part - I
renamed a CONFIG_XXX - but not everywhere - oops).

2/ Some PowerCenter machines have a dbdma problem (hardware-related) in
addition to those fixed in the 2.4.x patches.  There is a fix for this "in
the works" - sorry it's a bit slow coming (there's a few waiting) but I'm a
bit bogged down in rent-paying work ATM :-(.

I'll post as soon as the PowerCenter fix is avail.

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
