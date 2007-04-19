Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E71BEDDE29
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Apr 2007 20:10:28 +1000 (EST)
Message-ID: <46270BFD.7010805@dlasys.net>
Date: Thu, 19 Apr 2007 02:28:13 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Using Linux 2.6.19 with Xilinx ML405
References: <46125216.2080903@computing.dundee.ac.uk>
	<46128E70.50503@ru.mvista.com>
	<46139148.1080308@computing.dundee.ac.uk>
	<878xd8qnir.fsf@sleipner.barco.com>
In-Reply-To: <878xd8qnir.fsf@sleipner.barco.com>
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


>
> PM> Do you know if I can use it for early serial in the same way as an
> PM> 8250?
>
> Unfortunately not. I started working on some patches for this some
> months ago, but got stalled doing other stuff. I doubt it will get
> integrated before the move to arch/powerpc.
>   
I posted working early serial patches as part of an earlier uartlite
driver (not PK's)
http://ozlabs.org/pipermail/linuxppc-embedded/2006-January/021545.html

The patch is a single big patch with compete board support for the Pico
E12 cards,
but it includes complete boot2bash uartlite support, including early serial.
The uartlite code much more closely follows the 8250 code.
The early serial portions probably would work asis with PK's driver. 
Though I can't confirm that as PK's driver does not work on my hardware.
A newer version of the same big patch is at
http://www.picocomputing.com/software/files/Installers/coLinux/Pico-2.6.patch.bz2
When I have more time and am more proficient with git I will likely break
it up into individual pieces.


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
