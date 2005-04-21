Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id EDD9367A33
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 03:42:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 21 Apr 2005 12:42:29 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B85936C@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Vitaly Bordug" <vbordug@ru.mvista.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: RE: [PATCH 2.6.12-rc2] Freescale 8272ADS PCI bridge support to
	thestock linux-2.5 (updated)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Another issue - I want to keep the setup of the second outbound PCI
window=20
> (pcimask1/pcibr1) - since continuous mem/mmio/io is not flexible
enough -=20
> and to keep potarx/pobarx/pocmrx assignments as they are in pq_...
version=20
> (changing of course all relative constants to _LOWER/... stuff).=20
How about initializing pcimsk1 if needed, eg have=20
#define M82XX_PCI_PRIMARY_WINDOW_SIZE
#define M82XX_PCI_PRIMARY_WINDOW_ADDR
#define M82XX_PCI_SECONDARY_WINDOW_SIZE
#define M82XX_PCI_SECONDARY_WINDOW_ADDR
And depend pcimsk1/br1 on the *_SECONDARY_WONDOW* ones

> Maybe the m8260.[c,h] should be renamed since this suites not only
826x series?
Probably to m82xx.[ch] because it is 82xx specific (I think)


Comments/objections?
