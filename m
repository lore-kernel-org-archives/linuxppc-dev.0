To: Balajee Premraj <balajee_78@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Uboot SMC2 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 25 Aug 2004 13:33:19 PDT."
             <20040825203319.91070.qmail@web40707.mail.yahoo.com>
Date: Thu, 26 Aug 2004 02:07:10 +0200
Message-Id: <20040826000715.01756C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20040825203319.91070.qmail@web40707.mail.yahoo.com> you wrote:
>
> I am trying to use uboot to boot my target board based
> on MPC8260 whose serial is defined on SMC2.

This is off topic here. U-Boot related questions are discussed on the
u-boot-users mailing list, not here.

> I changed the config and tried boot it.I get all the
> uboot messages on the console but it would not accept
> any input.

Check  your  terminal  emulator  settings  (flow  control?)  and  the
hardware.  There  is  no  difference in the U-Boot driver for SMC1 or
SMC2, and it works fine on several other boards.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Love is an ideal thing, marriage a real thing; a  confusion  of  the
real with the ideal never goes unpunished."                  - Goethe

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
