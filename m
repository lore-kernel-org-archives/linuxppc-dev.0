Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C257EDDE39
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 20:32:34 +1100 (EST)
Received: from cpe001d60ad7267-cm001225dbafb6.cpe.net.cable.rogers.com
	([99.236.100.208] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68) (envelope-from <rpjday@crashcourse.ca>)
	id 1JR2Mb-0005ug-Lh
	for linuxppc-dev@ozlabs.org; Mon, 18 Feb 2008 04:32:41 -0500
Date: Mon, 18 Feb 2008 04:32:24 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>
Subject: "make ARCH=ppc defconfig" fails looking for common_defconfig
Message-ID: <alpine.LFD.1.00.0802180430100.10518@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


  (AIUI, the entire ppc/ architecture is going away, yes?  which means
i probably shouldn't care about any errors within.  is that correct?
even so, build errors should probably still be avoided for now.)

$ make ARCH=ppc defconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/docproc
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/kxgettext.o
  SHIPPED scripts/kconfig/zconf.tab.c
  SHIPPED scripts/kconfig/lex.zconf.c
  SHIPPED scripts/kconfig/zconf.hash.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
*** Default configuration is based on 'common_defconfig'
***
*** Can't find default configuration "arch/ppc/configs/common_defconfig"!
***
make[1]: *** [defconfig] Error 1
make: *** [defconfig] Error 2



rday
--

========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry:
    Have classroom, will lecture.

http://crashcourse.ca                          Waterloo, Ontario, CANADA
========================================================================
