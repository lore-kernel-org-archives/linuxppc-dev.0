Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6641847506
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jan 2009 12:47:10 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n0A1ko2J020873
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jan 2009 18:47:01 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n0A1kmcw017337
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jan 2009 19:46:49 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: RE: mpc8313erdb NAND memory map
Date: Sat, 10 Jan 2009 09:46:43 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB12089056F37@zch01exm21.fsl.freescale.net>
In-Reply-To: <BLU127-W16393EFA5B15DFDE1AA9FBB5DA0@phx.gbl>
References: <BLU127-W16393EFA5B15DFDE1AA9FBB5DA0@phx.gbl>
From: "Liu Dave" <DaveLiu@freescale.com>
To: =?gb2312?B?z/LT7g==?= <noname1.c@hotmail.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I'm using the MPC8313ERDB.I readed the BSP user manual.
> I found  the NAND is 32M bytes.
> But in the UM's memory map,it is only from 0xe280_0000 to=20
> 0xe280_7fff,just 32K bytes.
> Can anyone help to understand this problem? =20

It is indirect access the NAND flash by 8313,
the 8313 has to use one window to access NAND.
that is 32K window. The behavior is not same NOR.

If want to know more detail, please read 8313 UM.
