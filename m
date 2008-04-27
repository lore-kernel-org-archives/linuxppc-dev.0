Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-130.bluehost.com (outbound-mail-130.bluehost.com
	[67.222.38.30]) by ozlabs.org (Postfix) with SMTP id 5D0F2DDE28
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Apr 2008 05:26:07 +1000 (EST)
Received: from 72.25.26.238.dynamic.dejazzd.com ([72.25.26.238]
	helo=hp-dhlii.dlasys.lcl)
	by host200.hostmonster.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68) (envelope-from <dhlii@dlasys.net>) id 1JqCVc-0002x8-5j
	for linuxppc-embedded@ozlabs.org; Sun, 27 Apr 2008 13:26:00 -0600
Message-ID: <4814D35C.9070608@dlasys.net>
Date: Sun, 27 Apr 2008 15:26:20 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: ARCH=ppc strncmp undefined
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: dhlii@dlasys.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    After pulling and rebasing to 2.6.25, I get  strncmp is undefined 
when  I try to link the kernel.

   I have not chased this down as  just added strncmp into
arch/ppc/lib/string.S

    But I would guess this is a side effect of changes to accomidate
migration to ARCH=powerpc.
    There appear to be a number of remaining arch/ppc BSP's that need
strncmp and therefore
    will not build in 2.6.25.




-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
