Date: Wed, 13 Sep 2000 09:23:48 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Takashi Oe <toe@unlserve.unl.edu>
cc: Paul Mackerras <paulus@linuxcare.com.au>, mlan@cpu.lu,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: zeroing pages in the idle task?
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.1000913020841.1376E-100000@ofey.earthlink.net>
Message-ID: <Pine.LNX.3.96.1000913092239.15334F-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 13 Sep 2000, Takashi Oe wrote:

> > Since the only use of this number is for oohs and aahs, there's not a
> > lot of motivation to try and work out if OF is wrong and work out the
> > correct number.
>
> Could you possibly tell me how one might implement this?  That is: how one
> would measure/calculate this.  On NuBus, there is no OF, so I'd like to
> implement.

Ask the guys at Newer Tech for their Clockometer sources.  I don't know if
they'd be willing to open-source them, but it's worth a shot.  As I
understand it, their program does just what you're looking for.


Later,
David

---------------------------------------------------------------------
A brief Haiku:

Microsoft is bad.
It seems secure at first glance.
Then you read your mail.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
