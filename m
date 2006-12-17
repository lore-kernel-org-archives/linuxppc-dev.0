Return-Path: <tnt@246tNt.com>
Received: from outmx004.isp.belgacom.be (outmx004.isp.belgacom.be
	[195.238.4.101])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2BA0467BE5
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Dec 2006 03:52:45 +1100 (EST)
Received: from outmx004.isp.belgacom.be (localhost [127.0.0.1])
	by outmx004.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kBHGqcCK019167
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Dec 2006 17:52:39 +0100
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/3] uevents handler for macio & of_platform
Date: Sun, 17 Dec 2006 17:51:15 +0100
Message-Id: <11663742771972-git-send-email-tnt@246tNt.com>
Cc: Linux PPC Devel <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul, Hi Ben, and Hi everyone ;)

This couple of patch is a rework of the uevent handler in macio and
of_platform. For macio, it was present but not using the latest
helper that makes the code more readable. The of_platform one
is new (no uevent support in of_platform before) but is basically
the same code as the macio one.

The of_platform one has been tested on Efika and enable module
autoloading by udev. The macio patch is not tested. However,
being based on the same code as the of_platform handler I would
excpect it to be fine.


	Sylvain

PS: The previous one I sent a few weeks back were buggy, theses
are new ones ;)
