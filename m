To: James Don <JDon@spacebridge.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: RAMDISK IMAGES(2): ash has no job control ??? ... can't acces s tt y; job control turned off 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 12 Jan 2003 14:34:26 EST."
             <DB0585C9F6F9D411BE8F00D0B7896A4CC06038@SNCMAIL>
Date: Sun, 12 Jan 2003 21:19:48 +0100
Message-Id: <20030112201953.C69F3C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <DB0585C9F6F9D411BE8F00D0B7896A4CC06038@SNCMAIL> you wrote:
>
> When it says " can't access tty" ... maybe it should say ttyS00 because "
> ttyS00 at 0x0280 is a SMC" on my mpc860 ... I will have to keep digging ;-)

There is no /dev/ttyS00. The correct name is /dev/ttyS0.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
My challenge to the goto-less programmer  is  to  recode  tcp_input()
without any gotos ... without any loss of efficiency (there has to be
a catch).                                             - W. R. Stevens

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
