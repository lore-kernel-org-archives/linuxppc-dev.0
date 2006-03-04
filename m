Return-Path: <atul.sabharwal@exgate.tek.com>
Received: from igate.tek.com (igate.tek.com [192.65.41.20])
	by ozlabs.org (Postfix) with ESMTP id B9AF767A3F
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Mar 2006 13:38:14 +1100 (EST)
Received: from tektronix.tek.com (tektronix.tek.com [128.181.6.43])
	by igate.tek.com (8.12.10+Sun/8.12.10) with ESMTP id k242cCtT007399
	for <linuxppc-embedded@ozlabs.org>; Fri, 3 Mar 2006 18:38:12 -0800 (PST)
Received: from us-bv-u16.global.tektronix.net (us-bv-u16.bv.tek.com
	[128.181.2.45])
	by tektronix.tek.com (8.12.10+Sun/8.12.10) with SMTP id k242cB2i015069
	for <linuxppc-embedded@ozlabs.org>; Fri, 3 Mar 2006 18:38:12 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Different Page Size Support in Linux on PPC870
Date: Fri, 3 Mar 2006 18:38:58 -0800
Message-ID: <4A062D477D842B4C8FC48EA5AF2D41F201C47BE3@us-bv-m23.global.tektronix.net>
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

On PPC870, does the kernel only support 4K pages?  To reduce the size of
page table (level & level 2), would 8M page be a better choice on a
custom=20
board? It's a no swap configuration. Memory load is critical in our
design on this project.

Comments?

Thanks,

Atul
