Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 36304DDDFC
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Nov 2007 07:36:41 +1100 (EST)
Received: from [99.236.101.138] (helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68) (envelope-from <rpjday@crashcourse.ca>)
	id 1ItUP7-0003Fp-7B
	for linuxppc-dev@ozlabs.org; Sat, 17 Nov 2007 15:36:37 -0500
Date: Sat, 17 Nov 2007 15:32:26 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>
Subject: Makefile FLAGS typoes??
Message-ID: <alpine.LFD.0.9999.0711171530490.15479@localhost.localdomain>
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


  from arch/powerpc/Makefile:
...
KBUILD_CPPFLAGS += $(CPPFLAGS-y)
KBUILD_AFLAGS   += $(AFLAGS-y)
KBUILD_CFLAGS   += -msoft-float -pipe $(CFLAGS-y)
...

  those right-hand side variables don't look right.  are you sure they
shouldn't be, say, CFLAGS, or ccflags-y?  etc, etc.

rday

========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://crashcourse.ca
========================================================================
