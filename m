To: Pantelis Antoniou <panto@intracom.gr>
Cc: Stephan Linke <Stephan.Linke@epygi.de>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: running 8xx without UART 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 12 Jun 2003 13:19:22 +0300."
             <3EE853AA.9020106@intracom.gr>
Date: Thu, 12 Jun 2003 12:37:46 +0200
Message-Id: <20030612103751.F280FC5FD7@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3EE853AA.9020106@intracom.gr> you wrote:
>
> In a new board we have the same problem, and I'll have to make the patch
> again. Since we need a serial port we used a max3100 spi to serial converter
> and I have a driver for that ready (but not yet as a console).

See drivers/char/max3111_serial.[ch] in our kernel tree :-)

> When I get around to add support for this chip in u-boot I'll also send the
> patches for the kernel.

TIA!

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The C-shell doesn't parse. It adhoculates.
    - Casper.Dik@Holland.Sun.COM in <3ol96k$b2j@engnews2.Eng.Sun.COM>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
