Message-ID: <D73A25AA6E54D511AD74009027B1110F3C0512@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'Wolfgang Denk'" <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: use bdi on board with ppcbug 
Date: Fri, 20 Dec 2002 12:41:40 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Good point.

-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Friday, December 20, 2002 12:11 PM
To: Steven Blakeslee
Cc: ??; linuxppc-embedded@lists.linuxppc.org
Subject: Re: use bdi on board with ppcbug


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
