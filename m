Return-Path: <SRS0=q2Dt=QN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E21CC282CB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 01:48:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F8BE2184E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 01:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="W4gdY4us"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8BE2184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43vPVS4YQgzDqMn
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 12:48:32 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43vPSP5gHszDqLZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 12:46:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="W4gdY4us"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43vPSP3qT7z9sDL; Wed,  6 Feb 2019 12:46:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549417605;
 bh=Wlrhs/VmGfvxgh05kB2I0vk6dzwWMgMl8d7lvXyV0rA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W4gdY4usODdy8hpvuAxMP0M2LD+y50Kbm/ntiqxbWt8CWs+ssc5cDsaYKfDlDA213
 7/Bj+5sr//j3WivJXVO74zkd4x7w7LIL8NpfaUzAWajPzYtPvqtzOrTzRDe+L3Yjhb
 jtee89vOGhKgE7Uuen5zby1x/EdTDOW0UGnwFUkA=
Date: Wed, 6 Feb 2019 12:19:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 17/19] KVM: PPC: Book3S HV: add get/set accessors for the
 VP XIVE state
Message-ID: <20190206011919.GO22661@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107191006.10648-1-clg@kaod.org>
 <20190204052646.GJ1927@umbus.fritz.box>
 <5ebeb37b-623b-9b82-5628-fd6d78382064@kaod.org>
 <20190205053331.GH22661@umbus.fritz.box>
 <5e18629d-8aaf-1e20-46a1-64095da18bfb@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wxIXENaY2CYUgF8u"
Content-Disposition: inline
In-Reply-To: <5e18629d-8aaf-1e20-46a1-64095da18bfb@kaod.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--wxIXENaY2CYUgF8u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 12:58:54PM +0100, C=E9dric Le Goater wrote:
> On 2/5/19 6:33 AM, David Gibson wrote:
> > On Mon, Feb 04, 2019 at 07:57:26PM +0100, C=E9dric Le Goater wrote:
> >> On 2/4/19 6:26 AM, David Gibson wrote:
> >>> On Mon, Jan 07, 2019 at 08:10:04PM +0100, C=E9dric Le Goater wrote:
> >>>> At a VCPU level, the state of the thread context interrupt management
> >>>> registers needs to be collected. These registers are cached under the
> >>>> 'xive_saved_state.w01' field of the VCPU when the VPCU context is
> >>>> pulled from the HW thread. An OPAL call retrieves the backup of the
> >>>> IPB register in the NVT structure and merges it in the KVM state.
> >>>>
> >>>> The structures of the interface between QEMU and KVM provisions some
> >>>> extra room (two u64) for further extensions if more state needs to be
> >>>> transferred back to QEMU.
> >>>>
> >>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>> ---
> >>>>  arch/powerpc/include/asm/kvm_ppc.h    |  5 ++
> >>>>  arch/powerpc/include/uapi/asm/kvm.h   |  2 +
> >>>>  arch/powerpc/kvm/book3s.c             | 24 +++++++++
> >>>>  arch/powerpc/kvm/book3s_xive_native.c | 78 ++++++++++++++++++++++++=
+++
> >>>>  4 files changed, 109 insertions(+)
> >>>>
> >>>> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/inclu=
de/asm/kvm_ppc.h
> >>>> index 4cc897039485..49c488af168c 100644
> >>>> --- a/arch/powerpc/include/asm/kvm_ppc.h
> >>>> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> >>>> @@ -270,6 +270,7 @@ union kvmppc_one_reg {
> >>>>  		u64	addr;
> >>>>  		u64	length;
> >>>>  	}	vpaval;
> >>>> +	u64	xive_timaval[4];
> >>>>  };
> >>>> =20
> >>>>  struct kvmppc_ops {
> >>>> @@ -603,6 +604,8 @@ extern void kvmppc_xive_native_cleanup_vcpu(stru=
ct kvm_vcpu *vcpu);
> >>>>  extern void kvmppc_xive_native_init_module(void);
> >>>>  extern void kvmppc_xive_native_exit_module(void);
> >>>>  extern int kvmppc_xive_native_hcall(struct kvm_vcpu *vcpu, u32 cmd);
> >>>> +extern int kvmppc_xive_native_get_vp(struct kvm_vcpu *vcpu, union k=
vmppc_one_reg *val);
> >>>> +extern int kvmppc_xive_native_set_vp(struct kvm_vcpu *vcpu, union k=
vmppc_one_reg *val);
> >>>> =20
> >>>>  #else
> >>>>  static inline int kvmppc_xive_set_xive(struct kvm *kvm, u32 irq, u3=
2 server,
> >>>> @@ -637,6 +640,8 @@ static inline void kvmppc_xive_native_init_modul=
e(void) { }
> >>>>  static inline void kvmppc_xive_native_exit_module(void) { }
> >>>>  static inline int kvmppc_xive_native_hcall(struct kvm_vcpu *vcpu, u=
32 cmd)
> >>>>  	{ return 0; }
> >>>> +static inline int kvmppc_xive_native_get_vp(struct kvm_vcpu *vcpu, =
union kvmppc_one_reg *val) { return 0; }
> >>>> +static inline int kvmppc_xive_native_set_vp(struct kvm_vcpu *vcpu, =
union kvmppc_one_reg *val) { return -ENOENT; }
> >>>
> >>> IIRC "VP" is the old name for "TCTX".  Since we're using tctx in the
> >>> rest of the XIVE code, can we use it here as well.
> >>
> >> OK. The state we are getting or setting is indeed related to the threa=
d=20
> >> interrupt  context registers.=20
> >>
> >> The name VP is related to an identifier to some interrupt context unde=
r=20
> >> OPAL (NVT in HW to be precise).
> >=20
> > Oh, sorry, "NVT" was the name I was looking for, not "TCTX".  But in
> > any case, please lets standardize on one.
>=20
> There is some confusion in the naming for :
>=20
>  - VP    Virtual Processor (XIVE 1)
>  - VPD   Virtual Processor Descriptor (XIVE 1)
>  - TCTX  Thread interrupt context registers
>  - NVT   Notify Virtual Target. Former VP.=20
>  - NVTS  Notify Virtual Target Structure. Where the TCTX regs are cached.
>=20
>=20
> I am fine with using NVT because this is indeed the name of the XIVE=20
> structure where the HW caches the thread interrupt context registers.
>=20
> But the XIVE native layer and the XICS-over-XIVE KVM device use the
> name VP (the old one). I don't think we want to change these now.

Ah, right.  It now occurs to me that the place I've already seen NVT
used is in the qemu code, whereas this is kernel.  In that case
sticking to VP here makes sense.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wxIXENaY2CYUgF8u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxaNhcACgkQbDjKyiDZ
s5JuEA/+JBP+b7apnWnUEMhOgR5YTzJdg3vzP4d8WkpDo8K5eQ0zv8F6bRS5MR+b
wVAB7jVANY9eC1lwtD4rVYuI7XOBJcEt9B51MJGYPG1QkejmL87nYNjcFPis5Gm3
vwVEjGUgjB9J/Qy7ICM4Cd3gzK1r27kRgyqzV3I0yigxiSmVppM20VpaKgOQouwE
tO99nGSeomRDhZroVSOKp883UzGa+oRJ6V7noCabpQHu8nPGXmQzVPTuy7gEkA7O
yz6gxDFT6t+uJocEq0CV9AgV4uKQm1fLzVJOMjngUsPJ/2VsZBUgBQTfapvg9bdA
KBdcZapQubuxhmtwb0+pqWqZj2MgwfTml95lGpuEyO0ijnqbYJVvAgjmEjRnB+1D
B6AW4R7jr5mXWyi8u2J7x9uQ6ezXmBGc8AWkQiMmtStN1m+w+vqOqu4fhFK6Buac
SLYPVAq4FuxxIiewoI/z/by/ihtVNPWtxUwqPHVqbGJ2mnw/4fZWqCDpUFQ6CKRr
ux3WBHhNAa8+0yAG4BbA1L6pRABVLues9dVOgem6dxJ1uXIAIjwgb+FvyANQoZ/4
318NI2Pu06S7GKtYUOz+0uJk26LJJyNmg+GIczSBHhAvsO0EAf80t+jzov0PV+fp
z97VIRCYb4wGhxyAUfDD1shuphPQ0gLUDKWsvfWK0W3amHIjFVc=
=5iFE
-----END PGP SIGNATURE-----

--wxIXENaY2CYUgF8u--
