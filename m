Message-Id: <200101101622.f0AGMw208453@denx.local.net>
To: Jerry Van Baren <vanbaren_gerald@si.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Using realtime clock? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 10 Jan 2001 10:56:58 EST."
             <4.3.2.20010110104647.00baee80@falcon.si.com>
Date: Wed, 10 Jan 2001 17:22:58 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <4.3.2.20010110104647.00baee80@falcon.si.com> you wrote:
>
> The astronomy people, among others, are really fanatical about accurate
> time and have some very elaborate programs to synchronize clocks to the
> nanosecond (microsecond?) level.  These involve NTP daemons.  Note that
> the NTP daemons can synchronize to a radio clock that provides a
> 1/second tick: your simplest solution would probably be to set up your
> accurate RTC to do a 1/second interrupt and then tie it into a NTP
> daemon to keep your kernel clock accurate.

Seems a bit of overhead (especially for embedded systems with limited
resources) to add a NTP daemon just to make one part  of  the  kernel
timekeeping toal to the other...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"It's when they say 2 + 2 = 5 that I begin to argue."    - Eric Pepke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
