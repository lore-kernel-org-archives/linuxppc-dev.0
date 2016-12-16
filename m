Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfwtz0TX7zDw69
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 14:35:39 +1100 (AEDT)
Date: Fri, 16 Dec 2016 12:11:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel 7/9] KVM: PPC: Enable IOMMU_API for KVM_BOOK3S_64
 permanently
Message-ID: <20161216011127.GD12146@umbus.fritz.box>
References: <20161208081956.26221-1-aik@ozlabs.ru>
 <20161208081956.26221-8-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
In-Reply-To: <20161208081956.26221-8-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 08, 2016 at 07:19:54PM +1100, Alexey Kardashevskiy wrote:
> It does not make much sense to have KVM in book3s-64 and
> not to have IOMMU bits for PCI pass through support as it costs little
> and allows VFIO to function on book3s KVM.
>=20
> Having IOMMU_API always enabled makes it unnecessary to have a lot of
> "#ifdef IOMMU_API" in arch/powerpc/kvm/book3s_64_vio*. With those
> ifdef's we could have only user space emulated devices accelerated
> (but not VFIO) which do not seem to be very useful.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/kvm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
> index 029be26b5a17..65a471de96de 100644
> --- a/arch/powerpc/kvm/Kconfig
> +++ b/arch/powerpc/kvm/Kconfig
> @@ -67,6 +67,7 @@ config KVM_BOOK3S_64
>  	select KVM_BOOK3S_64_HANDLER
>  	select KVM
>  	select KVM_BOOK3S_PR_POSSIBLE if !KVM_BOOK3S_HV_POSSIBLE
> +	select SPAPR_TCE_IOMMU if IOMMU_SUPPORT
>  	---help---
>  	  Support running unmodified book3s_64 and book3s_32 guest kernels
>  	  in virtual machines on book3s_64 host processors.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYUz8/AAoJEGw4ysog2bOSt5YP/iRiHRcCl9KIvrhZsMcpgBs7
6PEcfUoZQDz8hg+26ZdsV7lL5IUrPKDPlsFOuwZGfZvxt3Qcx85zkdz+5Ochl58Z
aYilrCRrrMUJcd8Aggi4/W0/R/AbzAwuxOwWuaZ7kNQ0Ha4Rt7i5LKpXKT5ev75w
e5UKTBTwRPCPRB1Qb2N6tznIHLX8AT2fpYxL9pempwoW+XyXci9s7HuDT5rSlIAr
sc83qU0NvcKh6VG2V17yxNnbycZGkoFuKJXDI2dcHf8c+HE+r3ltbaIJWGNWvTf/
22Tyte2cRyHRGH/xH26s2Cxs3Kb1ZZ8FbC2cG0E8mrTeWpx+J2aRR+96s/7h7S8v
T2dOQ7RgGxDpYjQaCZTLBAfESnaWkdXGNPpEBr3YTckZXQGUtY9yzdzQDbbFykC3
OYMud+NVjqV4XQHdBVYhmjMD0QVG9AlZ4W5P624WdVrkeSn6CHsaPxkS4H9FAtfd
4H02ODZUVynWwBBw7yOTw/I510vrPFFgv5tBjtQXvCDnBzSD1GTFtBfoxwSpaY0Q
lGZ6ij+XS8S5ogCROKy+ypaamUkRuDr4DymTCOupkXA30OvAw1AZNENvAo+nK06Q
SZ++8B9/SFX/T4jooE9bnvCW7a5BWhLdC+9oUirvfTVxc8ZmswpnYixogSx3u14G
kGpLBRN9h6kw2aaqL6De
=dcma
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--
