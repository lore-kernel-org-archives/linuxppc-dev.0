Return-Path: <atul.sabharwal@exgate.tek.com>
Received: from igate.tek.com (igate.tek.com [192.65.41.20])
	by ozlabs.org (Postfix) with ESMTP id 39F3367B74
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 13:09:36 +1100 (EST)
Received: from tektronix.tek.com (tektronix.tek.com [128.181.6.43])
	by igate.tek.com (8.12.10+Sun/8.12.10) with ESMTP id k1B29ZtT015059
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 18:09:35 -0800 (PST)
Received: from us-bv-u16.global.tektronix.net (us-bv-u16.bv.tek.com
	[128.181.2.45])
	by tektronix.tek.com (8.12.10+Sun/8.12.10) with SMTP id k1B29ZxW024669
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 18:09:35 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: kernel startup 
Date: Fri, 10 Feb 2006 18:10:17 -0800
Message-ID: <4A062D477D842B4C8FC48EA5AF2D41F201BA209E@us-bv-m23.global.tektronix.net>
From: <atul.sabharwal@exgate.tek.com>
To: <atul.sabharwal@exgate.tek.com>, <wd@denx.de>
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

More efficient would be to lock the exception handlers in L1 cache.  I
don't know the access rate of DPRAM on 870? Should be bus speed? So,
DPRAM and external memory would be same access time unless the
electrical characteristics of RAM vs. DPRAM technology is different.
--
Atul
