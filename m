Return-Path: <mgalassi@c-cor.com>
Received: from penguin.ncube.com (penguin.ncube.com [134.242.67.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1241467B7C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Sep 2006 23:53:57 +1000 (EST)
Message-Id: <200609141353.k8EDrkPN065101@penguin.ncube.com>
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: Ethernet driver for Linux kernel 2.6 running on ML403 
In-reply-to: <45093A94.2080407@dlasys.net> 
References: <mailman.241.1158193867.2423.linuxppc-embedded@ozlabs.org>
	<002501c6d79e$cca7ee40$800101df@monstertop>
	<528646bc0609131852s41a8bc4ev44b84d68f51b1d2d@mail.gmail.com>
	<45093A94.2080407@dlasys.net>
Date: Thu, 14 Sep 2006 06:53:46 -0700
From: Michael Galassi <mgalassi@c-cor.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>> The virtex eth device is not the same as 4xx on-chip Ethernet, so
>> CONFIG_IBM_EMAC will not work.  You need the xilinx_enet driver (which
>> is not in mainline).  It might be in MontaVista's 2.6 tree.
>>
>> I think people have posted patches for it to this list, so try
>> searching the archives.  (I don't have a link off the top of my head.)
>>   
>    The MV 2.6 Xilinx_edk based TEMAC driver has been posted to this 
>list several times.
>
>    As of the last incarnation I tried it had no MII/PHY support and you 
>had to manully change the speed of the driver 10/100/1000 by editing the 
>code.

It is also worth noting that as released in MVL pro 4.0.1 it only
supports hard_temac 1.00.a and plb_temac 2.00.a, both of which are
tagged as deprecated in the current version (8.2.01i) of Xilinx's
EDK. The current version of {plb,hard}_temac (3.00.a) goes to great
lengths to break compatibility with older versions.  This will
presumably be fixed next month when it is rumored that wonderful new
things will come from Xilinx.  In the mean-time it is possible, though
neither simple, nor fun, to create Virtex4 designs with the older IP.

-michael
