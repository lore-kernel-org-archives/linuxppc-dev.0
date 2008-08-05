Return-Path: <imp@bsdimp.com>
Received: from harmony.bsdimp.com (bsdimp.com [199.45.160.85])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 75C6BDDF01
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Aug 2008 16:58:14 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by harmony.bsdimp.com (8.14.2/8.14.1) with ESMTP id m756uRlL066590
	for <linuxppc-embedded@ozlabs.org>; Tue, 5 Aug 2008 00:56:27 -0600 (MDT)
	(envelope-from imp@bsdimp.com)
Date: Tue, 05 Aug 2008 00:56:49 -0600 (MDT)
Message-Id: <20080805.005649.1713918190.imp@bsdimp.com>
To: linuxppc-embedded@ozlabs.org
Subject: Quick question about dts
From: "M. Warner Losh" <imp@bsdimp.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have a .dts file that works with 2.6.18 (MV Pro 5.0).  I encode it
directly into the kernel image.  However, when I try to use it with my
2.6.23, 2.6.24 or 2.6.25 kernel trees, it doesn't work at all.  In the
MV Pro 5.0 kernel, I hacked the startup sequence to store a pointer to
this blob in r3 so that it is moved in.  I've done something similar
in -current (for reasons that are too complicated to really explain
well, we can't do this via the normal boot loader mechanisms).  The
dtc complains that the interrupt-controller property is obsolete on
the chosen device.

Does any documentation exist for how dts has evolved?  I'd like to
forward port what I have without examining the .dts files from both
versions and guessing...

Warner
