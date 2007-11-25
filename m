Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.192.123.res-cmts.eph.ptd.net
	[24.152.192.123]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D0F5EDDED7
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 25 Nov 2007 20:45:55 +1100 (EST)
Received: from [206.223.20.150] (helo=hp-dhlii.dlasys.net)
	by mx.dlasys.net with esmtp (Exim 4.67 #1 (Debian))
	id 1IwDwp-0006Ft-L3
	for <linuxppc-embedded@ozlabs.org>; Sun, 25 Nov 2007 04:38:43 -0500
Message-ID: <4749441B.1000703@dlasys.net>
Date: Sun, 25 Nov 2007 04:44:59 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: SPI, I2C
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


    I have been asked to do SPI and I2C drivers for Pico cards.
   
    I am trying to grasp what the practical use of either could be in an
environment where neither SPI nor I2C are going to be able to
communicate outside the FPGA.

    I am guessing that SPI and I2C implementations already exist for
Xilinx FPGA's - any chance that drivers might already exist ?

    I would prefer not to charge a client to reinvent something that
exists, or that can not serve a useful purpose.

    I am not trying to imply that SPI or I2C are not useful, just that
they are communications channels, and unless  they have outside I2C or
SPI hardware to talk to what purpose might they serve ?



-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
