Return-Path: <tnt@246tNt.com>
Received: from outmx012.isp.belgacom.be (outmx012.isp.belgacom.be
	[195.238.5.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C134967B6C
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 09:48:08 +1100 (EST)
Received: from outmx012.isp.belgacom.be (localhost [127.0.0.1])
	by outmx012.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kBIMm0YJ006323
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Dec 2006 23:48:01 +0100
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/3] uevents handler for macio & of_platform
Date: Mon, 18 Dec 2006 23:46:35 +0100
Message-Id: <1166481999359-git-send-email-tnt@246tNt.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux PPC Devel <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everyone,

Same goal as the previous version : provide uvent handler where needed.

This version place the core of the code in of_device.c and then
each bus type just need a small stub and call the generic function.

Again, of_platform hook tested on the efika.
I hope this one is the good take ;)

        Sylvain
