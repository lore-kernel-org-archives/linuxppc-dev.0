Return-Path: <craig.d.smith@siemens.com>
Received: from mail.siemenscom.com (mail.siemenscom.com [12.146.131.10])
	by ozlabs.org (Postfix) with ESMTP id 7C8C42BDA6
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 22:17:40 +1000 (EST)
Message-ID: <EA78B62757AF1E4799828249310AC4CA071D281F@stca206a.bus.sc.rolm.com>
From: "Smith, Craig" <craig.d.smith@siemens.com>
To: "'Song Sam'" <samlinuxppc@yahoo.com.cn>,
	Pantelis Antoniou <panto@intracom.gr>
Date: Tue, 21 Sep 2004 04:59:30 -0700
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
Subject: RE: Linux 2.6.x on 8xx status
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Guess what? It WORKED!!! Just one more line make it.
> Could you pls tell us the theory in it if not too
> complicated? :-)
Genius. That patch appears to work for me as well.

However, I'm still not able to debug via gdb/BDI2000.
I'm getting the ol' "MMU: address translation for 0xc----- failed".
I'm using the same BDI config file that works fine for debugging
a 2.4.26 kernel on the same hardware, I've verified that I have
CONFIG_BDI_SWITCH=y etc. Is this another known issue with 2.6
on 8xx platforms? Has anyone had success debugging via BDI2000 on an 8xx
board?
If so, could you share your config file or hints as to why it should behave
differently (i.e. not work) with a 2.6 kernel? Thanks.

Regards,
-Craig
