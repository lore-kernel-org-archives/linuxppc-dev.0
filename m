To: "Muaddi, Cecilia" <cecilia.muaddi@alloptic.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: access memory mapped registers 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 09 Jan 2003 16:27:47 PST."
             <885489B3B89FB6449F93E525DF78777F064541@srvnt506.ALLOPTIC.COM>
Date: Fri, 10 Jan 2003 02:12:49 +0100
Message-Id: <20030110011254.76017C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <885489B3B89FB6449F93E525DF78777F064541@srvnt506.ALLOPTIC.COM> you wrote:
>
> Given that, do you know what is the convention if I need to address the GPIO
> pins in
> the 860?   I have some FPGA which require me to download the FPGA code
> and they are controlled via JTAG from my GPIO pins out of 860.  I can use
> mmap to map the ppc 860 internal memory (the quick dirty way just to see if
> works), or is there a driver already provided which will allow me to control
> the GPIO pins from user application?

There is no such driver, and there cannot be any such generic driver,
as the usage of the port pins is different for  each  board.  And  it
would  be  a  very  bad idea to allow any user to mess with important
things. You can even ruin hardware that way.

Do yourself a favour and write a device driver that does  what  needs
to be done.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
There is nothing in this world constant but inconstancy.      - Swift

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
