Return-Path: <B13201@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5CDBDB7D64
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jun 2010 14:15:09 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o574Ep7E026289
	for <linuxppc-dev@ozlabs.org>; Sun, 6 Jun 2010 21:15:02 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o574EtkF029589
	for <linuxppc-dev@ozlabs.org>; Sun, 6 Jun 2010 23:14:56 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] kvm/powerpc: fix a build error in e500_tlb.c
Date: Mon, 7 Jun 2010 12:14:48 +0800
Message-ID: <EDCBE9E543A3224FBDF456035B1919FD08DEA0@zch01exm26.fsl.freescale.net>
In-Reply-To: <2D345913-D563-40A0-AC13-BE897B6F9B4C@suse.de>
References: <1275544348-3469-1-git-send-email-haokexin@gmail.com>
	<2D345913-D563-40A0-AC13-BE897B6F9B4C@suse.de>
From: "Liu Yu-B13201" <B13201@freescale.com>
To: "Alexander Graf" <agraf@suse.de>, "Kevin Hao" <haokexin@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Marcelo Tosatti <mtosatti@redhat.com>,
	kvm@vger.kernel.org, Avi Kivity <avi@redhat.com>
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
> From: kvm-owner@vger.kernel.org=20
> [mailto:kvm-owner@vger.kernel.org] On Behalf Of Alexander Graf
> Sent: Friday, June 04, 2010 10:08 PM
> To: Kevin Hao
> Cc: Marcelo Tosatti; Kumar Gala; Avi Kivity;=20
> kvm@vger.kernel.org list; linuxppc-dev@ozlabs.org; Liu Yu-B13201
> Subject: Re: [PATCH] kvm/powerpc: fix a build error in e500_tlb.c
>=20
>=20
> On 03.06.2010, at 07:52, Kevin Hao wrote:
>=20
> > We use the wrong number arguments when invoking=20
> trace_kvm_stlb_inval,
> > and cause the following build error.
> > arch/powerpc/kvm/e500_tlb.c: In function=20
> 'kvmppc_e500_stlbe_invalidate':
> > arch/powerpc/kvm/e500_tlb.c:230: error: too many arguments=20
> to function 'trace_kvm_stlb_inval'
>=20
> Liu, I'd like to get an ack from you here.
>=20

Seems commit e43f2f741a49483034bf968841275cfa553a4cb3 has solved this.
