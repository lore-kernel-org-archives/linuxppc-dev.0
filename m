To: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
Cc: ?? <yuj@mail.ndsc.com.cn>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: use bdi on board with ppcbug 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 20 Dec 2002 10:20:48 EST."
             <D73A25AA6E54D511AD74009027B1110F3C050D@ORION>
Date: Fri, 20 Dec 2002 18:10:44 +0100
Message-Id: <20021220171049.128AAC6139@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <D73A25AA6E54D511AD74009027B1110F3C050D@ORION> you wrote:
> Also, wouldn't the INIT section of the config script have to be empty?

This depends on the hardware. On many boards a minimal initialization
MUST be performed (like switching off the watchdog timer :-)

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Wish not to seem, but to be, the best."                  - Aeschylus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
