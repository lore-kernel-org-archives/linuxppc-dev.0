Message-Id: <200003151515.PAA20192@hyperion.valhalla.net>
Date: Wed, 15 Mar 2000 15:15:28 +0000
Subject: Re: 2.3.51 Trashes RTC on Beige G3 Mini-tower
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Christiaan Welvaart <C.J.Welvaart@phys.uu.nl>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>> at boot time {with options vmode=atyfb, vmode:16,code:32 single }
>> the usual "rtc time is" ... prints the correct date...
>> then we get "setting time to ... some time in Feb 1932...
>> from then on the RTC is wrong although using 'date' to set the correct time
>> behaves as expected on the running system.
>> Is this a library problem? (I'm using 2.3.51 with a system installed from
>> linuxPPC Q3 - but I've also updated to glibc-2.1.3 - j).
>
> On a beige G3 Dekstop, with the standard 2.3.51 sources, I don't see this
> problem At least there are no wrong dates set in /var/messages, though I
> only booted 2.3.51 twice. I use glibc-2.1.3-4a (with linux 2.2.14 now).

As of today's rsync - the trashing is no more...
It turns out the /etc/adjtime had got some very silly numbers in it - so I
can't tell at what point the problem went away.

> I did find a different problem: the builtin ethernet port doesn't work. It
> seems to work (almost?) perfectly from within linux (i.e. no errors), but
> no ethernet connection is made. The light on the hub stays off while the
> kernel reports that BMAC ethernet was succesfully initialized.
>

This problem I don't have - at least I connected to linuxppc.org quite
happily 5 minutes ago ;-)

swap .config files?
Iain.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
