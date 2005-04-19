Return-Path: <glenn@aoi-industries.com>
Received: from aoi-industries.com (mail.aoi-industries.com [216.204.214.42])
	by ozlabs.org (Postfix) with ESMTP id 8F5D167A2E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Apr 2005 12:01:55 +1000 (EST)
Received: from loki.aoi-industries.com (loki [192.168.2.30])
	by aoi-industries.com (Postfix) with ESMTP id 69AACC62D
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Apr 2005 21:37:13 -0400 (EDT)
To: linuxppc-embedded@ozlabs.org
Message-Id: <20050419013712.AE32FB01E4@loki.aoi-industries.com>
Date: Mon, 18 Apr 2005 21:37:12 -0400 (EDT)
From: glenn@aoi-industries.com (Glenn Burkhardt)
Subject: PPC 44x Watchdog timer
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Is there a patch for the built in watchdog timer in the 440GP available
anywhere for the 2.4 kernel (viz., ELDK kernels)?

I found a driver for the 2.6 kernel in the mailing list submitted
by Takeharu KATO last February, and, if nothing else is available, plan
to back fit it to the 2.4 kernel.

Thanks!
