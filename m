Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F4137B6F00
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 15 May 2011 09:04:20 +1000 (EST)
Received: from 173.221.84.2.nw.nuvox.net ([173.221.84.2] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <rpjday@crashcourse.ca>)
	id 1QLNsd-0001cZ-FU
	for linuxppc-dev@lists.ozlabs.org; Sat, 14 May 2011 19:04:15 -0400
Date: Sat, 14 May 2011 19:04:12 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: linuxppc-dev@lists.ozlabs.org
Subject: linux kernel reference to non-existent CONFIG_FSL_85XX_CACHE_SRAM
Message-ID: <alpine.DEB.2.00.1105141902520.13315@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


  the current kernel source tree contains a Makefile reference to the
above Kconfig variable that doesn't appear to be defined anywhere.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
