Message-ID: <396C4490.F4ACF357@wtal.de>
Date: Wed, 12 Jul 2000 12:12:32 +0200
From: Christof Petig <christof.petig@wtal.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@mipsys.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.17pre9-ben1 gmac problems on iBook
References: <396201D1.B43A97F1@wtal.de> <20000705133728.28733@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> >
> >You're right.
> >Strange though that BootX gives this kind of weird behaviour (2.2.15pre14
> >works fine for me).
> >I'll report about yaboot soon.
>
> You "think" it worked right, but I'm pretty sure that if you do an
> extensive memory testing, you'll discover that random bits of memory are
> damaged and that the kernel is actually not fully reliable when booting
> with BootX.

After wrestling about two days with yaboot, the kernel boots fine.

Now I can recommend (on iBooks and alike):
- make yaboot's partition of type Apple_Bootstrap (anything else didn't work
for me)
- 1MB is fine (800k is minimum (still true?))
- splitting the swap partition is a good choice if you have a running system
- move it up/downwards to the second position (moving partitions is a nice
feature)
- if you want MacOS press option while booting
- "video=ofonly" is a good last resort help

Could someone please put the following explanations into the yaboot-faq:
  Option is the key with  alt and a half-fork on it.
  Command is the key with the apple and the knotlike figure
I had not been a Mac expert, so I had to guess.

    Christof


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
