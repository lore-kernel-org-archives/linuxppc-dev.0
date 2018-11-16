Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DBFC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 05:46:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8336208E7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 05:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Zj9aCeOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8336208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42x6fH293szF3lH
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 16:45:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Zj9aCeOl";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42x6Zz266vzF3hx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 16:43:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="Zj9aCeOl"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42x6Zy5xRlz9sBN; Fri, 16 Nov 2018 16:43:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1542346986;
 bh=tWqZPs6YvZL30UvfFfGoyqCrahNh+++52YVchTrThKE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Zj9aCeOl8eYcMJVkuKH9BlgKrZcisF/jL9mEYa7yxkL/CudOpA6KxO06wyR93C+Hs
 lmfiXuujXS8b/TtD9hT6wYUJxELxGtJfJH+KtwkNQZuJmywrdB5Fbv2vpZ5peW5n9l
 D+lbT5r62Wq/zjmu+w2awdNJ9gzin52Sq67K6ZWY=
Date: Fri, 16 Nov 2018 16:25:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v3 11/22] powerpc/pseries/npu: Enable platform
 support
Message-ID: <20181116052534.GD23632@umbus>
References: <20181113082823.2440-1-aik@ozlabs.ru>
 <20181113082823.2440-12-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Content-Disposition: inline
In-Reply-To: <20181113082823.2440-12-aik@ozlabs.ru>
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
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 07:28:12PM +1100, Alexey Kardashevskiy wrote:
> We already changed NPU API for GPUs to not to call OPAL and the remaining
> bit is initializing NPU structures.
>=20
> This uses a new QEMU capability which marks NPU-enabled vPHBs as
> "IBM,npu-vphb" and initializes an NPU structure per vPHB.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/platforms/pseries/pci.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platform=
s/pseries/pci.c
> index 41d8a4d..a50d5e4 100644
> --- a/arch/powerpc/platforms/pseries/pci.c
> +++ b/arch/powerpc/platforms/pseries/pci.c
> @@ -29,6 +29,7 @@
>  #include <asm/pci-bridge.h>
>  #include <asm/prom.h>
>  #include <asm/ppc-pci.h>
> +#include <asm/pci.h>
>  #include "pseries.h"
> =20
>  #if 0
> @@ -237,6 +238,8 @@ static void __init pSeries_request_regions(void)
> =20
>  void __init pSeries_final_fixup(void)
>  {
> +	struct pci_controller *hose;
> +
>  	pSeries_request_regions();
> =20
>  	eeh_probe_devices();
> @@ -246,6 +249,9 @@ void __init pSeries_final_fixup(void)
>  	ppc_md.pcibios_sriov_enable =3D pseries_pcibios_sriov_enable;
>  	ppc_md.pcibios_sriov_disable =3D pseries_pcibios_sriov_disable;
>  #endif
> +	list_for_each_entry(hose, &hose_list, list_node)
> +		if (of_device_is_compatible(hose->dn, "IBM,npu-vphb"))
> +			pnv_npu2_init(hose);

I take it from this the NPUs are showing up with a compatible property
that lists the normal PHB value as well as IBM,npu-vphb.  Since AIUI
the NPUs act quite differently from other (real) PHBs this seems
bogus.  Shouldn't they be probed separately?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvuVM4ACgkQbDjKyiDZ
s5JJtg/+INmzR3Ey0HwKITDY4GtSd/zlYoijdxW9CkLO9x00DOP7p72eNK/Cuyua
Pn0U7x3DdhIXrLUD4CpTyZOrcjua9xLLQ/bjrReSbgiunTuMhRD2zyXXR/zN3RaT
D1CsOxKVQN+J4QEVGXgaDmgzRs8DzQ5LjQkMlgw+R80GOKbqjNp2B7iTlE+X2EK1
YIgE4ACIv2RLeUQedvYboDkBHT26K3+Q3+jL4mEsZPJTNLZoYUsIrqt8BmwzjfcD
drhIaxz4PcFkkoH2pbSkO3ksObr8BX+PBa05p6ALiuMl9/VK9NNnODW6WzuIPGSa
Qn8RHDneu1MkTnLBJylGKgmLo8WVLWdSQPTBPuxh1+Ip2Ch/b9L4ecfWPE0v/HuY
6dwsZJr0PoVv1lO3xbDZzPNzY6K3MDUpbYyJYdeN8edGtNs291AYri/5n6/rAgjS
etlwxR8nlKwWchigLZuxLKfpQN7mh1RVZOaoxwYDRJ1QqNoMnvPOfL9maUxzSPrw
dqeXRZLYGR5vfsX+nmGDINuzhMNa0kBBbeaLGVsc5Apm81kvFUDxCvZu8FHdD+g8
/oMm1xAWzZmqkVb0TuH8Obv5/dX6rvKuAtow4h5vY4S/GdWUDGRVBlQfRjLDaEiY
F2fn/ZNY58sqi1eaaLEp5CVEBqzyMLxsfZZtKD+8XDCASi321LY=
=iuiF
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--
