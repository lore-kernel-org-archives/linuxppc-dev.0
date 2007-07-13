Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.192.123.res-cmts.eph.ptd.net
	[24.152.192.123]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E142ADDD08
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jul 2007 14:16:14 +1000 (EST)
Received: from [206.223.20.140]
	by mx.dlasys.net with esmtp (Exim 4.63 #1 (Debian))
	id 1I9CRP-00029x-Rh
	for <linuxppc-embedded@ozlabs.org>; Fri, 13 Jul 2007 00:07:39 -0400
Message-ID: <4696FB46.3020103@dlasys.net>
Date: Fri, 13 Jul 2007 00:10:46 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: TEMAC driver available
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

    I have finally been inspired to complete my TEMAC driver to an alpha
state.
    It nearly required dynamite - I had a client application where the
Xilinx/MV TEMAC
    just did not work.

    Anyway, the sucker is done and I guess I will post it as soon as I
have leaned it up
    if there is any interest.

    A brief description:
          Might optionally (as in used to badly) support the LL_TEMAC.
          Supports the more common PLB TEMAC ONLY in FIFO configurations.
          Autonegotiates.
          Is a reasonable approximation to a normal Linux network driver.
             i.e. does not require xilinx_comon, or xilinx_edk or .....
           Aside from hooks into the Linux build system is entirely
contained
          in a single reasonably sized source.
          Is extremely loosely based on older xilinx code from their
Webserver
          sample application.

    For someone that desparately wants to see it immediately you can
download
    http://www.picocomputing.com/files/linux/linux-2.6-pico.tar.bz2
    but that is a complete 2.6.22-rc4 kernel.org linux source with the
complete
    Pico BSP
         
      

-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
