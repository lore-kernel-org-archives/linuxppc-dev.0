To: "yhxing" <xyuhua_telecom@hotmail.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How to control RTS signal ? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 19 Dec 2003 12:50:53 +0800."
             <Sea1-DAV34kO1dJFUuS0000e1ba@hotmail.com>
Date: Fri, 19 Dec 2003 21:37:39 +0100
Message-Id: <20031219203744.6CE0AC5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Sea1-DAV34kO1dJFUuS0000e1ba@hotmail.com> you wrote:
>
>    Now we are using a mpc823 embedded system, and there is some trouble.
> We need to use SCC3 UART to control RS485 tranceiver. TXD3 is connected
> to RS485 tranceiver's D pin, RXD3 is connected to RS485 tranceiver's R
> pin, and RTS3 is connected to RS485 tranceiver's RE# and DE pin. Then
> when transmitting data, we hope RTS3 signal can keep low to enble D.
> When receiving data, we hope RTS3 signal can keep high to enble R.
>    So my question is, how can I program to control RTS3 signal in ppclinux.

You will need a version of the UART  driver  that  supports  hardware
handshake  and  allows  you  to  configure  the  processor  pins  for
handshake operations. See for example the source  trees  on  our  CVS
server.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Q:  Why do mountain climbers rope themselves together?
A:  To prevent the sensible ones from going home.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
