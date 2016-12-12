Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tcV3J6RqlzDvjf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 15:19:24 +1100 (AEDT)
Date: Mon, 12 Dec 2016 15:08:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel 1/9] KVM: PPC: Reserve KVM_CAP_SPAPR_TCE_VFIO
 capability number
Message-ID: <20161212040816.GC31441@umbus.fritz.box>
References: <20161208081956.26221-1-aik@ozlabs.ru>
 <20161208081956.26221-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
In-Reply-To: <20161208081956.26221-2-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 08, 2016 at 07:19:48PM +1100, Alexey Kardashevskiy wrote:
> This adds a capability number for in-kernel support for VFIO on
> SPAPR platform.
>=20
> The capability will tell the user space whether in-kernel handlers of
> H_PUT_TCE can handle VFIO-targeted requests or not. If not, the user space
> must not attempt allocating a TCE table in the host kernel via
> the KVM_CREATE_SPAPR_TCE KVM ioctl because in that case TCE requests
> will not be passed to the user space which is desired action in
> the situation like that.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Fine as far as it goes, although I wonder if you actually need a new
CAP - couldn't you just add a new cap value to KVM_CAP_SPAPR_TCE?

> ---
>  include/uapi/linux/kvm.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 300ef255d1e0..810f74317987 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -870,6 +870,7 @@ struct kvm_ppc_smmu_info {
>  #define KVM_CAP_S390_USER_INSTR0 130
>  #define KVM_CAP_MSI_DEVID 131
>  #define KVM_CAP_PPC_HTM 132
> +#define KVM_CAP_SPAPR_TCE_VFIO 133
> =20
>  #ifdef KVM_CAP_IRQ_ROUTING
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYTiKvAAoJEGw4ysog2bOSIrEQALwvV+/ow20Y89KaSHc4R4ii
18jSIARNObHvxMb7Jj0BxT7rmGggDlbvoBdw59NspOeN4KKPFmQ9xrhqHzvd2/JC
gebqak+z9c0s29nieDlsQt9onV2zH3yDT4Cd4kV3C3znhTH6aEiBdt+xIHmH/5hr
Dl7linDibv1Sz6t+g05E5klV3FO+9c72v8DRjwab1gzXBDW23mD7SXC/itv61U0x
oigHabf7wdO7imFNILxUZatw6qG5AQ5UBdx+zY/64tCVc5d0YbJ8E7H70aGOscZs
Sm50OfuDWjIBGjtVOgwzJxzo/0YU+LFonRpp9zBvifXEwFvIhXzgQUVsz4T1K31o
wLF6nnSS/5rN+btLzlys0pwOYIrqXwKT/CnplmgcPARXVD/gyL1X+swVgvQa/m/O
wzcdFiXglGiD3iIdyvXwTo/vEGcww821c2DfKtbH8qG3U9Y8lIq2bhXUatzcg+9b
wS0yhA63LPpAho41LW4Iks5BoTCNix2lEiHF/+p6KWkTUVAxUy49RyNEekka2BSx
YRZKCuL4f1Shs455pSI60Z9o0RWz3lg9j22m9nTB6oahChXz8fvFI3m8ipozbaFY
QApfKDINKgo9E+PC/P6aKaT69nHF1NLruP1u5wLaguLTuZslIcS+IM9BkbbcSNPE
b5g+fdGjWz4PWMzQTbuZ
=0QED
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
