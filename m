From: Ernst Persson <ernstp@mac.com>
To: Michel =?utf-8?q?D=C3=A4nzer?= <michel@daenzer.net>
Subject: Re: Random segfaults with 2.6
Date: Sat, 6 Sep 2003 17:16:19 +0200
Cc: linuxppc-dev@lists.linuxppc.org
References: <200309061611.03915.ernstp@mac.com> <1062860844.5572.24.camel@thor.holligenstrasse29.lan>
In-Reply-To: <1062860844.5572.24.camel@thor.holligenstrasse29.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200309061716.19542.ernstp@mac.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


lördagen den 6 september 2003 17.07 skrev Michel Dänzer:
> On Sat, 2003-09-06 at 16:11, Ernst Persson wrote:
> > I'm running the latest linuxppc-2.5-benh and I'm getting a lot of random
> > segfaults, specially in development tools.
> > Emergeing in gentoo works half the time. Gcc and configure crashes, and
> > this never happens with 2.4.*.
>
> Is CONFIG_PREEMPT enabled? I used to get random segfaults and other
> weird behaviour after a couple of hours of uptime (running linuxppc-2.5
> from August 26th), and it all seems to be gone with preempt disabled. :\

Should have added that: yes it is.
And I know, I used to get crashes with it too (1-2 months ago), but then they
seemed to disappear and preempt was really stable. Maybe they are back? :-)

> > Linux zapp.no-ip.com 2.6.0-test4 #5 lör sep 6 12:40:19 CEST 2003 ppc
> > 740/750 GNU/Linux
> > Module                  Size  Used by
> > dmasound_pmac          85464  2 [unsafe]
> > dmasound_core          20460  3 dmasound_pmac
> > soundcore               9344  3 dmasound_core
> > i2c_core               25060  1 dmasound_pmac
>
> I thought dmasound wasn't working in 2.6? :)

http://ppc.bkbits.net:8080/linuxppc-2.5-benh/search/?expr=dmasound&search=ChangeSet+comments

!


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
