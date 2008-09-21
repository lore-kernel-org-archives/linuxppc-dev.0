Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-01.bluehost.com (outbound-mail-01.bluehost.com
	[69.89.21.11]) by ozlabs.org (Postfix) with SMTP id CF139DDE2A
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 21 Sep 2008 16:36:54 +1000 (EST)
Received: from [72.25.39.148] (helo=hp-dhlii.dlasys.lcl)
	by host200.hostmonster.com with esmtpa (Exim 4.69)
	(envelope-from <dhlii@dlasys.net>) id 1KhI97-0000wK-Gd
	for linuxppc-embedded@ozlabs.org; Sun, 21 Sep 2008 00:10:13 -0600
Message-ID: <48D5E544.6070505@dlasys.net>
Date: Sun, 21 Sep 2008 02:10:12 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: C67x00 USB problems II
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

Issue # 2

how do I get the 2nd port working ?

I have the platform data altered as follows:

  .dev.platform_data = &(struct c67x00_platform_data) {
	        .sie_config         = C67X00_SIE1_HOST | C67X00_SIE2_HOST,
        	.hpi_regstep        = 0x04,
    /* A0 not connected on 16bit bus */
	    },

For two hosts rather than a host and a peripheral.

I have been pretending I can get this working without getting too
intimate with USB or this driver. Apparently that has been a self-delusion.


Again clues greatly appreciated.





-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too
numerous to list.

"Any intelligent fool can make things bigger and more complex... It
takes a touch of genius - and a lot of courage to move in the opposite
direction."
Albert Einstein
