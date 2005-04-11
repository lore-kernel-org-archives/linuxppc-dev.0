Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 9C74567B25
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Apr 2005 23:39:39 +1000 (EST)
Received: from [10.1.1.138] (10.1.2.1) by mailhost.rdmcorp.com (Worldmail
	1.3.167) for linuxppc-embedded@ozlabs.org; 11 Apr 2005 09:39:37 -0400
Date: Mon, 11 Apr 2005 09:37:28 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Message-ID: <Pine.LNX.4.61.0504110931540.6667@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: moving from devfs to udev with 2.6 kernel on 8xx board?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


  since i don't have enough anguish in my life, i thought i might take
today to see if i can migrate from devfs to udev on my 8xx board.  at
the moment, with a 2.6.11.7 kernel, i have:

  busybox-1.00
  networking with the I2C/SPI/SMC1 patch installed
  devfs
  JFFS2 support in kernel (but no partition definition yet)

before i start reading up on udev, any guidance on whether this will
be straightforward, or will i want to slit my wrists by lunch time?
thanks.

rday
