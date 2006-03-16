Return-Path: <Bjorn.Ostby@combitech.se>
Received: from ms-101.aerotechtelub.se (ms-101.aerotechtelub.se
	[192.176.33.163]) by ozlabs.org (Postfix) with ESMTP id 5CBDC679E6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Mar 2006 04:23:49 +1100 (EST)
Received: from ratatosk.combitechsystems.com (unverified) by
	ms-101.aerotechtelub.se (Clearswift SMTPRS 5.2.3) with ESMTP id
	<T7710b54ca0c0b021a3a88@ms-101.aerotechtelub.se> for
	<linuxppc-embedded@ozlabs.org>; Thu, 16 Mar 2006 18:23:45 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: 8xx SMC1 problem
Date: Thu, 16 Mar 2006 18:23:46 +0100
Message-ID: <004B1D7A5257174C9044A1B7BD0E60ED0178CC68@ratatosk.combitechsystems.com>
From: =?iso-8859-1?B?Qmr2cm4g1nN0Ynk=?= <Bjorn.Ostby@combitech.se>
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

Hello everyone,
I have a question regarding the serial init of ttyS0 on a tqm8xx based =
board (823) in denx kernel 2.4.25.

First of, I have three serial ports (SMC1, SMC2 and SCC3) and they all =
work fine when the console is on SMC1. I have gadgets connected to SMC2 =
and SCC3 and now I need SMC1 for yet another device. So I have undefined =
CONFIG_SERIAL_CONSOLE in the kernel config and I jump out of u-boot =
(which have the console on SMC1) with the argument "console=3Dnone".
When logging in (via telnet) ttyS0 works no more (but S1 and S2 does). =
At random bootups, it is possible to open the port but it is no good for =
read or write.

Can anybody give me some advise on how to enable SMC1 but at the same =
time don't have a console on it?

Regards,
Bj=F6rn
