To: "saurosalomoni" <saurosalomoni@bol.com.br>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ioctl(TIOCMGET) on Lite5200 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 09 Jun 2004 09:56:29 -0300."
             <HZ1LA5$9EA97153A3F2D2EC1AD72AC1798B6528@bol.com.br>
Date: Wed, 09 Jun 2004 15:14:48 +0200
Message-Id: <20040609131453.76074C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <HZ1LA5$9EA97153A3F2D2EC1AD72AC1798B6528@bol.com.br> you wrote:
>
> So, if the 5200 series don't support TIOCMGET and
> TIOCMSET ioctl() (nor TIOCMBIS and TIOCMBIC, I've just
> tried them), what could I possibly use to get/set the
> control pin RTS in my Lite5200?...
> Is there any other system call or function that
> accomplishes that?

The current version of the 5200 PSC  UART  driver  does  not  support
hardware handshake, so there is no way to control the RTS pin. If you
really  must,  you  can  either extend the driver to support hardware
handshake, or you could simply write a small driver to  control  this
pin as GPIO.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Imitation is the sincerest form of plagarism.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
