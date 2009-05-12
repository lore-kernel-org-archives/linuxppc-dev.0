Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-160.bluehost.com (outbound-mail-160.bluehost.com
	[67.222.39.40]) by ozlabs.org (Postfix) with SMTP id E9A73DDF62
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 17:20:48 +1000 (EST)
Received: from 72.25.32.200.dynamic.dejazzd.com ([72.25.32.200]
	helo=[206.223.20.150])
	by host200.hostmonster.com with esmtpa (Exim 4.69)
	(envelope-from <dhlii@dlasys.net>) id 1M3mIA-0002pw-5j
	for linuxppc-dev@ozlabs.org; Tue, 12 May 2009 01:20:46 -0600
Message-ID: <4A09234E.4020401@dlasys.net>
Date: Tue, 12 May 2009 03:20:46 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Xilinx FIFO TEMAC !?
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

        I am working on changes to xilinx_lltemac.c that support both
the SDMA and FIFO TEMAC's.
        I was wondering if anyone else had done anything already ?

       I have it pretty much working with a few issues:
             every so often the read FIFO gets out of sync and I have to
reset it dropping atleast one packet.
             Somehow something is screwed up that is breaking the
Busybox Web server. This is really weird because nothing else seems to
be broken.
             I have no clue how a driver that has no idea what is in the
packets passing through it can selectively screw up HTTP packets, but I
have proven to myself that the problem is in the driver - despite the my
beleif that is impossible.

       Anyway is there any interest in an LL FIFO TEMAC driver ?
       Or adding the FIFO code to the SDMA TEMAC code ? It only adds a
couple of dozen lines to the driver.




-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
