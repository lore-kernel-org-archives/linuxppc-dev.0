To: sruel@oerlikon.ca
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: looking for a nice root filesystem image 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 26 Oct 2001 16:51:15 EDT."
             <3BD9CCC3.1030704@oerlikon.ca>
Date: Sat, 27 Oct 2001 00:18:52 +0200
Message-Id: <20011026221857.DD65110CDB@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3BD9CCC3.1030704@oerlikon.ca> you wrote:
>
> Now i'm looking for a "a bit bigger" root filesystem with typical
> utilities like: umount, ifconfig, etc. that could fit in around 8 MBytes
> of Flash. Is there some image available somewhere on the Net?

Have a look at "SELF" (our Simple Embedded  Linux  Framework");  it's
based  on Busybox, provides a lot of tools including remote access to
your target using FTP and telnet and fits in <840 kB of flash (kernel
not included).

You can get it even smaller when you "optimize" your  libs  (see  the
running thread).

Hope it helps.

Umm, yes, before I forget it: you find SELF in
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF/
There is even a short README ;-)

Hope it helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You could end up being oddly sad and full of a strange, diffuse  com-
passion  which would lead you to believe that it might be a good idea
to wipe out the whole human race and start again with amoebas.
                                 - Terry Pratchett, _Guards! Guards!_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
