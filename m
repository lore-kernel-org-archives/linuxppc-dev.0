Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BF088B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 18:09:00 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n7788qTI018878 for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 7 Aug 2009 01:08:53 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n7789M0t011748
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 7 Aug 2009 03:09:23 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: MPC8313 performance evaluation
Date: Fri, 7 Aug 2009 16:08:50 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB1208956D03F@zch01exm21.fsl.freescale.net>
In-Reply-To: <20090806180035.GA19088@lutz.bln.innominate.local>
References: <20090806180035.GA19088@lutz.bln.innominate.local>
From: "Liu Dave-R63238" <DaveLiu@freescale.com>
To: "Lutz Jaenicke" <ljaenicke@innominate.com>, <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Some discussion with the the freescale rep. lead to the CSB frequency
> of the 8313 (166MHz) being significantly lower than that of the 8343.
> Is the CSB the critical point here?

I believe the CSB is critical point here. They are right.

> Note: the IXP42x uses an internal bus speed of 133MHz and operates
> at frame rates similar to the 8343...

It is possible, IXP42x has the differenet SoC architecture with 83xx.
