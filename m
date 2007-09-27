Return-Path: <dgaur@cdotd.ernet.in>
Received: from sandesh.cdotd.ernet.in (sandesh.cdotd.ernet.in [196.1.105.47])
	by ozlabs.org (Postfix) with ESMTP id 435F3DDE33
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 19:22:21 +1000 (EST)
Received: from sandesh.cdotd.ernet.in (localhost [127.0.0.1])
	by localhost.cdotd.ernet.in (Postfix) with ESMTP id A0568CFC71
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 14:51:52 +0530 (IST)
Received: from mail1.cdotd.ernet.in (mail1.cdotd.ernet.in [196.1.105.196])by
	sandesh.cdotd.ernet.in (Postfix) with ESMTP id 5BEC9CFC66for
	<linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 14:51:52 +0530 (IST)
Received: from cdotd.ernet.in (localhost.localdomain [127.0.0.1])by
	mail1.cdotd.ernet.in (8.12.5/8.12.5) with ESMTP id l8R9dnB7027113for
	<linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 15:09:49 +0530
From: "Deepak Gaur" <dgaur@cdotd.ernet.in>
To: linuxppc-dev@ozlabs.org
Subject: Linux 2.6.22 Serial Core 
Date: Thu, 27 Sep 2007 16:09:49 +0630
Message-Id: <20070927093521.M77586@cdotd.ernet.in>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

Just a small question! The serial core driver file located in drivers/serial directory
(drivers/serial/serial_core.c) does not have module_init() and module_exit() function
called though CONFIG_SERIAL_CORE flag is seperately defined in Kconfig and is used in
makefile. Any idea why these functions are not called in this particular file??

with regards,

Deepak Gaur
