Message-ID: <39CEF3FC.A6DB84C6@wanadoo.fr>
Date: Mon, 25 Sep 2000 08:43:08 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: rshapiro@bbn.com
CC: Michel Dänzer <daenzerm@student.ethz.ch>, linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display!
References: <Pine.LNX.4.10.10009231028030.26749-100000@apollo.kulian.net>
		<14798.23332.833379.615321@esb.bbn.com>
		<39CE8B90.1B318DD2@student.ethz.ch> <14798.43366.937709.900651@esb.bbn.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


R Shapiro wrote:
>
> Michel Dänzer writes:
>  > What bug with screenblanking?
>
> Using the fbdev driver with xf 4.0.1, the default screenblanker kills
> the server as soon as the blanker is activated.  This can easily be
> replicated via 'xset s activate' or by letting the screenblanker
> activate itself by timing out. The ati driver and the r128 driver
> don't have this problem, only fbdev.
>
> I've seen this on all three platforms where I've tested 4.0.1, either
> using Franz Sirl's rpms or using the version I built with sources
> rsync'd yesterday.
>
> Martin Costabel reported this back in July on the users list so I
> assumed it was a known but low-priority bug (it's easily gotten around
> via 'xset s noblank').

I had this at the beginning after switching to Franz' RPMs, but it went
away soon, I don't remember why, maybe with Franz' 0.36a instead of
0.30c. Now screen blanking is OK, except that it blanks selectively,
i.e. parts of the screen with active widgets, clocks or ads or whatever,
remain visible. This has also been observed before by someone else (or
maybe it's a feature?).

The most annoying bug for me is that sometimes keys repeat (almost)
indefinitely. Most frequently mouse clicks on scroll arrows that scroll
all the way to the end of the file, but I had it also with the delete
(backwards) key that instead of only 2 characters erased 90% of the
whole text. This bug is random, but its probability is variable:
sometimes it happens practically always and sometimes almost never.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
