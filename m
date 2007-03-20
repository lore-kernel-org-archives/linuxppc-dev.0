Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id C9452DDF52
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 20:51:42 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l2K9pDDB011755
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 02:51:22 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2K9pC2I016868
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 04:51:13 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: RE: [PATCH 4/4] Add irq debugfs and virq_mapping for getting thevirq
	to irq host's hwirq mapping list.
Date: Tue, 20 Mar 2007 17:51:09 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C132437@zch01exm26.fsl.freescale.net>
In-Reply-To: <1174359820.10827.8.camel@concordia.ozlabs.ibm.com>
References: <11740199151814-git-send-email-wei.zhang@freescale.com>
	<11740199152595-git-send-email-wei.zhang@freescale.com>
	<11740199154116-git-send-email-wei.zhang@freescale.com>
	<11740199152381-git-send-email-wei.zhang@freescale.com>
	<1174359820.10827.8.camel@concordia.ozlabs.ibm.com>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: <michael@ellerman.id.au>
Cc: Wang Haiying-r54964 <Haiying.Wang@freescale.com>, paulus@samba.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>=20
> Minor nit. Should we be creating a 'powerpc' directory first, and
> putting the 'irq' file under that? Otherwise we risk clashing=20
> with some
> generic code that creates a file called 'irq' in debugfs.
>=20
> cheers
>=20
Hi, Michael,

I've seen some codes in arch/powerpc/kernel/prom.c to create debugfs dir =
"powerpc". But those codes were enabled by a local macro 'DEBUG'. There =
is a little problem. Maybe I should change '#ifdef DEBUG' to '#ifdef =
CONFIG_DEBUG_FS' before the export_flat_device_tree() function in =
arch/powerpc/kernel/prom.c. How about it?

Thanks!

Best Regards
Zhang Wei
