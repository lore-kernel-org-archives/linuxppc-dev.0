Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 51DF8DDEEA
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 19:46:11 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m4F9ipGW023023
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 02:45:20 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m4F9ioVv005327
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 04:44:51 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] Defer processing of interrupts when the CPU wakes from
	sleepmode
Date: Thu, 15 May 2008 17:44:49 +0800
Message-ID: <58A20A281BAF1047B4EAE68DE5C0BDC2F16B2A@zch01exm21.fsl.freescale.net>
In-Reply-To: <18476.685.486338.465621@cargo.ozlabs.ibm.com>
References: <18474.27384.524310.787499@cargo.ozlabs.ibm.com><58A20A281BAF1047B4EAE68DE5C0BDC2F168CF@zch01exm21.fsl.freescale.net>
	<18476.685.486338.465621@cargo.ozlabs.ibm.com>
From: "Liu Dave" <DaveLiu@freescale.com>
To: "Paul Mackerras" <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

<snip>

Thanks Paul.

> > So, does power management patch from Scott Wood need to respin?
>=20
> No, because Scott's original patch did that too.

Yes, one of scott's patchset did the same function too. So the patch
http://patchwork.ozlabs.org/linuxppc/patch?id=3D18182
will conflict with your patch.

That is why I asked you if we have to repsin scott's patchset.

If have not feedback for Scott's patch,
Could you merge Scott's power management to main tree?

BTW, I noticed the NAP mode for 6xx didn't work for 83xx part.
Did you try it on the other 6xx part?

Thanks,
Dave
