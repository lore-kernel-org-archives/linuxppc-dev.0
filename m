Message-Id: <200101101506.f0AF6j408007@denx.local.net>
To: Jerry Van Baren <vanbaren_gerald@si.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Using realtime clock? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 10 Jan 2001 07:33:58 EST."
             <4.3.2.20010110072315.00bb5230@falcon.si.com>
Date: Wed, 10 Jan 2001 16:06:45 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <4.3.2.20010110072315.00bb5230@falcon.si.com> Jerry Van Baren wrote:
>
> The "proper" way to handle a RTC is to read it on power up and set the
> system clock based on it.  From then on, the system clock will be
> correct and everyone will use the system clock efficiently and accurately.

Well, that's the way  it's  often  done,  but  it's  far  from  being
perfect. On many embedded systems I'm working with the RTC is running
from  a high precision oscillator which provides much better accuracy
than the system clock. Both clocks will drift, and usually there will
be a noticable difference after a few days. This is not really nice.

> On the x86 (PC host), the utility is "hwclock" (man hwclock).  Your
> best approach is to get the source for that, modify it to read your RTC
> hardware (which may be different from the PC RTC hardware, although you
> might get lucky and only have to deal with endian issues).  Then add a
> call to it in your startup scripts, typically in /etc/rc.d/rc.local.

Any idea how to keep the system clock permanently synchronized to the
RTC?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
In an infinite universe all things are possible, including the possi-
bility that the universe does not exist.
                        - Terry Pratchett, _The Dark Side of the Sun_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
