Message-Id: <200005102032.WAA24381@denx.local.net>
To: "Brown, David (dbrown03)" <DBrown03@harris.com>
cc: "'duncanp@research.canon.com.au'" <duncanp@research.canon.com.au>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: flash drivers 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 10 May 2000 13:30:52 EDT."
             <BE1C564723B3D21191FD0000F840E39801D8151A@rfcmx2.rfc.comm.harris.com>
Date: Wed, 10 May 2000 22:32:56 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <BE1C564723B3D21191FD0000F840E39801D8151A@rfcmx2.rfc.comm.harris.com> you wrote:
> Shouldn't cfi_read_char() use the chip parameter?

What do you mean? It does, IMHO:

>From include/linux/flash.h:

	extern inline u_char cfi_read_char(char *baseptr, int offset,
					   int chip,
					   int bit_width)

Can ypu please explain your question?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
How much net work could a network work, if a network could net work?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
