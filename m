Message-ID: <39BFFEA5.FE89C6EC@wanadoo.fr>
Date: Thu, 14 Sep 2000 00:24:37 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: per-fb mmap for platinumfb and valkyriefb in 2.4 (and 2.2)
References: <200009132110.XAA04545@piglet.grunz.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:
>
> Hi all,
>
> On  13 Sep, this message from mlan echoed through cyberspace:
> > Below is the per-fb mmap implementation
>
> Err.. nothing was below. Stupid /me... it's getting late.
>
> Anyway, here it is for both 2.2 and 2.4. Note that to compile on 2.2,
> you need my controlfb patch implementing mmap as well, since without it,
> this one won't compile (get it on sourceforge).

Tried it for valkyriefb: Doesn't work. It works in console mode, where
it actually feels like it is scrolling fast, but starting X gives an
immediate system freeze. I tried it twice, but now I'll go to bed.

> Have fun!

Not much fun in hard rebooting and watching 15 minutes of fsck.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
