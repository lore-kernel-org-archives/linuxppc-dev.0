Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2AE05DE2A8
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 17:11:17 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n0F6BEsa006652
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 23:11:14 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n0F6BC5V008141
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 00:11:13 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] mmc: Add driver for Freescale eSDHC controllers
Date: Thu, 15 Jan 2009 14:11:09 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB1208907ACF9@zch01exm21.fsl.freescale.net>
In-Reply-To: <20090115065502.1b719b06@mjolnir.drzeus.cx>
References: <20090114194631.GA25978@oksana.dev.rtsoft.ru><D7CCA83BB0796C49BC0BB53B6AB1208907ABDB@zch01exm21.fsl.freescale.net><20090114235605.GA13531@oksana.dev.rtsoft.ru>
	<20090115065502.1b719b06@mjolnir.drzeus.cx>
From: "Liu Dave" <DaveLiu@freescale.com>
To: "Pierre Ossman" <drzeus-mmc@drzeus.cx>, <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org,
	D'Abbraccio Joe-LJD015 <Joe.D'abbraccio@freescale.com>,
	linux-kernel@vger.kernel.org, Lai Kon-LKL001 <Konjin.Lai@freescale.com>,
	Xie Xiaobo-R63061 <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Probably because it was quicker. Samsung did the same thing, but now
> Ben Dooks has patches to properly support it via sdhci.

Pierre,
What samsung driver are you talking? Could you point it to me?

Thanks, Dave
