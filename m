Return-Path: <Martin.Leisner@xerox.com>
Received: from wvmler1.mail.xerox.com (wvmler1.mail.xerox.com [13.8.138.216])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wvmler1.mail.xerox.com",
	Issuer "wvmler1.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 40766DDF1B
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 04:24:57 +1000 (EST)
Received: from wvmlir2.mail.xerox.com (wvmlir2.mail.xerox.com [13.147.8.222])
	by wvmler1.mail.xerox.com (8.13.8/8.13.6) with ESMTP id
	l86IOsgd020228
	for <linuxppc-embedded@ozlabs.org>; Thu, 6 Sep 2007 11:24:54 -0700
Received: from wvmlir2.mail.xerox.com (localhost [127.0.0.1])
	by wvmlir2.mail.xerox.com (8.13.8/8.13.6) with ESMTP id l86IOk77015659
	for <linuxppc-embedded@ozlabs.org>; Thu, 6 Sep 2007 11:24:46 -0700
Received: from USA7061GW002.na.xerox.net (usa7061gw002.na.xerox.net
	[13.151.210.15])
	by wvmlir2.mail.xerox.com (8.13.8/8.13.6) with ESMTP id l86IOiOw015604
	for <linuxppc-embedded@ozlabs.org>; Thu, 6 Sep 2007 11:24:46 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: finding out the processor frequency
Date: Thu, 6 Sep 2007 14:24:30 -0400
Message-ID: <556445368AFA1C438794ABDA8901891C06460054@USA0300MS03.na.xerox.net>
From: "Leisner, Martin" <Martin.Leisner@xerox.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

What exactly do we mean by "timebase"?

There a symbol in arch/powerpc/time.c:ppc_proc_freq which looks like the
processor frequency (derived from the dts).  But its not exported.

There's also ppc_tb_freq.

marty
