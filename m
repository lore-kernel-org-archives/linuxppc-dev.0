Return-Path: <dhlii@dlasys.net>
Received: from rwcrmhc15.comcast.net (rwcrmhc15.comcast.net [204.127.192.85])
	by ozlabs.org (Postfix) with ESMTP id 6057B67B52
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Jul 2006 03:53:10 +1000 (EST)
Message-ID: <44BFC2EF.5020305@dlasys.net>
Date: Thu, 20 Jul 2006 13:52:47 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: PHY Howto ?
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: dhlii@comcast.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 If I am writing a network MAC driver, for hardware that has a phy
that is already supported, if I provide the appropriate mdio_read() and
mdio_write() calls to access the phy registers, and setup my config to
include phylib and drivers for my specific phy,  what else do I have to
take care of with respect to the phy within my driver ?
	
	Are there some resources, howto's, examples, ... demonstrating 
how to use phylib ?


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
