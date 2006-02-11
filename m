Return-Path: <atul.sabharwal@exgate.tek.com>
Received: from igate.tek.com (igate.tek.com [192.65.41.20])
	by ozlabs.org (Postfix) with ESMTP id 38AED67A58
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 11:18:28 +1100 (EST)
Received: from tektronix.tek.com (tektronix.tek.com [128.181.6.43])
	by igate.tek.com (8.12.10+Sun/8.12.10) with ESMTP id k1B0IRtT029886
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 16:18:27 -0800 (PST)
Received: from us-bv-u16.global.tektronix.net (us-bv-u16.bv.tek.com
	[128.181.2.45])
	by tektronix.tek.com (8.12.10+Sun/8.12.10) with SMTP id k1B0IQxW023730
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 16:18:27 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: kernel startup 
Date: Fri, 10 Feb 2006 16:19:09 -0800
Message-ID: <4A062D477D842B4C8FC48EA5AF2D41F201BA2088@us-bv-m23.global.tektronix.net>
From: <atul.sabharwal@exgate.tek.com>
To: <wd@denx.de>
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

>>The RAM "is" where you map it. The mapping is done in  software.  The
>>software is implementing your design.

>>In other words, your design is broken when you put the RAM at such  a
>>strange address instead of the natural location, starting from 0x0000.

Memory is not on the local bus but across a third party memory
controller.
Two processors loosely coupled.  So, the RAM is at non zero address.

This seems to be the critical problem in this design but need to
convince
the design engineers.  I don't know the reason why they want memory at
non zero address but that's the requirement.

--
Atul
