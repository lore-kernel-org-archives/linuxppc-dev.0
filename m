To: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
Cc: "'Embedded Linux PPC List'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 823 Video Controller Driver - where ? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 19 Dec 2002 09:01:53 EST."
             <D73A25AA6E54D511AD74009027B1110F3C04F5@ORION>
Date: Thu, 19 Dec 2002 15:55:16 +0100
Message-Id: <20021219145521.755EFC6289@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <D73A25AA6E54D511AD74009027B1110F3C04F5@ORION> you wrote:
> Actually I found lcd823.c and lcdvideo.h in arch/ppc/8xx_io of your
> linux-2.4.4-2002-03-21 :)

But lcd823.c / lcdvideo.h is - as the  name  "lcd..."  suggests  -  a
driver  for the LCD controller of the MPC823 CPU; it does not support
the video controller - and this was what the OP asked for:  a  driver
for the _video_ controller.

I think there once was such a beast, probably in
ftp://ftp.mvista.com/pub/Area51/embedded-planet/video.tgz

Maybe you happen to know if this is still available somewhere?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If A equals success, then the formula is A = X + Y + Z. X is work.  Y
is play. Z is keep your mouth shut.                 - Albert Einstein

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
