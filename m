Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326A1C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 05:12:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B4C52175B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 05:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Uy8WU77U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B4C52175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w5zr2CWPzDqPv
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 16:12:56 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w4VP5sGvzDqMB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 15:05:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="Uy8WU77U"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43w4VN4X0rz9sMM; Thu,  7 Feb 2019 15:05:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549512348;
 bh=S0S2dS1LjBuRUTG1clDNgaI7KgE8nTVNnjiFR2NoXvA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Uy8WU77U9A/eXG5/Tke+Th5k5aHqKg5W+2moFJQjgjPHb3RSlMEuVovTfo8MMeXy+
 ZS027npk5ZEFGdNzoPEtlqN/puV9sDHDOrhEpRMs04p31S0QgEc/sL49zR/Qb3JstF
 IibSO4sRi3Suy2Ne1zLAV0+Kp5RA6umM7QcvMa/c=
Date: Thu, 7 Feb 2019 14:03:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2] powerpc/mm: move a KERN_WARNING message to pr_debug()
Message-ID: <20190207030305.GA518@umbus.fritz.box>
References: <20190205202133.5048-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <20190205202133.5048-1-lvivier@redhat.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 09:21:33PM +0100, Laurent Vivier wrote:
> resize_hpt_for_hotplug() reports a warning when it cannot
> increase the hash page table ("Unable to resize hash page
> table to target order") but this is not blocking and
> can make user thinks something has not worked properly.
> As we move the message to the debug area, report again the
> ENODEV error.
>=20
> If the operation cannot be done the real error message
> will be reported by arch_add_memory() if create_section_mapping()
> fails.
>=20
> Fixes: 7339390d772dd
>        powerpc/pseries: Don't give a warning when HPT resizing isn't avai=
lable
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Sorry, I'm pretty dubious about this.  It's true that in the case for
which this bug was filed this is a harmless situation which deserves a
pr_debug() at most.

But that's not necessarily true in all paths leading to this message.
It will also trip if we fail to reshrink the HPT after genuinely
hotunplugging a bunch of memory, in which case failing to release
expected resources does deserve a warning.

> ---
>=20
> Notes:
>     v2:
>      - use pr_debug instead of printk(KERN_DEBUG
>      - remove check for ENODEV
>=20
>  arch/powerpc/mm/hash_utils_64.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils=
_64.c
> index 0cc7fbc3bd1c..6a0cc4eb2c83 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -777,10 +777,9 @@ void resize_hpt_for_hotplug(unsigned long new_mem_si=
ze)
>  		int rc;
> =20
>  		rc =3D mmu_hash_ops.resize_hpt(target_hpt_shift);
> -		if (rc && (rc !=3D -ENODEV))
> -			printk(KERN_WARNING
> -			       "Unable to resize hash page table to target order %d: %d\n",
> -			       target_hpt_shift, rc);
> +		if (rc)
> +			pr_debug("Unable to resize hash page table to target order %d: %d\n",
> +				 target_hpt_shift, rc);
>  	}
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxbn+cACgkQbDjKyiDZ
s5L2uA//d3kL73x/E6LZ0sRh7aylcIfnRBlPzYmX787L4LZfSSlFGDscIhjj4EWx
cWArmrwR62zv2H9pcgj2oKz9C1cZQPfC8wHTJuAOPiRb8oVWic1KysbJhDLPfeRp
LwoCoocxdob69Li45NysjHTEtnoBKt9flllkNcieyPRz92mhCdYiTyjyuVkyg9hd
Sl2EXEqZpt+eq2+vr3l26nC0Y4IdgzmnY8GqELpbqhLCWX7XXvokUrx8uXfxzCc+
xHiE72FQhtTcj3aShI1DYt8doJFVUP0i5441UhQUImQzahC3Oo8i7N3kRJfcZNYd
S75JnBrm0RAzd4jOyRsqiDADeDqjPhzo4Hq7D3i5KMKT2pHa37VUEmCRIGYEjpea
A9aYlhVbdvDdCyy5LQs/6/A6FNk8pfccNMCG8AxStR7cYQdo8Babz+F4jutfigTB
F+ZBtFWmAwvKE18ClErfOzE+GgOHvh2FIWLH2biwArPEc7PON9VzaWP8K41CQEfs
9zJjvEgp4fofadFimPr2hUmkfvWmngy+6vbHm48Y/kdf6LnEBIlS+322YncEalTW
ABKAllKMxkYxXig6ORHwBW8j+wGCRM+dYvPJ2ZFwspGxWXIzMkKIeD9YhUiP/mvN
4ZXSy1mt1IFikkgfko2u/yCSzsR9/WYC7M7j1gXBTlI1FuflB/M=
=UPqI
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
