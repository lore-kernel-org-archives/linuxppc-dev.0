Return-Path: <ylin@airvana.com>
Received: from airmail.wirelessworld.airvananet.com (airmail.airvananet.com
	[12.6.244.34]) by ozlabs.org (Postfix) with ESMTP id 179EEDDF1F
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jul 2007 02:02:58 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Anyone using QE UART mode?
Date: Mon, 2 Jul 2007 12:01:56 -0400
Message-ID: <8F798BFDA851B943B3A1B2510E9287850350A908@airmail.wirelessworld.airvananet.com>
In-Reply-To: <46891C6B.3090507@freescale.com>
From: "Ying Lin" <ylin@airvana.com>
To: "Timur Tabi" <timur@freescale.com>
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

OK, the missing piece (UART driver) I am looking for is not available
yet.  I will seek alternative solutions (create a simple UART driver, or
just wait).
Thanks for the information.=20
Ying=20

-----Original Message-----
From: Timur Tabi [mailto:timur@freescale.com]=20
Sent: Monday, July 02, 2007 11:40 AM
To: Ying Lin
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Anyone using QE UART mode?

Ying Lin wrote:
> How to enable TTY devices using QUICC Engine UCC UART Mode?
>=20
> Are Linux kernel patches enough to enable them?  Or, additional=20
> programming required?

I'm working on a device driver for QE UART mode, but it's not working
yet.  The QE UART is=20
like the CPM UART, but I'm having troubel getting it to work.

It is *not* trivial, or even easy, to enabled.  It's a full-blown UART
driver that also=20
deals with the complexity of the QE.

--=20
Timur Tabi
Linux Kernel Developer @ Freescale
