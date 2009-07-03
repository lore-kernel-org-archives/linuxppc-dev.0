Return-Path: <Yu.Liu@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 06ADEB70F4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 11:35:10 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 94032DDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 11:35:08 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n631Z3og025769
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Jul 2009 18:35:04 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n631Z2FI017489
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Jul 2009 20:35:02 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH 1/2] KVM/PPC: Fix PPC KVM e500_tlb.c build error
Date: Fri, 3 Jul 2009 09:35:00 +0800
Message-ID: <0A1FE637C2C7E148B9573BB60CC630E531C70E@zch01exm26.fsl.freescale.net>
In-Reply-To: <4A4C97C4.9090908@redhat.com>
References: <47a7508d4561874c1a052cebe1b7f42b19831393.1246502441.git.yang.shi@windriver.com>
	<0A1FE637C2C7E148B9573BB60CC630E531C59D@zch01exm26.fsl.freescale.net>
	<4A4C97C4.9090908@redhat.com>
From: "Liu Yu-B13201" <Yu.Liu@freescale.com>
To: "Avi Kivity" <avi@redhat.com>
Cc: linuxppc-dev@ozlabs.org, Yang Shi <yang.shi@windriver.com>,
	kvm-ppc@vger.kernel.org, hollisb@us.ibm.com, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Avi Kivity [mailto:avi@redhat.com]=20
> Sent: Thursday, July 02, 2009 7:20 PM
> To: Liu Yu-B13201
> Cc: Yang Shi; hollisb@us.ibm.com; kvm-ppc@vger.kernel.org;=20
> kvm@vger.kernel.org; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 1/2] KVM/PPC: Fix PPC KVM e500_tlb.c build error
>=20
> On 07/02/2009 06:09 AM, Liu Yu-B13201 wrote:
> > This fix is already accepted in kvm.git
> >   =20
>=20
> What about the other?  Is it needed?
>=20

No, it's already fixed by commit =
b57227e600f4ecc394d6ba3c2aaa558867b5addc.
