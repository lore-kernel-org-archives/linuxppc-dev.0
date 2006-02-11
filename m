Return-Path: <atul.sabharwal@exgate.tek.com>
Received: from igate.tek.com (igate.tek.com [192.65.41.20])
	by ozlabs.org (Postfix) with ESMTP id CFB4167B73
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 12:40:02 +1100 (EST)
Received: from tektronix.tek.com (tektronix.tek.com [128.181.6.43])
	by igate.tek.com (8.12.10+Sun/8.12.10) with ESMTP id k1B1e2tT011732
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 17:40:02 -0800 (PST)
Received: from us-bv-u16.global.tektronix.net (us-bv-u16.bv.tek.com
	[128.181.2.45])
	by tektronix.tek.com (8.12.10+Sun/8.12.10) with SMTP id k1B1e1xW017478
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 17:40:01 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: kernel startup 
Date: Fri, 10 Feb 2006 17:40:44 -0800
Message-ID: <4A062D477D842B4C8FC48EA5AF2D41F201BA209A@us-bv-m23.global.tektronix.net>
From: <atul.sabharwal@exgate.tek.com>
To: <wd@denx.de>, <galak@kernel.crashing.org>
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

> I'm not that familiar with 8xx, but can't you move IMMR?

Of course you can.

That's correct but on 8540, it did not work.  I was using u-boot
And BDI had mapped it to 0xe0000000 and u-boot had mapped it to
0x40000000. So, it was a problem as serial interface did not work.

It was easier to keep IMMR value same in the BDI configuration and the
processor. Just did not find it necessary to relocate it.

Most of the time, it's a question between conceptual and factual(does it
work ?).
--
Atul
