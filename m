Return-Path: <craig.d.smith@siemens.com>
Received: from brmx1.boca.ssc.siemens.com (brmx1.fl.icn.siemens.com
	[12.147.96.32]) by ozlabs.org (Postfix) with ESMTP id D95D92BD6A
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2004 05:42:26 +1000 (EST)
Received: from fdns2.rolm.com (localhost [127.0.0.1])
	by brmx1.boca.ssc.siemens.com (8.12.10/8.12.10) with ESMTP id
	i8GIuR6u028463
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2004 14:56:28 -0400
Received: from stca200a.bus.sc.rolm.com (stca200a.bus.sc.rolm.com
	[165.218.68.180])
	by fdns2.rolm.com (8.12.10/8.12.10) with ESMTP id i8GIuR5T009432
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2004 11:56:27 -0700 (PDT)
Message-ID: <EA78B62757AF1E4799828249310AC4CA071D280D@stca206a.bus.sc.rolm.com>
From: "Smith, Craig" <craig.d.smith@siemens.com>
To: linuxppc-dev@ozlabs.org
Date: Thu, 16 Sep 2004 11:56:18 -0700
MIME-Version: 1.0
Content-Type: text/plain
Subject: Linux 2.6.x on 8xx status
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,
Can someone please tell me the current "status" of the
2.6.9-rc2 kernel source (a bitkeeper clone of linuxppc-2.5)?
I can compile and run it (with a minor modification to fec.c),
but I see random "Oops: kernel access of bad area" messages
when init runs, or other busybox tools run. Sometimes I boot
up (same file system etc.) and I see no errors. I can provide
more details if anyone's interested.

Right now, I just want to know if I should expect to see funny
behavior from this particular source tree on an 8xx platform or
should it work OK? Thanks so much.

Regards,
-Craig
