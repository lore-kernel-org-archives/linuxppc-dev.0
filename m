To: "Muaddi, Cecilia" <cecilia.muaddi@alloptic.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BDI-2000 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 08 Jan 2003 16:21:51 PST."
             <885489B3B89FB6449F93E525DF78777F064537@srvnt506.ALLOPTIC.COM>
Date: Thu, 09 Jan 2003 01:33:21 +0100
Message-Id: <20030109003326.AE16EC608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Cecilia,

in message <885489B3B89FB6449F93E525DF78777F064537@srvnt506.ALLOPTIC.COM> you wrote:
>
>
> You are right, my ethernet mac address was not passed in properly.
> Furthermore, I had
> too many ethernet device configured for this board.  Should be only one
> ethernet devices.
> Once I fixed the problem, my linux kernel is now up and running on the
> custom board.

Congratulations!

> As to the PPC native gdb, i don't see it in my distribution from timeSys.
> Do you
> have a suggestion as to where can i get a copy?

Ummm.. since you mentioned you're running under RH, this  will  be  a
x86 host, so you need a cross-GDB. I have no idea what it's called in
TimeSys'  toolchain;  common names are ppc_8xx-gdb, powerpc-linux-gdb
or similar...

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Hindsight is an exact science.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
