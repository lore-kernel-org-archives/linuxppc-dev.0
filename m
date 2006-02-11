Return-Path: <atul.sabharwal@exgate.tek.com>
Received: from igate.tek.com (igate.tek.com [192.65.41.20])
	by ozlabs.org (Postfix) with ESMTP id 01DDB67B61
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 12:46:32 +1100 (EST)
Received: from tektronix.tek.com (tektronix.tek.com [128.181.6.43])
	by igate.tek.com (8.12.10+Sun/8.12.10) with ESMTP id k1B1kWtT012499
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 17:46:32 -0800 (PST)
Received: from us-bv-u16.global.tektronix.net (us-bv-u16.bv.tek.com
	[128.181.2.45])
	by tektronix.tek.com (8.12.10+Sun/8.12.10) with SMTP id k1B1kVxW018960
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 17:46:31 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: kernel startup 
Date: Fri, 10 Feb 2006 17:47:12 -0800
Message-ID: <4A062D477D842B4C8FC48EA5AF2D41F201BA209B@us-bv-m23.global.tektronix.net>
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

>>Please do yourself a favour and read some docs and FAQ's first.  With
>>a  low mapping ogf the IMMR like 0x00f00000 you will never be able to
>>run Linux.

I know that the processor does not allow setting up a base address for
the
exception vectors. In this situation, it would never be able to handle
TLB or system call exceptions. =20

Just don't know if this is feasible so scrambling for any other docs. I
have the instruction reference and development manual.

Seems to be a bad requirement to not have RAM at address 0x0. Would have
to change that. Rest should just fall in place by booting low. This
would allow exception handling from flash as well as RAM.

Best Regards,

Atul
