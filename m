Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 73365DDE08
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 00:53:40 +1100 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1J4GPX-0007RE-To
	for linuxppc-dev@ozlabs.org; Mon, 17 Dec 2007 07:53:37 -0600
To: linuxppc-dev@ozlabs.org
Subject: Various DTC Patches Applied
Date: Mon, 17 Dec 2007 07:53:35 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1J4GPX-0007RE-To@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Folks,

Tese patches have all been applied to the DTC repo and pushed out:

*  [master] dtc: Don't build tests as part of "all"
*  [master^] libfdt: Add more documentation (patch the seventh)
*  [master~2] libfdt: Add more documentation (patch the sixth)
*  [master~3] dtc: Fix silly typo in dtc-checkfails.sh
*  [master~4] dtc: Allow gcc format warnings for check_msg()
*  [master~5] dtc: Make dtc-checfails.sh script catch deaths-by-signal
*  [master~6] dtc: Reinstate full old-style reference-to-path for v0 dts files
*  [master~7] dtc: Convert check for obsolete /chosen property
*  [master~8] dtc: Convert #address-cells and #size-cells related checks

Thanks,
jdl
