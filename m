Date: Sat, 20 May 2000 22:52:31 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Sergio Brandano <sb@dcs.qmw.ac.uk>
cc: Worth <haworth@ncal.verio.com>, linuxppc-dev@lists.linuxppc.org,
        debian-powerpc@lists.debian.org
Subject: Re: Pismo status 
In-Reply-To: <200005200850.JAA28869@copper.dcs.qmw.ac.uk>
Message-ID: <Pine.LNX.3.96.1000520223754.11206C-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 20 May 2000, Sergio Brandano wrote:

>  I do not know why I am wasting time with this issue. Anyway, I have a
>  very different experience on cooling both cars and computers. All the
>  cars I happen to see do run the fan after shutdown (I can clearly
>  hear the quiet after shutdown, then the sound of the fan after a few
>  seconds). This is probably due to a different design for countries
>  with a warm weather, as you report otherwise. Concerning computers,
>  and Linux, it is running this OS that the situation improved, as far
>  as Intel processors are concerned. I can say that the cpus, before
>  the advent of the caged P-II, where so cold that I could safaly touch
>  them. This was, again, using Linux. Using MS-Windows, instead, I
>  could *not* do the similar thing for sure. And I have been using
>  Intel processors for a long, long time. I have a very different
>  experience with PPC. I purchased my first one last summer, and it is
>  damn hot. How is that Linux does not help here? How is that PPC is
>  claimed to be cooler than Intel?

Don't compare Apples and Oranges.  You're comparing a Pentium II to a G3.
A PII is somewhere near a PPC 604 in terms of speed.  If you touch a 604
heat sink, in my experience, it's luke warm even after running for several
hundred days continuously under linux.  Been there, done that.

For a fair comparison to the G3, you need to consider at least a Pentium
III (at about half again faster clock speed ;-).

> I also experienced that GNOME's
>  screen saver pumps up the CPU to 100% when it is active. If the
>  PowerBook is cool before triggering the screen saver, it gets boiling
>  hot (with fan spinning) after 30mins.

Oh, this is a PowerBook.  The machine gets hot for a lot of reasons, not
just the CPU.  Video chips generate lots of heat, as does your hard drive,
as do the power regulation circuits on the various boards.  In fact, I'd
expect the cpu to be one of the cooler devices, normally.  ;-)


>  Why is that? I would expect it
>  to shut the display off and similar things, rather than deliberately
>  trying to fry my baby. Anyway, I am done with this topic.

When the fan kicks on, you're still nowhere near a dangerous operating
temperature....  The fan usually kicks on when there's insufficient heat
dissipation from the bottom of the case (e.g. sitting on a bed, couch,
etc.).  I've never had a fan kick on if the machine was on a hard surface,
and that's with the LapBurner (err... I mean WallStreet ;-).

You can always turn off the gnome screensaver and just use xset to turn on
screen blanking, though.  :-)


Later,
David

---------------------------------------------------------------------
A brief Haiku:

Microsoft is bad.
It seems secure at first glance.
Then you read your mail.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
