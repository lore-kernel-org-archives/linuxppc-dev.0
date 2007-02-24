Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 254D3DDEE3
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 25 Feb 2007 09:21:35 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: CPM FCC1 & FCC2
Date: Sat, 24 Feb 2007 14:19:02 -0800
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C069AED@MERCURY.inside.istor.com>
References: <OFA2B855F5.8FEEC16C-ON8825728C.000C6AC9-8825728C.000C740E@selinc.com>
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C069AEA@MERCURY.inside.istor.com>
From: "Charles Krinke" <ckrinke@istor.com>
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

In our design for an 8541 board, we are going to be using FCC1 & FCC2 in =
addition to the FAST controller.
=20
I have been looking through the Linux-2.6.17.11 source we are using and =
although I can find some references to MPC85xx_CPM_FCC1, I cannot quite =
identify the driver used with the 85xx in Linux.
=20
Can someone help me determine the name of the appropriate driver for the =
two FCC sections of the 8541 please?
=20
Charles
=20
=20
