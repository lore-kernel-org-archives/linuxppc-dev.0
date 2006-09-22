Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 8916467B83
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 12:36:55 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k8M2asHV026444
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 19:36:54 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k8M2apGD019020
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 21:36:53 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 2/11] qe_lib: Add common files
Date: Fri, 22 Sep 2006 10:37:27 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D19D2F8@zch01exm20.fsl.freescale.net>
In-Reply-To: <F6AD7E21CDF4E145A44F61F43EE6D9399B44FE@tmnt04.transmode.se>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Joakim Tjernlund [mailto:joakim.tjernlund@transmode.se]
> Sent: Thursday, September 21, 2006 11:22 PM
> To: Li Yang-r58472; linuxppc-dev@ozlabs.org
> Subject: RE: [PATCH 2/11] qe_lib: Add common files
>=20
> > diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
> > +#define QE_MURAM_DATAONLY_BASE	((uint)0x0)
> > +#define QE_MURAM_NOSPACE		((uint)0x7fffffff)
> > +#define QE_MURAM_DATAONLY_SIZE	((uint)(48 * 1024) -
> > QE_MURAM_DATAONLY_BASE)
>=20
> QE_MURAM_DATAONLY_SIZE is 16*1024 on 8321
>=20
> Also, you have line wrapping that has mangled all long lines in all
> patches.

No, not for this time.  Maybe your mail client wrapped them.

- Leo
