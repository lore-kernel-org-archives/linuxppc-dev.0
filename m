Message-ID: <3ADE0222.BF7F539C@sgi.com>
Date: Wed, 18 Apr 2001 16:07:46 -0500
From: Steven Hein <ssh@sgi.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: 860 RTC support
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've seen some discussions about real-time clocks lately, but (I think)
I scoured the list and can't find any basic information about how
to function the 860's real-time clock.  I'm using the real 2.4.3
kernel right now and I don't see that /dev/rtc would work.

Is there a working method (to read the RTC value at boot-time)?
I see references to 'hwclock', but from what I can tell that won't
work unless there's a /dev/rtc available (since 860 PPC isn't
supported natively by hwclock).

I apologize if I missed this info in the archives.  Any help would
be appreciated!

Thanks,
Steve

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
