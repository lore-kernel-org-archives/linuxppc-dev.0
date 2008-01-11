Return-Path: <samppa@sundmangroup.com>
Received: from proxy1.bredband.net (proxy1.bredband.net [195.54.101.71])
	by ozlabs.org (Postfix) with ESMTP id D6F37DDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Jan 2008 00:12:00 +1100 (EST)
Received: from ironport.bredband.com (195.54.101.120) by proxy1.bredband.net
	(7.3.127) id 4730FF890159B2C5 for linuxppc-embedded@ozlabs.org;
	Fri, 11 Jan 2008 13:51:52 +0100
Message-ID: <23145.147.11.3.128.1200054808.squirrel@www.sundmangroup.com>
Date: Fri, 11 Jan 2008 13:33:28 +0100 (CET)
Subject: PPC vs POWERPC
From: samppa@sundmangroup.com
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
I want to port a board ( WRS SBC8265 ) from the PPC branch to the POWERPC
branch in the Linux Kernel -- do you have any good starting points that
describes what I need to pay attention to?

I've already made a port of U-boot-1.3.1 and enabled CONFIG_OF_LIBFDT.

So I need to create a DTS file, compile it with the DTC compiler and port
the current PPC branch to the POWERPC branch to my understanding.


Cheers // Matias
