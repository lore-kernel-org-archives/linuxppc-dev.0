Return-Path: <sfr@canb.auug.org.au>
Date: Thu, 10 Mar 2005 13:42:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linas Vepstas <linas@austin.ibm.com>
Message-Id: <20050310134216.5b9b27ef.sfr@canb.auug.org.au>
In-Reply-To: <20050309200109.GG1220@austin.ibm.com>
References: <20050309120343.0c22eb0f.sfr@canb.auug.org.au>
	<20050309200109.GG1220@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__10_Mar_2005_13_42_16_+1100_vMAPU9/9HR3S=+m7"
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: [RFC][PATCH] combining header files
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__10_Mar_2005_13_42_16_+1100_vMAPU9/9HR3S=+m7
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 9 Mar 2005 14:01:09 -0600 Linas Vepstas <linas@austin.ibm.com> wrote:
>
> Why not #include <asm-generic/whatever.h> instead? 

Because I am talking about similarities between ppc and ppc64 not ppc64
and the generic code (though there may be some of those to be exploited as
well).

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__10_Mar_2005_13_42_16_+1100_vMAPU9/9HR3S=+m7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCL7QI4CJfqux9a+8RAgBhAJ4iz8tBIHHQh2xyU1je16twvemUCQCeOS8O
SYQb4rxnbEd5UlUnNvBrQUI=
=+y1Q
-----END PGP SIGNATURE-----

--Signature=_Thu__10_Mar_2005_13_42_16_+1100_vMAPU9/9HR3S=+m7--
