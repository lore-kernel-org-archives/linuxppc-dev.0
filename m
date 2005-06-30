Return-Path: <markc@mail.com>
Received: from relay01.roc.ny.frontiernet.net (relay01.roc.ny.frontiernet.net
	[66.133.182.164]) by ozlabs.org (Postfix) with ESMTP id EDED767A5C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jul 2005 00:03:56 +1000 (EST)
Message-ID: <006201c57d7c$b36bcb90$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Samuel Osorio Calvo" <samuel.osorio@nl.thalesgroup.com>,
	<linuxppc-embedded@ozlabs.org>
References: <s2c4153f.011@scms1.sc.signaal.nl>
Date: Thu, 30 Jun 2005 10:04:46 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: eth0 autonegotation 8260
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>We are using a 8260 processor with ELDK 3.1.1,  kernel 2.4.25 patched with
lck1. We have configured the kernel with USE_MDIO >and LXT971.
>The problem we face is that the boot process stops after displaying the
configuration of the card:
>eth0: config: autonegotiation on, 100FDX,...
>and after the board seems to freeze.
>
>Can anybody provide some feedback on how to check what can be misconfigured
or where to look for the error???

Check that the interrupt from the LXT971 is configured correctly.
The code is probably waiting for this interrupt to tell it that negotiation
is complete

Mark Chambers
