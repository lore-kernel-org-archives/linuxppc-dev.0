Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424CwZ6tdhzF3C9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 14:07:42 +1000 (AEST)
Date: Tue, 4 Sep 2018 13:57:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 1/3] mm: Export alloc_migrate_huge_page
Message-ID: <20180904035739.GF2679@umbus.fritz.box>
References: <20180903163733.27965-1-aneesh.kumar@linux.ibm.com>
 <20180903163733.27965-2-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OzxllxdKGCiKxUZM"
In-Reply-To: <20180903163733.27965-2-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--OzxllxdKGCiKxUZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2018 at 10:07:31PM +0530, Aneesh Kumar K.V wrote:
> We want to use this to support customized huge page migration.
>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/linux/hugetlb.h | 2 ++
>  mm/hugetlb.c            | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index c39d9170a8a0..98c9c6dc308c 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -357,6 +357,8 @@ struct page *alloc_huge_page_nodemask(struct hstate *=
h, int preferred_nid,
>  				nodemask_t *nmask);
>  struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct=
 *vma,
>  				unsigned long address);
> +struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
> +				     int nid, nodemask_t *nmask);
>  int huge_add_to_page_cache(struct page *page, struct address_space *mapp=
ing,
>  			pgoff_t idx);
> =20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 47566bb0b4b1..88881b3f8628 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1586,8 +1586,8 @@ static struct page *alloc_surplus_huge_page(struct =
hstate *h, gfp_t gfp_mask,
>  	return page;
>  }
> =20
> -static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_=
mask,
> -		int nid, nodemask_t *nmask)
> +struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
> +				     int nid, nodemask_t *nmask)
>  {
>  	struct page *page;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OzxllxdKGCiKxUZM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluOArEACgkQbDjKyiDZ
s5KIlA//eIIwAl4P34a/VgEWVfEjw1tPv5GjJbHLzXYKn+jdkl1POca15kDCJVym
xJMg8v9ox8KUhImb+uKW15AhwH2Asq94PYExtFNpaB9d2Xpn892Amm7NOcXZOPS2
4daX7XVP9hpqjrpATaCkRo4iGzrZ2ZZExFxyPEpmIex7K12AZEGc50PzJGPbvv84
ZyxnxTXyUMs9L6J09zwF4aG3vSekGgSlTzyH1wKaAws+ly5SzZ0762oruCSHcF7x
41xqaXvrJEmOmcGNpWJhagGBqjRaU33VL5r5tru/nlaVsoSEKlFHtoEyXm0CVdIf
j4Fx4Iu3ct3HMpIkT4FMKw4WwUS9JlShentO1M2X2/2OLWFiHpjBkVokh0ZQ6JPu
B75gbLbizazBp8kSIgTL5epfW1kM9rwe5w1tTXpkMy6ecYN7SYhAFAytlrDAPhZP
f88k1X6JtJ562Z98UznS1r5QY/R0lJRqYy4THv9nJxSQFcvq7nk9oNbBrBhJAHyz
D+EImJILhEwIHgD+VhcyDWB5Uafh1IaC3/UG4lHswxbfZZ8US9rsEHzvhUKGv3Qy
hY1ivfTllk94yC1U1iQvfPdsZMPee7yH3ydws2k6q9GDeI39T0Uu4TpU60rzD0Hd
S9pewxD/YxClmw4qWvUG6wNhDzz0Ak0Ol6NrUdg3OPtWXtVRt/8=
=0EGr
-----END PGP SIGNATURE-----

--OzxllxdKGCiKxUZM--
