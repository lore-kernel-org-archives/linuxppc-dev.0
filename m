Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id D58B8DDEDD
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 17:41:51 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l1Q6flbB025457
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Feb 2007 23:41:47 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l1Q6fjZB022495
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 00:41:46 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [RFC 2/7] Unite all PCI-e on 85xx and 86xx under one codebase
Date: Mon, 26 Feb 2007 14:41:44 +0800
Message-ID: <7EA18FDD2DC2154AA3BD6D2F22A62A0E5AD638@zch01exm23.fsl.freescale.net>
In-Reply-To: <EE5E84C5-87F0-4836-AE28-1EE0E2CC556C@kernel.crashing.org>
References: <Pine.LNX.4.61.0702152043270.9034@ld0175-tx32.am.freescale.net>
	<EE5E84C5-87F0-4836-AE28-1EE0E2CC556C@kernel.crashing.org>
From: "Zang Roy-r61911" <tie-fei.zang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Fleming Andy-afleming" <afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
> On Feb 15, 2007, at 8:44 PM, Andy Fleming wrote:
>=20
> > Add 85xx PCI express memory map register.
> >
> > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> > Acked-by: Andy Fleming <afleming@freescale.com>
> > ---
> >  include/asm-ppc/immap_85xx.h |   75=20
> +++++++++++++++++++++++++++++++=20
> > +++++++++++
> >  1 files changed, 75 insertions(+), 0 deletions(-)
>=20
> Are the 86xx and 85xx structs the same?  If so, can we pull=20
> them out of immap_*.h into a sysdev/fsl_pcie.h
>=20
> (and lose the typedef while you're at it).
They have same structs. But I do not think it is proper to move them
into =20
sysdev/fsl_pcie.h now. sysdev/fsl_pcie.c does not use  this header file.
plaforms/85xx/pci.c use it to set up memory map windows.=20
In fact, there is little difference between immap_85xx.h and
immap_86xx.h.=20
After the migration from ppc to powerpc, we can unify them together.
