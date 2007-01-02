Return-Path: <tnt@246tNt.com>
Received: from outmx020.isp.belgacom.be (outmx020.isp.belgacom.be
	[195.238.4.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B89DADDEBB
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 09:32:03 +1100 (EST)
Received: from outmx020.isp.belgacom.be (localhost [127.0.0.1])
	by outmx020.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l02MVrHl002662
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Jan 2007 23:31:53 +0100
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/4] 52xx fixes for 2.6.20
Date: Tue,  2 Jan 2007 23:29:51 +0100
Message-Id: <1167776995690-git-send-email-tnt@246tNt.com>
Cc: Linux PPC DEV <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Paul,

This is a set of fixes for the various 52xx platforms I'd like to
see in 2.6.20.

- First patch is just an obvious omission in the serial driver.
Certainly not critical but a simple fix nonetheless.

- The second patch corrects an incorrect usage of device_initcall

Note that it's possible other platforms make the same mistake,
a `grep "device_initcall" arch/powerpc/platforms/* -R` gives several
potential hits. I haven't investigated further though as I don't know
those platforms well enough to know if the use is legit or not.

- The two last patches make the assumption the device tree of the
EFIKA has been fixed properly for linux and allow it to boot using
more common code.


	Sylvain
