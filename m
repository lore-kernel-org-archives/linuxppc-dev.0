Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6E2C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 05:21:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B205920672
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 05:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="G083iuM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B205920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43CrzR2mlxzDqlj
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 16:21:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="G083iuM4";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43CrwW6DFtzDqjp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 16:19:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="G083iuM4"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43CrwV6k9Nz9s55; Mon, 10 Dec 2018 16:19:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1544419162;
 bh=bo+tAoR7cZ8B4jOC/kJwGr8I3s+jS0w6aigeOBDPCXQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G083iuM4nV6Q+6T/wQ5jsQpqJN/iM8zh9iJgA2iv8f6BMpBdKSgpAb3Ahhptnve/z
 KCeKZYVf9+boEOB4MhpHhQmT2nMx2EjSOOBjW/kL01VMvBf2GAD67FgP0Gdnq/97oo
 ECCOy6h0r/UIH366KnRCwwUAeZww/4a2qIStq9Ok=
Date: Mon, 10 Dec 2018 14:42:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v4 04/19] powerpc/powernv: Move npu struct from
 pnv_phb to pci_controller
Message-ID: <20181210034236.GI4261@umbus.fritz.box>
References: <20181123055304.25116-1-aik@ozlabs.ru>
 <20181123055304.25116-5-aik@ozlabs.ru>
 <20181205051424.GB768@umbus.fritz.box>
 <e10bc868-154e-285c-05e9-906b7027dfaf@ozlabs.ru>
 <05cb6d97-9949-1d90-33e1-8d5cc1bb83f2@ozlabs.ru>
 <20181205224040.GJ768@umbus.fritz.box>
 <af27ecf4-e73c-1b1d-487e-47da87570e2c@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KrHCbChajFcK0yQE"
Content-Disposition: inline
In-Reply-To: <af27ecf4-e73c-1b1d-487e-47da87570e2c@ozlabs.ru>
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Sam Bobroff <sbobroff@linux.ibm.com>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--KrHCbChajFcK0yQE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 01:50:35PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 06/12/2018 09:40, David Gibson wrote:
> > On Wed, Dec 05, 2018 at 05:17:57PM +1100, Alexey Kardashevskiy wrote:
> >>
> >>
> >> On 05/12/2018 16:47, Alexey Kardashevskiy wrote:
> >>>
> >>>
> >>> On 05/12/2018 16:14, David Gibson wrote:
> >>>> On Fri, Nov 23, 2018 at 04:52:49PM +1100, Alexey Kardashevskiy wrote:
> >>>>> The powernv PCI code stores NPU data in the pnv_phb struct. The lat=
ter
> >>>>> is referenced by pci_controller::private_data. We are going to have=
 NPU2
> >>>>> support in the pseries platform as well but it does not store any
> >>>>> private_data in in the pci_controller struct; and even if it did,
> >>>>> it would be a different data structure.
> >>>>>
> >>>>> This makes npu a pointer and stores it one level higher in
> >>>>> the pci_controller struct.
> >>>>>
> >>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>>> ---
> >>>>> Changes:
> >>>>> v4:
> >>>>> * changed subj from "powerpc/powernv: Detach npu struct from pnv_ph=
b"
> >>>>> * got rid of global list of npus - store them now in pci_controller
> >>>>> * got rid of npdev_to_npu() helper
> >>>>> ---
> >>>>>  arch/powerpc/include/asm/pci-bridge.h    |  1 +
> >>>>>  arch/powerpc/platforms/powernv/pci.h     | 16 -----
> >>>>>  arch/powerpc/platforms/powernv/npu-dma.c | 81 ++++++++++++++++++--=
----
> >>>>>  3 files changed, 64 insertions(+), 34 deletions(-)
> >>>>>
> >>>>> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/i=
nclude/asm/pci-bridge.h
> >>>>> index 94d4490..aee4fcc 100644
> >>>>> --- a/arch/powerpc/include/asm/pci-bridge.h
> >>>>> +++ b/arch/powerpc/include/asm/pci-bridge.h
> >>>>> @@ -129,6 +129,7 @@ struct pci_controller {
> >>>>>  #endif	/* CONFIG_PPC64 */
> >>>>> =20
> >>>>>  	void *private_data;
> >>>>> +	struct npu *npu;
> >>>>>  };
> >>>>> =20
> >>>>>  /* These are used for config access before all the PCI probing
> >>>>> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/pl=
atforms/powernv/pci.h
> >>>>> index 2131373..f2d50974 100644
> >>>>> --- a/arch/powerpc/platforms/powernv/pci.h
> >>>>> +++ b/arch/powerpc/platforms/powernv/pci.h
> >>>>> @@ -8,9 +8,6 @@
> >>>>> =20
> >>>>>  struct pci_dn;
> >>>>> =20
> >>>>> -/* Maximum possible number of ATSD MMIO registers per NPU */
> >>>>> -#define NV_NMMU_ATSD_REGS 8
> >>>>> -
> >>>>>  enum pnv_phb_type {
> >>>>>  	PNV_PHB_IODA1		=3D 0,
> >>>>>  	PNV_PHB_IODA2		=3D 1,
> >>>>> @@ -176,19 +173,6 @@ struct pnv_phb {
> >>>>>  	unsigned int		diag_data_size;
> >>>>>  	u8			*diag_data;
> >>>>> =20
> >>>>> -	/* Nvlink2 data */
> >>>>> -	struct npu {
> >>>>> -		int index;
> >>>>> -		__be64 *mmio_atsd_regs[NV_NMMU_ATSD_REGS];
> >>>>> -		unsigned int mmio_atsd_count;
> >>>>> -
> >>>>> -		/* Bitmask for MMIO register usage */
> >>>>> -		unsigned long mmio_atsd_usage;
> >>>>> -
> >>>>> -		/* Do we need to explicitly flush the nest mmu? */
> >>>>> -		bool nmmu_flush;
> >>>>> -	} npu;
> >>>>> -
> >>>>>  	int p2p_target_count;
> >>>>>  };
> >>>>> =20
> >>>>> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerp=
c/platforms/powernv/npu-dma.c
> >>>>> index 91d488f..7dd5c0e5 100644
> >>>>> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> >>>>> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> >>>>> @@ -327,6 +327,25 @@ struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(st=
ruct pnv_ioda_pe *npe)
> >>>>>  	return gpe;
> >>>>>  }
> >>>>> =20
> >>>>> +/*
> >>>>> + * NPU2 ATS
> >>>>> + */
> >>>>> +/* Maximum possible number of ATSD MMIO registers per NPU */
> >>>>> +#define NV_NMMU_ATSD_REGS 8
> >>>>> +
> >>>>> +/* An NPU descriptor, valid for POWER9 only */
> >>>>> +struct npu {
> >>>>> +	int index;
> >>>>> +	__be64 *mmio_atsd_regs[NV_NMMU_ATSD_REGS];
> >>>>> +	unsigned int mmio_atsd_count;
> >>>>> +
> >>>>> +	/* Bitmask for MMIO register usage */
> >>>>> +	unsigned long mmio_atsd_usage;
> >>>>> +
> >>>>> +	/* Do we need to explicitly flush the nest mmu? */
> >>>>> +	bool nmmu_flush;
> >>>>> +};
> >>>>> +
> >>>>>  /* Maximum number of nvlinks per npu */
> >>>>>  #define NV_MAX_LINKS 6
> >>>>> =20
> >>>>> @@ -478,7 +497,6 @@ static void acquire_atsd_reg(struct npu_context=
 *npu_context,
> >>>>>  	int i, j;
> >>>>>  	struct npu *npu;
> >>>>>  	struct pci_dev *npdev;
> >>>>> -	struct pnv_phb *nphb;
> >>>>> =20
> >>>>>  	for (i =3D 0; i <=3D max_npu2_index; i++) {
> >>>>>  		mmio_atsd_reg[i].reg =3D -1;
> >>>>> @@ -493,8 +511,10 @@ static void acquire_atsd_reg(struct npu_contex=
t *npu_context,
> >>>>>  			if (!npdev)
> >>>>>  				continue;
> >>>>> =20
> >>>>> -			nphb =3D pci_bus_to_host(npdev->bus)->private_data;
> >>>>> -			npu =3D &nphb->npu;
> >>>>> +			npu =3D pci_bus_to_host(npdev->bus)->npu;
> >>>>> +			if (!npu)
> >>>>> +				continue;
> >>>>
> >>>> This patch changes a bunch of places that used to unconditionally
> >>>> locate an NPU now have a failure path.
> >>>>
> >>>> Given that this used to always have an NPU, doesn't that mean that if
> >>>> the NPU is not present something has already gone wrong, and we shou=
ld
> >>>> WARN_ON() or something?
> >>>
> >>>
> >>>
> >>> That means this is a leftover since I dropped that npdev_to_npu helper
> >>> which could help but there was no real value in it. I'll remove the
> >>> check here in the next respin.
> >>
> >>
> >> Well, technically kmalloc() can fail in pnv_npu2_init() (but not later)
> >> so can (in theory) end up with an NPU PHB and npu=3D=3DNULL but it is =
sooo
> >> unlikely...
> >=20
> > More to the point, shouldn't you then fail immediately, rather than
> > leaving the NULL floating around for later code?
>=20
> Not sure I am following. pnv_npu2_init() is called at boot time so
> failing-and-not-leaving-null-pointer here means panic and I definitely
> do not want that.

Well, if it's a choice between panic then and panic later, I'm not so
sure that's true.

> I am adding !npu checks in the next respin though,
> pretty much replacing firmware_has_feature(FW_FEATURE_OPAL), do i miss
> anything here?

That seems reasonable.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KrHCbChajFcK0yQE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwN4KsACgkQbDjKyiDZ
s5JiPQ/7BBFVeANaP/s3pvgFufoVQR4gCGw+kk61FDVQX91lEwPwLFZTk+f1ulfY
UEIsifWAo1EFlDcZzoh4Xr/vFbABuzf6/7/MnXcOrHt0UbeGWiewyR/vydd3IOs8
TYCwp4C4gZDVE/GvdUP6Bt9svpXfLe3WrVyMlxVDblTttPS7MCAk5/1ijipsD3MN
bwiL+2VZipMdaVBFvQv9QT8K7IOlALMs6Zini3ZA7YQxJCflVxfWLN0idiVI4Ny5
H4+AymbfBP+EnK/fa53UWGqxKlC/zOv1nBZdW1/0eANmlFc5xQX/+7omb+TvFu7L
M5/MetVP6OoL2KPmTRuvDMB+8p3GL5xMNiq1dw63IetG+XSQsptpj/SyZ/J5cidK
NGj8Nz5iFVI0qUI514peLwzvWNP2jCTd7FzykYgNCZ+jMxyj4+B0v999LAvKjeor
LON1XeZOx9irHoKbqi9twcgyoA0iDwMDuMiMcIWLSweVVPjULUL0pHwY0bba/l+E
hrB6+Qo+bl+PbGqzLYMoqW8KQRnmlCPnM8DklrvE1V3bjvfzZBp+dqfVjyxU5eJr
8AfuuoDHun3AjlElbhScElij5SwUlUBOoKV8+HTHjjBKk5SGKCaurfDW0hT0U29a
NcwQ9Kc3d7qt29cIVjjExBQ6p4T8WhJkYXh6z0lVIMZbS8GOOk4=
=wBTi
-----END PGP SIGNATURE-----

--KrHCbChajFcK0yQE--
