Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A53ADDDE98
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 18:03:29 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3273Lnh019214
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Apr 2009 00:03:22 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n3273JUt017082
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Apr 2009 02:03:20 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: USB drivers
Date: Thu, 2 Apr 2009 15:03:20 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED2FAF28@zch01exm26.fsl.freescale.net>
In-Reply-To: <722080.36173.qm@web83502.mail.sp1.yahoo.com>
References: <722080.36173.qm@web83502.mail.sp1.yahoo.com>
From: "Li Yang-R58472" <LeoLi@freescale.com>
To: <ron_madrid@sbcglobal.net>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I have a custom board based on the MPC8313ERDB and have=20
> communications capabilities over Ethernet using internet=20
> sockets.  Basically, just data transfer from the host (my=20
> board) to a client (a PC).  I want to be able to perform=20
> similar transactions across USB.
>=20
> I have done some cursory reading but am a little unclear on=20
> how I should approach this.  Am I going to have to write a=20
> host driver for my custom board, and also write a gadget=20
> driver for any client machine?  Also, since I am desiring to=20
> do simple data transfers only, which drivers could I use as a=20
> point of reference for my application?
>=20
> Thanks in advance for any tips and suggestions.

Linux has a g_ether gadget, which can simulate a ethernet tunnal over
USB.  If you already have the communication code through ethernet, it
will be easier to make use of that gadget.  However, it has more
overhead than pure usb transactions.  The best way is like you said,
custom gadget driver and host driver.

- Leo
