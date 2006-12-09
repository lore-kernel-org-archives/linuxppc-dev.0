Return-Path: <tnt@246tNt.com>
Received: from outmx026.isp.belgacom.be (outmx026.isp.belgacom.be
	[195.238.4.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2BC2267B92
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 12:18:53 +1100 (EST)
Received: from outmx026.isp.belgacom.be (localhost [127.0.0.1])
	by outmx026.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kB91IgsL004920
	for <linuxppc-dev@ozlabs.org>; Sat, 9 Dec 2006 02:18:42 +0100
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Linux PPC dev list <linuxppc-dev@ozlabs.org>
Subject: [RFC/RFT] uevent: cleanup of macio and add for of_platform
Date: Sat,  9 Dec 2006 02:17:55 +0100
Message-Id: <11656270752370-git-send-email-tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everyone, Hi Ben,

Theses two patches are not heavily tested. For the macio cleanup
I just don't have any hardware to run it on, and for the of_platform
support I just tested it compiles and doesn't crash on boot.

So if you're in position of testing either, that would be
great.

	Sylvain
