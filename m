Return-Path: <judith@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5CD9C67BB3
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Sep 2006 10:05:23 +1000 (EST)
Date: Fri, 8 Sep 2006 17:05:12 -0700
From: Judith Lebzelter <judith@osdl.org>
To: linuxppc-dev@ozlabs.org
Subject: 'make ARCH=ppc defconfig' failing for cross-compile
Message-ID: <20060909000512.GF9335@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I have been doing cross-compiles for ppc and powerpc on my i686 system. 
In order to do this I generate the .config file like this:

make ARCH=ppc defconfig
(or make ARCH=powerpc defconfig)

This is the error for ppc:

***
*** Can't find default configuration "arch/ppc/configs/common_defconfig"!
***
make[1]: *** [defconfig] Error 1
make: *** [defconfig] Error 2
 

If I replace this file 'arch/ppc/configs/common_defconfig' with an old one, 
it does create my .config.  The allmodconfig, allyesconfig and allnoconfig 
work as I expect.


This is also happening for powerpc with a slightly different error where 
it seems to get the architecture from my system rather than the 
specified target architecture:


drivers/pcmcia/Kconfig:187:warning: leading whitespace ignored
***
*** Can't find default configuration "arch/powerpc/configs/i686_defconfig"!
***
make[1]: *** [defconfig] Error 1
make: *** [defconfig] Error 2


Could you suggest something that would make these cross compile builds 
work again?

Thanks,

Judith
