Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8FCD4DE001
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 23:53:32 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n0JCrCvg016714
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 05:53:17 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n0JCrBMe013504
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 06:53:11 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: MPC8313 init ram
Date: Mon, 19 Jan 2009 20:53:05 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB1208907B0FA@zch01exm21.fsl.freescale.net>
In-Reply-To: <BLU127-W329ABEB411D1862CA610B9B5D30@phx.gbl>
References: <BLU127-W329ABEB411D1862CA610B9B5D30@phx.gbl>
From: "Liu Dave" <DaveLiu@freescale.com>
To: "??" <noname1.c@hotmail.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Now i'm porting the u-boot to my board refer to the mpc8313erdb.
> I see that in the header file mpc8313erdb.h there is a define:=20
> #define CFG_INIT_RAM_ADDR 0xFD000000
> In the memory map ,this address does not locate at any window.
> So what is the ram?

xiangyu,

It is one trick, we are using the L1-data cache as RAM before the DDR
memory is available.

It is one question about u-boot, please send it to u-boot@lists.denx.de
in the future.

Thanks, Dave=20
