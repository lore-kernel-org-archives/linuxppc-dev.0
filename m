Date: Fri, 3 Nov 2000 16:59:45 +0100 (MET)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
In-Reply-To: <19340928092447.1002@192.168.1.2>
Message-ID: <Pine.SOL.3.95.1001103165021.20257D-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 3 Nov 2000, Benjamin Herrenschmidt wrote:

> >I just had 2.2.18pre17-benh1 running (and sleeping) for about a week on
> >my Lombard, this morning it simply powered down and reset pram when I
> >tried to wake it up (battery was 95% full).
>
> I though that was fixed for a long time... weird.
>
Thought so, too. This was the only time this happened to me since then,
but Albrecht seems to have the same problem.

> >I also noted some other problems with sleep, mostly irregularly:
> >
> > xscreensaver tends to become somehow disconnected from the display, when
> > 	this happens, it will run in the background after wakeup and begin
> >	to consume 90%+ cpu, but doesn't blank the screen. It can be
> >	easily killed, however.
>
> Yup. Fortunately, even if you don't kill it, it tends to stop playing the
> CPU hog after a few seconds (or minutes ?)
>
Rather minutes. I didn't remember it ever spinning down on its own
(before I killed it, that is), and I certainly sometimes only noticed it
after 15-30 minutes.

> >	I added some lines to pwrctl-local to kill it before sleeping
> >	and relaunch it afterwards, but even then it happenened once again
> >	(before, it was about every other time, though)
> >
> > power consumption during sleep is occasionally (not frequently) 5-10
> >	times the normal rate, which will discharge the battery within
> >	24-36 hours.
>
> Bizarre... The new sleep code is supposed to be a lot less robust to
> those various issues. Well, I suggest you try again with pmac-stable once
> the ADB problem is ironed out. Both Paul and I did various fixes to the
> sleep process.
>
Again, this only happened once with newer kernels.

Thanks,
								Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
