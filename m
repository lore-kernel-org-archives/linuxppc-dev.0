Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mm: Merge various PTE bits and accessors
	definitions
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20090302062351.26F84DDFBE@ozlabs.org>
References: <20090302062351.26F84DDFBE@ozlabs.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-z6qSgShYyNbe3nqCFQf1"
Date: Mon, 02 Mar 2009 18:38:01 +1100
Message-Id: <1235979481.8526.31.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-z6qSgShYyNbe3nqCFQf1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-03-02 at 17:22 +1100, Benjamin Herrenschmidt wrote:
> Now that they are almost identical, we can merge some of the definitions
> related to the PTE format into common files.

<snip>

> +/* Protection used for kernel text. We want the debuggers to be able to
> + * set breakpoints anywhere, so don't write protect the kernel text
> + * on platforms where such control is possible.
> + */
> +#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_S=
WITCH) ||\
> +	defined(CONFIG_KPROBES)
> +#define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
> +#else
> +#define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
> +#endif

What about FTRACE? =E2=88=9ETRACE etc.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-z6qSgShYyNbe3nqCFQf1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmrjNkACgkQdSjSd0sB4dLhHwCgrvNYVurYDdykj0mSEyaQ6/c0
eoUAoLjp82yzDc8eiJbpgaxSLRVDrSgl
=7Dp1
-----END PGP SIGNATURE-----

--=-z6qSgShYyNbe3nqCFQf1--
