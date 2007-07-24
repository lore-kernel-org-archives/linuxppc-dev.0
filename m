Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.192.123.res-cmts.eph.ptd.net
	[24.152.192.123]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D7202DDEC0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Jul 2007 18:21:08 +1000 (EST)
Received: from [206.223.20.140]
	by mx.dlasys.net with esmtp (Exim 4.63 #1 (Debian))
	id 1IDFXs-0000rM-HM
	for <linuxppc-embedded@ozlabs.org>; Tue, 24 Jul 2007 04:15:04 -0400
Message-ID: <46A5B5BA.2080707@dlasys.net>
Date: Tue, 24 Jul 2007 04:18:02 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Circular queue
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

    Is there a standard linux datastructure and routines to manage
circular queues ?

    I have a device that is not fundimentally different from a serial
character device
    except it is faster and the fundimental data type is 36 bits large.

    I have coded my own routines to setup and maintain a simple circular
queue,
    but I was hoping that there might be something more standard that
already exists.

    Anyone know of anything ?
   

   





-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
