Return-Path: <craig.d.smith@siemens.com>
Received: from brmx1.boca.ssc.siemens.com (brmx1.fl.icn.siemens.com
	[12.147.96.32]) by ozlabs.org (Postfix) with ESMTP id 5EAB12BD7B
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2004 23:58:19 +1000 (EST)
Message-ID: <EA78B62757AF1E4799828249310AC4CA071D2814@stca206a.bus.sc.rolm.com>
From: "Smith, Craig" <craig.d.smith@siemens.com>
To: "'Pantelis Antoniou'" <panto@intracom.gr>, Dan Malek <dan@embeddededge.com>
Date: Fri, 17 Sep 2004 06:57:38 -0700
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

>> I seem to be able ro run it OK on 8xx with an extra patch
>> that most people (including Dan :) ) find gross.
I don't mind gross patches....could you point me to this patch?

>> Use the new ethernet & serial drivers (fec_8xx & cpm_uart),
>> and try again.
Ah ha...I didn't even notice that since it wasn't showing up
in my menuconfig (depends on NETTA). Thanks I'll try it.

Regards,
-Craig
