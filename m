To: "Jennie Yuan" <jennie.yuan@fel.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: watch dog 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 21 Aug 2001 09:37:17 +0800."
             <001c01c129e1$d12dbaa0$52c809c0@2ghz.mshome.net>
Date: Tue, 21 Aug 2001 09:56:43 +0200
Message-Id: <20010821075648.A2E601125E@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <001c01c129e1$d12dbaa0$52c809c0@2ghz.mshome.net> you wrote:
>
> Do you have any idea to use software watch dog
> in Linux/ppc8xx system?

We have support for the watchdog both in our  PPCBoot  firmware  (see
ftp://ftp.denx.de/pub/ppcboot/  ),  and  a  software  driver  in  out
version  of  the  Linux  kernel,  see  drivers/char/wdt_mpc8xx.c   in
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/linux-2.4.4-2001-07-23.tar.bz2

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Remember, there's a big difference between kneeling down and  bending
over.                                                   - Frank Zappa

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
