Return-Path: <marny@rambler.ru>
Received: from ns.tz.ru (ns.tz.ru [194.149.234.1])
	by ozlabs.org (Postfix) with ESMTP id 578DD67F0F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Aug 2005 21:10:55 +1000 (EST)
Received: from localhost (localhost.tz.ru [127.0.0.1])
	by ns.tz.ru (Postfix) with ESMTP id 03AEA178BF
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Aug 2005 15:10:52 +0400 (MSD)
Received: from ns.tz.ru ([127.0.0.1])
	by localhost (ns.tz.ru [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 28173-06 for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Aug 2005 15:10:50 +0400 (MSD)
Received: from marnat.intranet.tz.ru (marnat.intranet.tz.ru [90.0.0.18])
	by ns.tz.ru (Postfix) with ESMTP id 381F0178B6
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Aug 2005 15:10:50 +0400 (MSD)
Date: Fri, 5 Aug 2005 15:11:05 +0400
From: Igor Marnat <marny@rambler.ru>
Message-ID: <19013128171.20050805151105@rambler.ru>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: what to use to connect to JTAG/BDM port on PPC405EP
Reply-To: Igor Marnat <marny@rambler.ru>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello List!
Hope, it's not offtopic.
I have EVB based on PPC 405 EP (PPChameleon EVB). It has JTAG port.
What JTAG device can I use to connect to the board? I've found BDI2000
device, for example, but it costs as N times as the EVB does
(approximately). It seems unreasonable for me. Is it possible to make such a device or to find
find the cheaper one? We found several schemes of how to make connector BDM-parallel
port. Is it possible to do such a thing for PPC 405EP?

Regards,
Igor Marnat
mailto:marny@rambler.ru
