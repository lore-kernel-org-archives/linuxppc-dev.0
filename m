Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C369C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 05:49:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B2A7208E7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 05:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MZJaiRpj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2A7208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42x6jq0Fp7zF3hy
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 16:49:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MZJaiRpj";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42x6Zz1WxfzF3hw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 16:43:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="MZJaiRpj"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42x6Zy5DL4z9sBQ; Fri, 16 Nov 2018 16:43:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1542346986;
 bh=FFklRdUtyk1wrsmB4ybaZ793ZtvtUAQyS/inl5ijJes=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MZJaiRpj91Ih3SekoHwalJm7OUz3KcTu8MG1q2LJrDP3GxBNBHXKIifnHN9OdBDRg
 1LQ64B/5izgD1jcOQ2SCt5dJMhprTmr3HUmFlkp5zz+zYgY2qdaw/AWbc+d6IfAeXE
 uoAq3gUofbO0VrFya087d6/IABIw4hMiTE5NWRT0=
Date: Fri, 16 Nov 2018 16:23:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v3 10/22] powerpc/pseries/iommu: Use memory@ nodes
 in max RAM address calculation
Message-ID: <20181116052351.GC23632@umbus>
References: <20181113082823.2440-1-aik@ozlabs.ru>
 <20181113082823.2440-11-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline
In-Reply-To: <20181113082823.2440-11-aik@ozlabs.ru>
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


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 07:28:11PM +1100, Alexey Kardashevskiy wrote:
> We might have memory@ nodes with "linux,usable-memory" set to zero
> (for example, to replicate powernv's behaviour for GPU coherent memory)
> which means that the memory needs an extra initialization but since
> it can be used afterwards, the pseries platform will try mapping it
> for DMA so the DMA window needs to cover those memory regions too.
>=20
> This walks through the memory nodes to find the highest RAM address to
> let a huge DMA window cover that too in case this memory gets onlined
> later.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/platforms/pseries/iommu.c | 43 +++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platfo=
rms/pseries/iommu.c
> index 78473ac..f818737 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -967,6 +967,47 @@ struct failed_ddw_pdn {
> =20
>  static LIST_HEAD(failed_ddw_pdn_list);
> =20
> +static unsigned long read_n_cells(int n, const __be32 **buf)
> +{
> +	unsigned long result =3D 0;
> +
> +	while (n--) {
> +		result =3D (result << 32) | of_read_number(*buf, 1);
> +		(*buf)++;
> +	}
> +	return result;
> +}

Um.. this appears to be re-implementing of_read_number() in terms of
of_read_number().   Wat!?

> +static phys_addr_t ddw_memory_hotplug_max(void)
> +{
> +	phys_addr_t max_addr =3D memory_hotplug_max();
> +	struct device_node *memory;
> +
> +	for_each_node_by_type(memory, "memory") {
> +		unsigned long start, size;
> +		int ranges, n_mem_addr_cells, n_mem_size_cells, len;
> +		const __be32 *memcell_buf;
> +
> +		memcell_buf =3D of_get_property(memory, "reg", &len);
> +		if (!memcell_buf || len <=3D 0)
> +			continue;
> +
> +		n_mem_addr_cells =3D of_n_addr_cells(memory);
> +		n_mem_size_cells =3D of_n_size_cells(memory);
> +
> +		/* ranges in cell */
> +		ranges =3D (len >> 2) / (n_mem_addr_cells + n_mem_size_cells);
> +
> +		/* these are order-sensitive, and modify the buffer pointer */
> +		start =3D read_n_cells(n_mem_addr_cells, &memcell_buf);
> +		size =3D read_n_cells(n_mem_size_cells, &memcell_buf);
> +
> +		max_addr =3D max_t(phys_addr_t, max_addr, start + size);
> +	}
> +
> +	return max_addr;
> +}

Is there really no existing place we keep track of maxmimum possible
memory address?

>  /*
>   * If the PE supports dynamic dma windows, and there is space for a table
>   * that can map all pages in a linear offset, then setup such a table,
> @@ -1067,7 +1108,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct d=
evice_node *pdn,
>  	}
>  	/* verify the window * number of ptes will map the partition */
>  	/* check largest block * page size > max memory hotplug addr */
> -	max_addr =3D memory_hotplug_max();
> +	max_addr =3D ddw_memory_hotplug_max();
>  	if (query.largest_available_block < (max_addr >> page_shift)) {
>  		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %u "
>  			  "%llu-sized pages\n", max_addr,  query.largest_available_block,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvuVGYACgkQbDjKyiDZ
s5JfKxAAuk8uMoI7NiNgxNss0Dh1VZVy3uVKWuIwrjIVrM1e9gyx+eaEM6g3COYt
4X68X/iNPnzQ111Gydx3Gq7WAKW3K6DTh+O14wTjdQ5F6eBG0sP9aOlOh6vEt44I
ZPybnPrTh1ctrvYsHFgSxpTl4NGE64xOs9ArTtLTjzb4q/8JOHlcjTDuxl90aIgv
TbeSOhfbxMJsxWDnxrjJDaZSz87sanEd5bIEu02RyH1A4zkgcfVmhgP/Yh8hbpzE
0hHZoNg47pRSt7DOF1ZvIq/z+pReWNcZA3YZ3jHVCcmmu90zMj9T/7eQOzdEM9h7
3eBljQT/jHAHSAdz1wgOwOkuQPoyP8nGjF53XqMHVwKZBIQVDPeKs5ZLBFJRZejB
5WUiIeLd7UA/e6KPtncQXx/GI64lZnbYmGatPaxmjRDOgb9K37ekxjF042v9RhYT
XeyJgOnm/imt0RKimo0FOkgBuUF33mmdjw4mZpqWLutEXBKE0MxQ7Spi2+xnaoYw
M+NqvjAaz1k4jy5MMq4AnPu3E8jyjHSBRaxdqG1XANB9nrUSb9B6i9K1v4KOo5R5
kIduCgsVGdH3EBQ6suGiXLPWzigPtIU8ButReFGIU+CRhlH/HF20aVbYrKorXA9u
tEM3zyN/zurPf03BL3eiuYUbxTMIYBBXTYORP73bpTUZN+3Sqyg=
=lOOG
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
