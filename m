Return-Path: <ylin@airvana.com>
Received: from airmail.wirelessworld.airvananet.com (airmail.airvananet.com
	[12.6.244.34]) by ozlabs.org (Postfix) with ESMTP id 0507DDDF0C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jul 2007 23:16:55 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Anyone using QE UART mode?
Date: Tue, 3 Jul 2007 09:15:51 -0400
Message-ID: <8F798BFDA851B943B3A1B2510E9287850350A90D@airmail.wirelessworld.airvananet.com>
In-Reply-To: <989B956029373F45A0B8AF0297081890D83844@zch01exm26.fsl.freescale.net>
From: "Ying Lin" <ylin@airvana.com>
To: "Li Yang-r58472" <LeoLi@freescale.com>,
	"Tabi Timur-B04825" <timur@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> Which chip are you using?  There should be separate 16550 compatible
> UART controller on MPC8360.  The driver is already there and working
> pretty well.

We are using MPC8323E.  We have 2 working serial ports from the DUART
controller, but we need more than 2.

We have about 4 weeks to make them working, any suggestion where to
start?  We plan to start with CW QE Utility generated codes.

Thanks,
Ying
