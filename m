To: Callebaut Benoit <callebaut@mailandnews.com>
Cc: linuxppc-embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Failsafe bootloader 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 04 Jun 2003 09:51:38 EDT."
             <3EE8E5EA@mailandnews.com>
Date: Wed, 04 Jun 2003 16:13:47 +0200
Message-Id: <20030604141352.1A5E3C5492@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3EE8E5EA@mailandnews.com> you wrote:
>
> We use small part of our flash to hold config data (last sector of the flash)
> and which image must be started. PPCBoot read this and start the right image.
> when upgrading , we change the kernel option to the failsafe kernel, do the
> update of the second kernel (the working one) and after that we change the
> kernel option again and we try to start the new one. We use also a kind of
> watchdog feature in case of system lockout.

It may be worth to point out that  U-Boot  supports  redundand  flash
sectors  for exactly such purposes, so you will always have a working
backup copy in case the update  of  your  config  data  (=environment
variables) sector fails because of powerdown etc.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
God made the integers; all else is the work of Man.       - Kronecker

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
