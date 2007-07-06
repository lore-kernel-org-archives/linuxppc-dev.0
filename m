Return-Path: <mark@mtfhpc.demon.co.uk>
Received: from anchor-post-36.mail.demon.net (anchor-post-36.mail.demon.net
	[194.217.242.86]) by ozlabs.org (Postfix) with ESMTP id 8375ADE044
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Jul 2007 05:08:04 +1000 (EST)
Received: from mtfhpc.demon.co.uk ([83.104.139.140])
	by anchor-post-36.mail.demon.net with esmtp (Exim 4.42)
	id 1I6qYd-0004nN-KQ
	for linuxppc-embedded@ozlabs.org; Fri, 06 Jul 2007 16:21:23 +0000
Received: from localhost (mark@localhost)
	by mtfhpc.demon.co.uk (8.9.3/8.9.3) with ESMTP id RAA04820
	for <linuxppc-embedded@ozlabs.org>; Fri, 6 Jul 2007 17:21:22 +0100
Date: Fri, 6 Jul 2007 17:21:21 +0100 (BST)
From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
To: linuxppc-embedded@ozlabs.org
Subject: ARCH=ppc vs ARCH=powerpc
Message-ID: <Pine.LNX.4.61.0707061706140.4792@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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

I have noticed and read a few comments regarding the demise of ARCH=ppc.

Having two PowerPC arcitectures and only supprting one of them makes 
little sense. Is it not time to migrate (where required) the remaining 
code from arch/ppc to arch/powerpc and asm-ppc to asm-powerpc. There are 
not many files left that are unique to ARCH=ppc so it should not take too 
long.

For me, the requirement is to keep support for the cards indicated in 
arch/ppc/config/xxx_defconfig (as I have one that I might what to use with 
linux) in the same way as they are supported in ARCH=ppc.

I have just made some tweeks to get ARCH=ppc building for me but I still 
need to sort out what is required to get around *** Error: Headers not 
exportable for this architecture (ppc).

Regards
 	Mark Fortescue.
