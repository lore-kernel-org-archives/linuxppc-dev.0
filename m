Return-Path: <sfr@canb.auug.org.au>
Date: Thu, 3 May 2007 13:28:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Dale Farnsworth" <dale@farnsworth.org>
Subject: Re: [PATCH] powerpc: check cache coherency of kernel vs firmware
Message-Id: <20070503132824.76b15c67.sfr@canb.auug.org.au>
In-Reply-To: <20070502215938.GF27253@xyzzy.farnsworth.org>
References: <20070502215938.GF27253@xyzzy.farnsworth.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__3_May_2007_13_28_24_+1000_jWcYc48/=_va7BqH"
Cc: Linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__3_May_2007_13_28_24_+1000_jWcYc48/=_va7BqH
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 2 May 2007 14:59:38 -0700 "Dale Farnsworth" <dale@farnsworth.org> wrote:
>
> +#ifdef CONFIG_CHECK_CACHE_COHERENCY
> +#endif /* CONFIG_CHECK_CACHE_COHERENCY */

These ...

> +config CHECK_COHERENT_CACHE

don't match this.
--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__3_May_2007_13_28_24_+1000_jWcYc48/=_va7BqH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGOVbeFdBgD/zoJvwRAufsAJ9AQI6dDxzERowHAfB9vL+ktVTpXQCgiDzW
VJ9i5oMITTQeTdorMqy44g0=
=K8Vk
-----END PGP SIGNATURE-----

--Signature=_Thu__3_May_2007_13_28_24_+1000_jWcYc48/=_va7BqH--
