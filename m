Return-Path: <imp@bsdimp.com>
Received: from harmony.bsdimp.com (bsdimp.com [199.45.160.85])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1919BB7CF9
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 05:38:34 +1100 (EST)
Date: Wed, 24 Mar 2010 12:24:28 -0600 (MDT)
Message-Id: <20100324.122428.1108826596399277216.imp@bsdimp.com>
To: timur@freescale.com
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
From: "M. Warner Losh" <imp@bsdimp.com>
In-Reply-To: <4BAA4C8A.70104@freescale.com>
References: <90D93687-940F-47FB-8CEA-F3C065EA611D@kernel.crashing.org>
	<fa686aa41003241007mf6052d5s4643795f4a87cdcf@mail.gmail.com>
	<4BAA4C8A.70104@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In message: <4BAA4C8A.70104@freescale.com>
            Timur Tabi <timur@freescale.com> writes: 
: Most firmware is 8-12KB, so this will make for one ugly DTS.  Plus,
: there's the issue of distributing non-GPL firmware data inside a
: DTS, which is GPL.

Is there some reason that the firmware couldn't be loaded by uboot as
part of its initialization?

Warner
