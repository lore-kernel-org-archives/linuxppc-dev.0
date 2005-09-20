Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 385E26832F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Sep 2005 03:42:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 20 Sep 2005 12:42:37 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B859462@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Stevan Ignjatovic" <stevan@iritel.com>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: MPC8250 MCC operating on 2-bit channels
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org Stevan Ignjatovic
> Sent: Tuesday, September 20, 2005 10:17
> Subject: MPC8250 MCC operating on 2-bit channels

> Has anybody dealt with 2-bit channels on MCC? What can cause such
> problems (remember that everything works fine with 8-bit channels). I
> would also appreciate if somebody has the possibility to implement
> similar test.

I am using 7 bit channels without any problems (tx and rx) on MCC 1 and
2.
(on an MPC8266)
Can you send me a dump of your SIRAM settings, and I'll take a look at
them?

Be aware of one thing (at least for 826x with 2 MCC's), first channel on
MCC2 is numbered 128, not 0


Rune Torgersen
