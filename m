Return-Path: <tnt@246tNt.com>
Received: from outmx006.isp.belgacom.be (outmx006.isp.belgacom.be
	[195.238.4.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 080D6DDDE5
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 09:14:20 +1100 (EST)
Received: from outmx006.isp.belgacom.be (localhost [127.0.0.1])
	by outmx006.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l1CMEBYd013388
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 23:14:12 +0100
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 00/10] Mainly 52xx patches for 2.6.21 (but not only)
Date: Mon, 12 Feb 2007 23:13:18 +0100
Message-Id: <11713184081457-git-send-email-tnt@246tNt.com>
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,


This patchset is against a recent linus clone (it relies on recent
additions) + the two patches Grant posted today.

This patch set starts with 52xx specific stuff. They've been tested
on the EFIKA and lite5200 by Grant and myself.

The last 4 patches add a unified uevent handler for bus relying on
of_device. This patch has been tested on the efika as well.
It has been posted here before and was tested then by some other
people. The problems reported then have been fixed in this version.

I hope this will make it to 2.6.21.


	Sylvain
