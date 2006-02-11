Return-Path: <atul.sabharwal@exgate.tek.com>
Received: from igate.tek.com (igate.tek.com [192.65.41.20])
	by ozlabs.org (Postfix) with ESMTP id 2F7EE67B95
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 11:09:51 +1100 (EST)
Received: from tektronix.tek.com (tektronix.tek.com [128.181.6.43])
	by igate.tek.com (8.12.10+Sun/8.12.10) with ESMTP id k1B09otT028684
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 16:09:50 -0800 (PST)
Received: from us-bv-u16.global.tektronix.net (us-bv-u16.bv.tek.com
	[128.181.2.45])
	by tektronix.tek.com (8.12.10+Sun/8.12.10) with SMTP id k1B09oxW020848
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 16:09:50 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: kernel startup
Date: Fri, 10 Feb 2006 16:10:32 -0800
Message-ID: <4A062D477D842B4C8FC48EA5AF2D41F201BA2084@us-bv-m23.global.tektronix.net>
From: <atul.sabharwal@exgate.tek.com>
To: <atul.sabharwal@exgate.tek.com>, <galak@kernel.crashing.org>
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

Since I have set IIP to 1, reset vector is at 0xfff00100.  IMMR is
0x00f00000. So, putting RAM at address 0x0 allows only 15MB of RAM
at address 0x0 (ISA style).=20

As memory and internal processor registers would conflict, I would have
a memory hole.  Hence, the logical choice of putting RAM at a different
location. So, if MMU allows shadowing (which I have not read), it could
solve my problem.

Regards,

Atul
