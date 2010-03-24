Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7F049B7CF9
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 05:32:02 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o2OIVxKC027482
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Mar 2010 11:31:59 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o2OIepLu019735
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Mar 2010 13:40:51 -0500 (CDT)
Message-ID: <4BAA5A9E.1010209@freescale.com>
Date: Wed, 24 Mar 2010 13:31:58 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: "M. Warner Losh" <imp@bsdimp.com>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
References: <90D93687-940F-47FB-8CEA-F3C065EA611D@kernel.crashing.org>	<fa686aa41003241007mf6052d5s4643795f4a87cdcf@mail.gmail.com>	<4BAA4C8A.70104@freescale.com>
	<20100324.122428.1108826596399277216.imp@bsdimp.com>
In-Reply-To: <20100324.122428.1108826596399277216.imp@bsdimp.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

M. Warner Losh wrote:

> Is there some reason that the firmware couldn't be loaded by uboot as
> part of its initialization?

Unfortunately, our hardware is frequently designed such that the same firmware needs to be loaded by U-Boot and then again by the kernel.

-- 
Timur Tabi
Linux kernel developer at Freescale
