To: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
Cc: "'Qsyang'" <yangqs@163.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: debug irregularly! 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 29 Aug 2003 09:56:49 EDT."
             <D73A25AA6E54D511AD74009027B1110F3C0A08@ORION>
Date: Fri, 29 Aug 2003 16:01:17 +0200
Message-Id: <20030829140122.82622C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <D73A25AA6E54D511AD74009027B1110F3C0A08@ORION> you wrote:
>
> Most likely you are compiling with optimization enabled.  This can cause the
> c code to execute in a different sequence than you wrote.

Right....

>           when i debug(debugger=BDI2000;cpu=8xx) U-boot in flash, it
> jumps irregularly as it running into "C" code, which always trouble me
> -<. How can i get a "normal" debug sequence? is it need to add some
> debug parameter into config.mk?

See also: http://www.denx.de/twiki/bin/view/DULG/DebuggingTricks

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Don't put off for tomorrow what you can  do  today,  because  if  you
enjoy it today you can do it again tomorrow.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
