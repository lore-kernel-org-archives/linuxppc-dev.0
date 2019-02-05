Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08095C282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 05:41:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 735B120821
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 05:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="OYYzXvYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 735B120821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ttk16ClzzDqKr
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 16:41:45 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ttfM3kFBzDqKf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 16:38:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="OYYzXvYA"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43ttfM2Phnz9sNG; Tue,  5 Feb 2019 16:38:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549345115;
 bh=k5Igl4ppvj+SYpmMtMbV5CgfUReMU6sAv7cjyTf9jeg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OYYzXvYA0YDbwzossZUya5llGWKPSKPXMThEia/tFzsIQkGVEziNPiWf57/U6oP3P
 K44d3580Du46SvQyT0YyGGmBt45ZXQubL9t5sP8KN0Ief294uQMi7IyeCphvpp4t7N
 ANWkn0B9LxBA/8oJ9FYaZ33AwUdSNyu9R2T2zuxA=
Date: Tue, 5 Feb 2019 16:33:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 17/19] KVM: PPC: Book3S HV: add get/set accessors for the
 VP XIVE state
Message-ID: <20190205053331.GH22661@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107191006.10648-1-clg@kaod.org>
 <20190204052646.GJ1927@umbus.fritz.box>
 <5ebeb37b-623b-9b82-5628-fd6d78382064@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AqCDj3hiknadvR6t"
Content-Disposition: inline
In-Reply-To: <5ebeb37b-623b-9b82-5628-fd6d78382064@kaod.org>
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


--AqCDj3hiknadvR6t
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 07:57:26PM +0100, C=E9dric Le Goater wrote:
> On 2/4/19 6:26 AM, David Gibson wrote:
> > On Mon, Jan 07, 2019 at 08:10:04PM +0100, C=E9dric Le Goater wrote:
> >> At a VCPU level, the state of the thread context interrupt management
> >> registers needs to be collected. These registers are cached under the
> >> 'xive_saved_state.w01' field of the VCPU when the VPCU context is
> >> pulled from the HW thread. An OPAL call retrieves the backup of the
> >> IPB register in the NVT structure and merges it in the KVM state.
> >>
> >> The structures of the interface between QEMU and KVM provisions some
> >> extra room (two u64) for further extensions if more state needs to be
> >> transferred back to QEMU.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  arch/powerpc/include/asm/kvm_ppc.h    |  5 ++
> >>  arch/powerpc/include/uapi/asm/kvm.h   |  2 +
> >>  arch/powerpc/kvm/book3s.c             | 24 +++++++++
> >>  arch/powerpc/kvm/book3s_xive_native.c | 78 +++++++++++++++++++++++++++
> >>  4 files changed, 109 insertions(+)
> >>
> >> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include=
/asm/kvm_ppc.h
> >> index 4cc897039485..49c488af168c 100644
> >> --- a/arch/powerpc/include/asm/kvm_ppc.h
> >> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> >> @@ -270,6 +270,7 @@ union kvmppc_one_reg {
> >>  		u64	addr;
> >>  		u64	length;
> >>  	}	vpaval;
> >> +	u64	xive_timaval[4];
> >>  };
> >> =20
> >>  struct kvmppc_ops {
> >> @@ -603,6 +604,8 @@ extern void kvmppc_xive_native_cleanup_vcpu(struct=
 kvm_vcpu *vcpu);
> >>  extern void kvmppc_xive_native_init_module(void);
> >>  extern void kvmppc_xive_native_exit_module(void);
> >>  extern int kvmppc_xive_native_hcall(struct kvm_vcpu *vcpu, u32 cmd);
> >> +extern int kvmppc_xive_native_get_vp(struct kvm_vcpu *vcpu, union kvm=
ppc_one_reg *val);
> >> +extern int kvmppc_xive_native_set_vp(struct kvm_vcpu *vcpu, union kvm=
ppc_one_reg *val);
> >> =20
> >>  #else
> >>  static inline int kvmppc_xive_set_xive(struct kvm *kvm, u32 irq, u32 =
server,
> >> @@ -637,6 +640,8 @@ static inline void kvmppc_xive_native_init_module(=
void) { }
> >>  static inline void kvmppc_xive_native_exit_module(void) { }
> >>  static inline int kvmppc_xive_native_hcall(struct kvm_vcpu *vcpu, u32=
 cmd)
> >>  	{ return 0; }
> >> +static inline int kvmppc_xive_native_get_vp(struct kvm_vcpu *vcpu, un=
ion kvmppc_one_reg *val) { return 0; }
> >> +static inline int kvmppc_xive_native_set_vp(struct kvm_vcpu *vcpu, un=
ion kvmppc_one_reg *val) { return -ENOENT; }
> >=20
> > IIRC "VP" is the old name for "TCTX".  Since we're using tctx in the
> > rest of the XIVE code, can we use it here as well.
>=20
> OK. The state we are getting or setting is indeed related to the thread=
=20
> interrupt  context registers.=20
>=20
> The name VP is related to an identifier to some interrupt context under=
=20
> OPAL (NVT in HW to be precise).

Oh, sorry, "NVT" was the name I was looking for, not "TCTX".  But in
any case, please lets standardize on one.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AqCDj3hiknadvR6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxZICsACgkQbDjKyiDZ
s5I6Gw/+Jhf+8FgV3C4z3rBV1SlzTyUmbVl6NM8toQjtkHFHoBGnKLP7i0kf4nxD
5T7QKmnX0jaGdQx9b2p9fMiS34Ic+If+hmYxWLCExTttCJeJYjy1YPX0zaes7Rvt
8XMsgCJw7ydfxprbmFWP4oehNGSu5vSIiOryiSWg5wlhAb3+ewlJVsJUiQ7/lzAk
j3HHG62ntK6x5sk019kTBKm8w4BvFE4d8dM0Rc7SnjqjIlJfsLC5ivMWhJnQSylq
CAzOXwoEMuiEK5E54aTN9/ZZSyjfq3V+a682FPXwRBKSWrVZlzmspob7LrIu5aVL
vI8vB1qgSA2wD8BnffdNMNfPU2SFQsL+Mg9H0+1oCMk3Ghn/QK8Q5SCNFjkusO9k
QBosRQl1h/gaJkGjsIQLzBzKTll2jZLCWhccdMCo22DmeonOAJzW6GdDMJCMaWQz
/wrIOCui4OPVg4x1JD2xyVbU2CAl1MPV/P8dPmyGI5xZHIM4lsPaBCJ6MYhZSfNv
pk2u/qSPmE7gnhRTAs7CYteD3aUvrxueLF7dRhOSZOhLwuhb64HV5VOeQlNFLDNk
fN2i5U6IrKIAVq66jexwCOpiKelIytqcbbonP5S7xx+uwakNM/NkMV9C72bcF0fK
ZbLaQ5wzvfTxZJotQUjAXgno9dsmXgRzB5NByo0CyPKFzQzSW0k=
=N46W
-----END PGP SIGNATURE-----

--AqCDj3hiknadvR6t--
