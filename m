Date: Sat, 12 Aug 2000 14:51:26 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Ethan Benson <erbenson@alaska.net>
cc: Paul Mackerras <paulus@linuxcare.com.au>, linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again...
In-Reply-To: <20000812040251.C1645@plato.local.lan>
Message-ID: <Pine.HPX.4.10.10008121442541.27028-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 12 Aug 2000, Ethan Benson wrote:

> On Sat, Aug 12, 2000 at 04:29:12PM +1000, Paul Mackerras wrote:
> >
> > The get/set rtc stuff on powermac still needs work.  IMHO the way it
> > should work on powermacs is this:
> >
> > - at boot, read the RTC and the xpram and apply the correction from
> >   the xpram
> >
> > - /dev/rtc reads and writes the RTC value directly (no timezone
> >   correction)
> >
> > - if the RTC is updated from other places in the kernel, read the
> >   timezone recorded in xpram and apply that correction before writing
> >   it to the RTC.
>
> would this still allow for rtc in UTC?  for those of us who do not use MacOS..

Of course, at least that's how I see it. Just set all the xpram clock
variables to zero. BTW, if MacOS X claims to be a true Unix, it should
also support it.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
