Return-Path: <atul.sabharwal@exgate.tek.com>
Received: from igate.tek.com (igate.tek.com [192.65.41.20])
	by ozlabs.org (Postfix) with ESMTP id 75FDD67B53
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 11:01:43 +1100 (EST)
Received: from tektronix.tek.com (tektronix.tek.com [128.181.6.43])
	by igate.tek.com (8.12.10+Sun/8.12.10) with ESMTP id k1B01gtT027855
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 16:01:42 -0800 (PST)
Received: from us-bv-u16.global.tektronix.net (us-bv-u16.bv.tek.com
	[128.181.2.45])
	by tektronix.tek.com (8.12.10+Sun/8.12.10) with SMTP id k1B01gxW018429
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 16:01:42 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: kernel startup
Date: Fri, 10 Feb 2006 16:02:24 -0800
Message-ID: <4A062D477D842B4C8FC48EA5AF2D41F201BA2081@us-bv-m23.global.tektronix.net>
From: <atul.sabharwal@exgate.tek.com>
To: <galak@kernel.crashing.org>
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



>>I'm not sure what sub-arch we are talking about, but some do have the
MMU=20
on.

I am using PPC 870 and u-boot 1.1.2.  Which architecture should I look
for as a reference example.  On my system, the RAM is not at address 0x0
but at
0x10000000. Since the exception table does not take full 32 bit address,
I am not sure how to tell the processor about the relocated location.

On this custom board with 870, is it necessary to have RAM at address
0x0
(or shadow it) or the 870 supports configuration for different base
addresses for memory. =20

Thanks,

Atul
