To: Eugene Surovegin <ebs@innocent.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RAMDISK IMAGES(2): ash has no job control ??? ... can't access tt y; job control turned off 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 12 Jan 2003 12:15:11 PST."
             <5.1.0.14.2.20030112121009.02d9da10@pop.prodigy.net>
Date: Sun, 12 Jan 2003 21:32:02 +0100
Message-Id: <20030112203207.F1FF2C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <5.1.0.14.2.20030112121009.02d9da10@pop.prodigy.net> you wrote:
>
> If ash has been built _without_ job control support it will _never_
> complain about it,
> especially it will never print out that "job control turned off".

Absolutely correct.

> If you look at the source code of ash in busybox, you'll see that this
> particular message means that shell cannot access controlling tty.

...which is probably Jim's main problem.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Man is the best computer we can put aboard a spacecraft ...  and  the
only one that can be mass produced with unskilled labor.
                                                 -- Wernher von Braun

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
