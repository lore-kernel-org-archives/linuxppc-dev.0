Return-Path: <raul.moreno@telvent.abengoa.com>
Received: from envio.abengoa.com (envio.abengoa.com [217.15.37.68])
	by ozlabs.org (Postfix) with ESMTP id 6F73BDDE2B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jan 2008 22:48:28 +1100 (EST)
In-Reply-To: <83F3FC3E61CF7C4CAD05A740C542833407365D42@btss020a.ww300.siemens.net>
Subject: Re: TQM860L cross compilation problem
To: "Iring, Peter" <peter.iring@siemens.com>
Message-ID: <OFB93003B8.7BA9DA3F-ONC12573D3.0040614A-C12573D3.004104FB@abengoa.com>
Date: Thu, 17 Jan 2008 12:49:47 +0100
From: raul.moreno@telvent.abengoa.com
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded-bounces+raul.moreno=telvent.abengoa.com@ozlabs.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


It seems you are compiling for a m86k processor. It should be asm-ppc f=
or
the TQL.860. Have a look at  CROSS-COMPILE and ARCH variables in the
Makefile.

Ra=FAl Moreno



"Iring, Peter" <peter.iring@siemens.com>
"Iring, Peter"
Enviado por:
linuxppc-embedded-bounces+raul.moreno=3Dtelvent.abengoa.com@ozlabs.org
17/01/2008 11:37
                                                                       =
                                                
 Para:   <linuxppc-embedded@ozlabs.org>                                =
                                                
                                                                       =
                                                
 cc:                                                                   =
                                                
                                                                       =
                                                
 Asunto: TQM860L cross compilation problem                             =
                                                
                                                                       =
                                                





Hello to all,

I would like to crosscompile linux kernel 2.6.11.7 for TQM860L.
I have found on http://www.denx.de/wiki/Know/Linux24vs26 page that some=

tests were done on this board.

I have used kernel 2.6.11.7 from kernel.org and applied tosatti.patch o=
n it
and config-2.6.11.7-TQM860L.
I am using ELDK 4.1 for cross compilation.

But if I want to cross compile it, procedure stops with following resul=
t:

testnet@SK16085C:~/eldk_uclibc/ppc_8xx/usr/src/linux$ make ARCH=3Dppc
  CHK     include/linux/version.h
  SPLIT   include/linux/autoconf.h -> include/config/*
  CC      arch/ppc/kernel/asm-offsets.s
  CHK     include/asm-ppc/offsets.h
  CC      init/main.o
In file included from include/asm/setup.h:8,
                 from include/asm/machdep.h:8,
                 from include/asm/irq.h:6,
                 from include/asm/hardirq.h:8,
                 from include/linux/hardirq.h:6,
                 from include/asm-generic/local.h:6,
                 from include/asm/local.h:4,
                 from include/linux/module.h:21,
                 from init/main.c:16:
include/asm-m68k/setup.h:365: error: array type has incomplete element =
type
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2
Does anybody know what is going on?

Thanks in advance
Peter_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded=
