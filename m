To: "lew kenny" <zsuly@hotmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: an error about "relocation truncated" 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 11 Aug 2004 09:23:37 +0800."
             <BAY13-F16VKixJfhENB00038ac8@hotmail.com>
Date: Wed, 11 Aug 2004 17:14:49 +0200
Message-Id: <20040811151454.82599C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <BAY13-F16VKixJfhENB00038ac8@hotmail.com> you wrote:
>
> I'm porting the PPCboot2.0 to my ppc850 board.I just modified the Makefile,

PPCBoot is a dead project. Porting it to new boards  is  a  waste  of
time. Please use the successor project U-Boot instead.

Also, please  post  U-Boot  related  questions  to  the  u-boot-users
mailing list. They are off topic here.

> config file,and the flash's code and head file with the template of board
> c2mon. But after I compile the code, there are some "relocation truncated"
> errors.

No. The primary error is here:

> lib_ppc/libppc.a(board.o): In function `board_init_r':
> /root/project/ppcboot-2.0.0/lib_ppc/board.c:896: undefined reference to
> `ide_init'

You understand what "undefined reference" means?

> At first, I think it may be caused by a low version number ompiler. Then I

Undefined references have little to do with the compiler version.

> changed the compiler to the last ELDK. But there are some new errors.
...
> {standard input}:4998: Error: Relocation cannot be done when using
> -mrelocatable
...
> I doubt that there maybe are some ploblems in the "ppcboot.lds". I am not
> sure of it, and I have no idea how to change it. It will be very
> appreciated if anyone give me some ideas.

Instead of spreading wild speculations you should start  reading  the
documentation, especially this section in the FAQ:

http://www.denx.de/twiki/bin/view/DULG/RelocationCannotBeDoneWhenUsingMrelocatable

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If I don't document something, it's usually either for a good reason,
or a bad reason.  In this case it's a good reason.  :-)
                 - Larry Wall in <1992Jan17.005405.16806@netlabs.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
