Subject: Re: Random segfaults with 2.6
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Ernst Persson <ernstp@mac.com>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200309061611.03915.ernstp@mac.com>
References: <200309061611.03915.ernstp@mac.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1062860844.5572.24.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Date: Sat, 06 Sep 2003 17:07:24 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2003-09-06 at 16:11, Ernst Persson wrote:
> I'm running the latest linuxppc-2.5-benh and I'm getting a lot of random
> segfaults, specially in development tools.
> Emergeing in gentoo works half the time. Gcc and configure crashes, and this
> never happens with 2.4.*.

Is CONFIG_PREEMPT enabled? I used to get random segfaults and other
weird behaviour after a couple of hours of uptime (running linuxppc-2.5
from August 26th), and it all seems to be gone with preempt disabled. :\


> Linux zapp.no-ip.com 2.6.0-test4 #5 lör sep 6 12:40:19 CEST 2003 ppc  740/750
> GNU/Linux
> Module                  Size  Used by
> dmasound_pmac          85464  2 [unsafe]
> dmasound_core          20460  3 dmasound_pmac
> soundcore               9344  3 dmasound_core
> i2c_core               25060  1 dmasound_pmac

I thought dmasound wasn't working in 2.6? :)


--
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
