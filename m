Message-ID: <20040707071319.93766.qmail@web15201.mail.bjs.yahoo.com>
Date: Wed, 7 Jul 2004 15:13:19 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Re: make menuconfig error in latest "bk pull"
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.60.0407061615230.21433@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Robert P. J. Day" <rpjday@mindspring.com> wrote£º

> i'm probably way behind the curve here, but:
>
> $ make ARCH=ppc menuconfig
> scripts/kconfig/mconf arch/ppc/Kconfig
> drivers/net/Kconfig:201: can't open file
> "drivers/net/ibm_ocp/Kconfig"
> make[1]: *** [menuconfig] Error 1
> make: *** [menuconfig] Error 2

I met this same problem,too.You could try mask
drivers/net/Kconfig:201.Then it could be OK.I guess it
was Matt Porter updated old ibm_ocp but neglected to
fix related Makefile.Also if you use "make
mrproper",there is still one Makefile error left.You
could try remove or mask the line of ibm_ocp of
driver/net/Makefile.There was no driver/net/ibm_ocp
directory in the lastest repository.

Best regards,

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
