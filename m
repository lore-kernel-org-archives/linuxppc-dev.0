To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: init process does nothing after being execve'd 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 21 Aug 2001 09:55:28 BST."
             <200108210855.JAA00958@lougher.demon.co.uk>
Date: Tue, 21 Aug 2001 12:18:01 +0200
Message-Id: <20010821101806.91D7F1125E@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200108210855.JAA00958@lougher.demon.co.uk> you wrote:
>
> Regarding PPCBoot, I assumed (perhaps incorrectly) that it would
> not run on the Vesta (Redwood) boards without modification.  In any

This is correct. You will probably need some modifications to get  it
running there.

> case, I would have had to modify the Linux bootloader to use this

No. The whole  "Linux  bootloader"  is  obsolete  when  booting  from
PPCBoot. We don't use it at all.

> Agreed.  However, I'm not exactly sure if or how reliably the ethernet
> drivers in the kernel work on the Redwood.  With an initrd image,
> I can be sure the data is there, and is uncorrupted...

But you cannot easily debug it, which is much worse. Well,  you  can:
attach your BDI2000 and fire up GDB :-)

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Always leave room to add an explanation if it doesn't work out.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
