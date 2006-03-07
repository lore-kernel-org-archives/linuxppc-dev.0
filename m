Return-Path: <atul.sabharwal@exgate.tek.com>
Received: from igate.tek.com (igate.tek.com [192.65.41.20])
	by ozlabs.org (Postfix) with ESMTP id 595E467A5B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Mar 2006 05:26:27 +1100 (EST)
Received: from tektronix.tek.com (tektronix.tek.com [128.181.6.43])
	by igate.tek.com (8.12.10+Sun/8.12.10) with ESMTP id k27IQQtT023001
	for <linuxppc-embedded@ozlabs.org>; Tue, 7 Mar 2006 10:26:26 -0800 (PST)
Received: from us-bv-u16.global.tektronix.net (us-bv-u16.bv.tek.com
	[128.181.2.45])
	by tektronix.tek.com (8.12.10+Sun/8.12.10) with SMTP id k27IQQSm012610
	for <linuxppc-embedded@ozlabs.org>; Tue, 7 Mar 2006 10:26:26 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: help reqd
Date: Tue, 7 Mar 2006 10:27:11 -0800
Message-ID: <4A062D477D842B4C8FC48EA5AF2D41F201C47D7B@us-bv-m23.global.tektronix.net>
From: <atul.sabharwal@exgate.tek.com>
To: <achim.machura@berghof.com>, <prabha.j@tcs.com>
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

> insmod: unresolved symbol copy_to_user=20
> insmod: unresolved symbol down=20
> insmod: unresolved symbol up=20
> insmod: unresolved symbol copy_from_user=20

>>you have to include <asm/uacces.h>

Including a header file is only needed for compilation.  This is a
dynamic link/load error.  Unless the header file is putting some
information about the kernel link/load method.  Without module
versioning, you should be able=20
To load any driver binary compiled for a given kernel version.  Any
exceptions to this concept ?

--
Atul
