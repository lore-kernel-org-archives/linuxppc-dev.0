Mime-Version: 1.0
Message-Id: <v04220802b54dfb36e27a@[10.0.0.42]>
In-Reply-To: <200005200850.JAA28869@copper.dcs.qmw.ac.uk>
References: <Pine.SOL.4.10.10005191236120.4329-100000@ncal.verio.com>
 <200005200850.JAA28869@copper.dcs.qmw.ac.uk>
Date: Sun, 21 May 2000 14:01:25 -0700
To: Sergio Brandano <sb@dcs.qmw.ac.uk>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Pismo status
Cc: linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 9:51 AM +0000 5/20/00, Sergio Brandano wrote:
>  I do not know why I am wasting time with this issue. Anyway, I have a
>  very different experience on cooling both cars and computers. All the
>  cars I happen to see do run the fan after shutdown (I can clearly
>  hear the quiet after shutdown, then the sound of the fan after a few
>  seconds). This is probably due to a different design for countries
>  with a warm weather, as you report otherwise.

My car (designed for a country with warm weather) does not do this.
Many cars aren't even capable of it: they don't have an electric
engine fan, choosing instead to run the fan off an engine accessory
drive belt, meaning that the fan can only run while the engine runs.

>  Concerning computers,
>  and Linux, it is running this OS that the situation improved, as far
>  as Intel processors are concerned. I can say that the cpus, before
>  the advent of the caged P-II, where so cold that I could safaly touch
>  them. This was, again, using Linux. Using MS-Windows, instead, I
>  could *not* do the similar thing for sure.

So you never did anything processor intensive under Linux, eh?

>  And I have been using
>  Intel processors for a long, long time. I have a very different
>  experience with PPC. I purchased my first one last summer, and it is
>  damn hot. How is that Linux does not help here? How is that PPC is
>  claimed to be cooler than Intel? The bla-bla takes a different shape
>  when you touch with the finger eh?

If you're talking about notebooks, the problem is that Apple doesn't
do a particularly good job of getting rid of heat.  They've been
getting better with recent models, but many of their notebooks just
don't have very good cooling systems and thus build up to a high
temperature easily.  There is a difference between temperature and
heat.

If you're talking about desktop machines where cooling systems are
much easier, you're nuts.  Look at the heatsink and fan on a Pentium
II, then look at the heatsink on a G3 (comparable processors; a G3 is
about as fast as the next speed grade up of PII, e.g. 266 G3 is about
equal to 300 PII).  Apple doesn't even have to put a fan on the
heatsink (all they need is airflow created by the power supply or
case fan), and it's a hell of a lot smaller than the PII heatsink.

>  I also experienced that GNOME's
>  screen saver pumps up the CPU to 100% when it is active. If the
>  PowerBook is cool before triggering the screen saver, it gets boiling
>  hot (with fan spinning) after 30mins. Why is that? I would expect it
>  to shut the display off and similar things, rather than deliberately
>  trying to fry my baby. Anyway, I am done with this topic.

If you try to use a graphically intensive screen saver to cool down
the machine, you're stupid.  Sorry, I can't help you with that.  But
if you do want to give the machine a rest when you're away, run pmud
instead (pmud = pmu daemon, search the mailing archives for info).

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
