To: "Mark Chambers" <markc@mail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: U-Boot and kernel 2.6 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 11 Jun 2004 11:31:04 EDT."
             <002a01c44fc9$201dc820$0301a8c0@chuck2>
Date: Fri, 11 Jun 2004 18:22:09 +0200
Message-Id: <20040611162214.EF46AC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <002a01c44fc9$201dc820$0301a8c0@chuck2> you wrote:
>
> Here's another idea - how about XML?  That would be two steps forward, IMO,
> instead of just going from one magic structure to another.

Oh no. Don't forget that the the boot loader  has  to  generate  XML.
Grrrhh... [I'd rather generate a troff document, then :-) ]

> As to just trashing bd_t, does that mean users have to upgrade their
> bootloader to use newer kernels, and could not switch back easily if
> problems arose?  Perhaps the kernel could identify whether the pointer is to
> a bd_t or something else and handle it automatically?

I guess you can always add some glue code (aka bootstrap  loader)  to
the Linux kernel which converts one interface into another.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A conservative is a man with two perfectly good legs  who  has  never
learned to walk.                              - Franklin D. Roosevelt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
