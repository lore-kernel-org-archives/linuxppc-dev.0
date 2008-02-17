Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7EEE4DDF53
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Feb 2008 23:39:19 +1100 (EST)
Received: from cpe00142a336e11-cm001ac318e826.cpe.net.cable.rogers.com
	([72.140.150.221] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68) (envelope-from <rpjday@crashcourse.ca>)
	id 1JQh3Y-0001gR-MC
	for linuxppc-dev@ozlabs.org; Sun, 17 Feb 2008 05:47:36 -0500
Date: Sun, 17 Feb 2008 05:47:21 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>
Subject: "extra-aflags-y"??
Message-ID: <alpine.LFD.1.00.0802170544280.9794@localhost.localdomain>
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


  something about this doesn't look right:

$ grep -rw extra-aflags-y *
arch/ppc/boot/simple/Makefile:EXTRA_AFLAGS := $(extra-aflags-y)
$

  AFAIK, there is no supported "extra-aflags-y" variable.  and
EXTRA_AFLAGS is deprecated in favour of asflags-y anyway, no?

rday
--

========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry:
    Have classroom, will lecture.

http://crashcourse.ca                          Waterloo, Ontario, CANADA
========================================================================
