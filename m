To: "Q-ha Park" <qha@infoeq.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: using bdi2000 to debug ppcboot on mpc7455 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 01 Oct 2003 15:57:45 +0900."
             <000501c387e9$52901590$2a21a8c0@qha>
Date: Wed, 01 Oct 2003 12:29:05 +0200
Message-Id: <20031001102910.9DE4DC59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <000501c387e9$52901590$2a21a8c0@qha> you wrote:
>
> Soft breakpoints just don't work for me. I have two BDI tools, and they
> behave the same. Not only that, "next", "step", and other commands just
> don't work properly.
>
> Here's what I get:
> (gdb) add-symbol-file ppcboot 0x1ffc0000
> add symbol table from file "ppcboot" at
>         .text_addr = 0x1ffc0000

Are you sure  that  0x1ffc0000  is  a  correct  address  of  for  the
relocated image? Do you really have 512 MB of RAM on your system? And
does your U-Boot image really require exactly 256 kB of space?

I think these numbers might be wrong...

> Error accessing memory address 0xfff00100: Unknown error 4294967295.
> (gdb)
>
> And now I get this. Did anyone go thru something like this?

Sounds like you are using bogus addresses.

#define DEBUG when compiling lib_ppc/board.c and check the output.



BTW: this discussion if off-topic in linuxppc-embedded;  please  post
any follow-ups to u-boot-users instead.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It is your destiny.                                     - Darth Vader

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
