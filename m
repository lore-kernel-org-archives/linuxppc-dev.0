Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CD391A02E6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 16:36:33 +1100 (AEDT)
Date: Mon, 25 Jan 2016 16:23:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel 1/4] KVM: PPC: Reserve KVM_CAP_SPAPR_TCE_64
 capability number
Message-ID: <20160125052320.GB32205@voom.redhat.com>
References: <1453364126-22527-1-git-send-email-aik@ozlabs.ru>
 <1453364126-22527-2-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
In-Reply-To: <1453364126-22527-2-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2016 at 07:15:23PM +1100, Alexey Kardashevskiy wrote:
> This adds a capability number for 64-bit TCE tables support.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/uapi/linux/kvm.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 9da9051..8ce5f64 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -850,6 +850,7 @@ struct kvm_ppc_smmu_info {
>  #define KVM_CAP_IOEVENTFD_ANY_LENGTH 122
>  #define KVM_CAP_HYPERV_SYNIC 123
>  #define KVM_CAP_S390_RI 124
> +#define KVM_CAP_SPAPR_TCE_64 125
> =20
>  #ifdef KVM_CAP_IRQ_ROUTING
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWpbFIAAoJEGw4ysog2bOSNBAQAM0Y4yDxvHO30n9h2aFT6zbR
8gAGnETBndzAvY4je7dftReh6n1r3Td4YRap5ZSTjysw1eYQuWfd6T8/4cyS3C7i
zfr96VnjaVgorQe3KyU02jKil32ZB0xNWxkYqc3y/pBOtF82VUgrYfIpouvNjtPb
leO4nzdJo6M+RBfEMyxyOust7q+N8F8CHRrqRX1Utbdtw9NoO2/+V3o3hl3DPAop
MJnAEgxBWd3fYNQwlsQUMG/egYYYg+tffb7O6tlwrfSyfK3GvKSxheyv2VpIBVL3
G8S0dvUj0XAyl0qa/U4Gme/vnZY7R3MzGTI5jk/TcIj/c+S9iOfzqoigfUDEX8JG
IWI6NaqxFHblV6OMzfCQ121awk/L7+WlQBlY+HgNp0YjpL0glu3R4Bj4Xu2I5V5r
fDlDXa36GBOce5Kvu6OIS9upfNuV1tDKlSZJL/XxSON8JeXgo3Lj47yOmgioxgNw
TyaDItA6xbXItWqDoIq0Hec5gvzkwFidqvVLWVC/B6iH6FM0gBC8HdLkEBx97W+l
SUjEM8W2fjrvBOw/FkKERrfvx5Cjv1CTvEIWfGrf1nb42cDrwWOFVEDWBKKXstDY
sIMNA4kKgTkDo+pP4VRmpZgyK0MBczkYVH2CwlFyt1uUwc3E7MBScdaDPp6Z3CmB
s4ZF1dfhlLaklu7YJJx8
=Hp9t
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
