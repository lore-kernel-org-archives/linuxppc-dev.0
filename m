To: Kyle Harris <kharris@nexus-tech.net>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc823 w/lcd performance 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 12 Feb 2002 10:28:31 EST."
             <3C69349F.37B0B21C@nexus-tech.net>
Date: Tue, 12 Feb 2002 17:00:19 +0100
Message-Id: <20020212160024.2E062109D7@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C69349F.37B0B21C@nexus-tech.net> you wrote:
>
> Should I have reasonable performance running a MPC823 with the LCD
> controller driving a 640x480 color TFT panel? The reason I ask is that I

You should. Not exactly rocking, but reasonable.

> compile the kernel with lcd823.c (pulled from Wolfgang's ftp site)
> selecting the SHARP LQ64D340. The system slows to a crawl. I calculate

It's working here in a couple of configurations. Running Microwindows
and some fltk/flnx based application on top of it. Performance  seems
OK to me.

> the LCD using 26% of bus bandwidth. But, it appears to be using much
> more. I haven't actually hooked up the panel yet (waiting for cabling).

Please keep me posted - I'd like to know what you find out.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
See us @ Embedded Systems Nuremberg, Feb 19-21, Hall 12 K01 (with TQ)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
