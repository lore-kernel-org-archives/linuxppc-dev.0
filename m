Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw2.extranet.tce.com (dmzraw2.extranet.tce.com
	[157.254.234.138]) by ozlabs.org (Postfix) with ESMTP id DB46F2BDAB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Sep 2004 09:04:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 28 Sep 2004 15:50:26 +0200
Message-ID: <2C1BAF8F8E1DD611862B0002A5D4C3FC02B6D151@renexch3.rennes.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "Linux PowerPC Embedded Mailinglist" <linuxppc-embedded@ozlabs.org>
Cc: Marc Leeman <marc.leeman@gmail.com>
Subject: RE: throughput question
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> I am currently working on a 8245 based board with 2.4.27 e100 driver
> and when taking in (and processing streams), only about 50 Mbps can be
> handled: about half of the time is based in kernel space (handling
> interrupts).

Is your e100 driver having NAPI support?
What's the cache size of your cache system? Do you make use of smart
coherency access? What about prefetch's?

What's the throughput(and overhead) of your application on the loopback =
device?


> As a result, I am a bit wondering about the higher bitrates. How much
> do you achieve on tests with what hardware?

Good question. IMHO, every manufacturer should advertise these values.
Shouldn't they be proud of them?


Regards,

--=20
Stephane
