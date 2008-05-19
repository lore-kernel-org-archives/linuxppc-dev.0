Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	by ozlabs.org (Postfix) with ESMTP id 7DA92DDE3A
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 05:22:42 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1JyAwJ-0004Fz-9A
	for linuxppc-dev@ozlabs.org; Mon, 19 May 2008 14:22:31 -0500
To: linuxppc-dev@ozlabs.org
Subject: DTC patches
Date: Mon, 19 May 2008 14:22:31 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JyAwJ-0004Fz-9A@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


    dtc: Simplify error handling for unparseable input [resend]
    dtc: Clean up included Makefile fragments [resend]
    dtc: Trivial formatting fixes [resend]
    dtc: Make dt_from_blob() open its own input file, like the other input formats [resend]
    dtc: Rework handling of boot_cpuid_phys [resend]

All applied and pushed out.

    dtc: Rework handling of boot_cpuid_phys [resend]
                                            ^
                                            |
Please don't do this -----------------------+

This forced an edit of each commit message by hand.
If you are going to do this, do this instead:

    Subject: [resend] dtc: Rework handling of boot_cpuid_phys

Thanks,
jdl
