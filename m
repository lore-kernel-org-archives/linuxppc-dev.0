To: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
Cc: "'Embedded Linux PPC List'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 823 Video Controller Driver - where ? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 19 Dec 2002 10:32:35 EST."
             <D73A25AA6E54D511AD74009027B1110F3C0500@ORION>
Date: Thu, 19 Dec 2002 16:44:04 +0100
Message-Id: <20021219154409.3D609C6289@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <D73A25AA6E54D511AD74009027B1110F3C0500@ORION> you wrote:
> I appologize, you are correct.  I sometimes think of LCD and video as the
> same because I worked with a Lynx chip that allows both LCD and Video out
> from the same buffer.  Is it possible to use the 8xx LCD driver to drive the
> video out?  I believe the only section that needs to be changed is the
> function that initializes the LCD registers, I may be off though.

It's more complicated, since the video controller will not support  a
plain framebuffer, but only YUYV video mode.

What happened to the video driver for the EP boards? It was available
once on MV's FTP server - does not even EP has a copy any more?

[Asking just out of curiousity, as we've  already  reimplemented  all
the stuff we needed - no NTSC support yet, though].

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
As far as we know, our computer has never had an undetected error.
		                                           -- Weisert

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
