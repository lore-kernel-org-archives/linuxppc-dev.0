Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B45C04EBF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 04:48:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B752084C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 04:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HN4cqg9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B752084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438mTM2RrGzDqQc
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 15:48:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HN4cqg9H";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438mJh4q9czDqj4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 15:41:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="HN4cqg9H"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 438mJh09PWz9s9G; Wed,  5 Dec 2018 15:41:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1543984868;
 bh=gQvtytvFUv+A0cr2bVbgiv3+no6p+EVkN3mxVianc4g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HN4cqg9HAwMdfhu5kayIa/xNHz6ffwqejNZncz1JdbrW/3oGGwOkMF3QmI5RNNbQF
 +nmU1daE2FMMNP6PCLXs0GrWmGxyrHD2F/V+rd1xppKETkBHKvyiWrcbvNtLBm4mgi
 JJka14N52lBMpfUGzq+clfgaDjqipHDsXwjPb+5E=
Date: Wed, 5 Dec 2018 15:21:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v4 01/19] powerpc/ioda/npu: Call skiboot's hot
 reset hook when disabling NPU2
Message-ID: <20181205042128.GB6757@umbus.fritz.box>
References: <20181123055304.25116-1-aik@ozlabs.ru>
 <20181123055304.25116-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <20181123055304.25116-2-aik@ozlabs.ru>
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


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 04:52:46PM +1100, Alexey Kardashevskiy wrote:
> The skiboot firmware has a hot reset handler which fences the NVIDIA V100
> GPU RAM on Witherspoons and makes accesses no-op instead of throwing HMIs:
> https://github.com/open-power/skiboot/commit/fca2b2b839a67
>=20
> Now we are going to pass V100 via VFIO which most certainly involves
> KVM guests which are often terminated without getting a chance to offline
> GPU RAM so we end up with a running machine with misconfigured memory.
> Accessing this memory produces hardware management interrupts (HMI)
> which bring the host down.
>=20
> To suppress HMIs, this wires up this hot reset hook to vfio_pci_disable()
> via pci_disable_device() which switches NPU2 to a safe mode and prevents
> HMIs.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Acked-by: Alistair Popple <alistair@popple.id.au>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changes:
> v2:
> * updated the commit log
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 9ee7a30..29c6837 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -3676,6 +3676,15 @@ static void pnv_pci_release_device(struct pci_dev =
*pdev)
>  		pnv_ioda_release_pe(pe);
>  }
> =20
> +static void pnv_npu_disable_device(struct pci_dev *pdev)
> +{
> +	struct eeh_dev *edev =3D pci_dev_to_eeh_dev(pdev);
> +	struct eeh_pe *eehpe =3D edev ? edev->pe : NULL;
> +
> +	if (eehpe && eeh_ops && eeh_ops->reset)
> +		eeh_ops->reset(eehpe, EEH_RESET_HOT);
> +}
> +
>  static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
>  {
>  	struct pnv_phb *phb =3D hose->private_data;
> @@ -3720,6 +3729,7 @@ static const struct pci_controller_ops pnv_npu_ioda=
_controller_ops =3D {
>  	.reset_secondary_bus	=3D pnv_pci_reset_secondary_bus,
>  	.dma_set_mask		=3D pnv_npu_dma_set_mask,
>  	.shutdown		=3D pnv_pci_ioda_shutdown,
> +	.disable_device		=3D pnv_npu_disable_device,
>  };
> =20
>  static const struct pci_controller_ops pnv_npu_ocapi_ioda_controller_ops=
 =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwHUkgACgkQbDjKyiDZ
s5KYMw/+Mzh38UfXrz5NRRouaeOXLnXjSwpuiSQp96Ya6uIjdnLSSYr1oO31zA2c
0z0iLfTJ/es8QQ+DUdb9cZpDSyftTh9K7Hc4vupgZe8Pno3cjxNopo4efGO8GGgd
8B1rd8eDAdFGEENTesbhDB05Z1UlbPVe2+CiJmv+D2nu//rdAQJJao/OxDHacLUP
p6luNjBrV7wAm1W4AVWDf/H9WtzTKdlBwpbpBwtCp/Mrwtf1nkWX+qWrk7rNuufC
jr1EvhDvxX0bFjiFc4qvp61oeCLE4tsHH6o2HV/1NYVM5Lvk4LxVCrPaZ8GyozPO
CvQvQvleCyEFFfmpv7+DSrsDzVwz1jXfOFCHqMeJsIRhnoLyUw9qVaavL55eFpEH
ZZBc5G7khGXwVZoOiQRalgV1lEpa4UsSaNQLFGyv8n8UvnW/qaG2PUAUxrNPfrYU
+P60J8VMqRctojlYAZ3wr/g44FlJ+sKKAMDOVX+7+jfVn81M3nXkB8rQvQAqA0iK
67rL/xBt/CTmJ0bxU4DB0+pBTo44f5dICtOQx85z3f6s7ydwdH2uE090c5Ip53/i
/OdD6IDgmu+Rnji/5S8zI5ONpAe/lQecsA7FgNNkPDFl0BknY0EHGyKUB5Gkq8Ii
tRc7ADG4hzZyeDZYyVyEpFPbpe0be9t6fLYTficwbntcxcTKNnw=
=eqbb
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
