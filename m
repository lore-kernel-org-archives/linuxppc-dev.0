To: Kapil Konde <kapilkk@yahoo.com>
Cc: linuxppclist <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Installing rtlinux on mpc860 board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 08 Aug 2001 16:03:32 +0530."
             <3B71157C.D09ED71@yahoo.com>
Date: Wed, 08 Aug 2001 12:45:04 +0200
Message-Id: <20010808104509.5AD6610CB8@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3B71157C.D09ED71@yahoo.com> you wrote:
>
> However when I do a meke xconfig I do not see any option like "RTLinux kernel
> extension" in platform support.

"make xconfig" is broken. Use "make menuconfig" instead.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The human mind  ordinarily  operates  at  only  ten  percent  of  its
capacity. The rest is overhead for the operating system.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
