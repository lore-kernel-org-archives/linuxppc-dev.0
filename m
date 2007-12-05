Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.192.123.res-cmts.eph.ptd.net
	[24.152.192.123]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0F2F5DDE05
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Dec 2007 03:20:42 +1100 (EST)
Received: from [206.223.20.150] (helo=hp-dhlii.dlasys.net)
	by mx.dlasys.net with esmtp (Exim 4.67 #1 (Debian))
	id 1Izwqv-0004o7-SF
	for <linuxppc-embedded@ozlabs.org>; Wed, 05 Dec 2007 11:12:01 -0500
Message-ID: <4756CF15.2090805@dlasys.net>
Date: Wed, 05 Dec 2007 11:17:25 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Kernel symbol version history
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    This might be slightly OT here, but would anyone know where there
might be a reference that indicates at precisely what version a given
symbol either appeared or disappeared within the  Linux kernel ?

     As an example if a driver is supposed to work for 2.6 and 2.4 and
uses sysfs, or cdev, or alloc_chr_dev_region or ...
    How can one tell at what point that api or symbol appeared so that
the proper conditionals appear within the driver.

    The last one that bit me was I made a collection of casting changes
to address 64bit vs. 32bit targets, and found that using the C99 fixed
size types - uint32_t, ... made life much more pleasant, after putting
them I nobody else could build because uintptr_t did not appear until
2.6.24, and I still have not figured out exactly when uint32_t etc.
appeared.

    I would think there ought to be some resource besides group memory
to look this up ?
    Is there a way to use git to look back through the history of a
symbol rather than a file.



-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
