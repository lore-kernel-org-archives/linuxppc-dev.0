Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E078167A6D
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Mar 2006 11:17:32 +1100 (EST)
Date: Wed, 22 Mar 2006 11:16:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH] powerpc: Make BUG_ON & WARN_ON play nice with
	compile-time optimisations
Message-Id: <20060322111656.7a5c2b56.sfr@canb.auug.org.au>
In-Reply-To: <20060321055203.EF12167A39@ozlabs.org>
References: <200603211445.32454.michael@ellerman.id.au>
	<20060321055203.EF12167A39@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__22_Mar_2006_11_16_56_+1100_exQjdk3YxR=DEu3B"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__22_Mar_2006_11_16_56_+1100_exQjdk3YxR=DEu3B
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Mar 2006 16:51:29 +1100 Michael Ellerman <michael@ellerman.id.au=
> wrote:
>
> Although we could do this. It relys on firmware_has_feature() being a mac=
ro,
> but perhaps that's ok. This isn't exactly ideal, as it encourages us to u=
se
> macros where we could otherwise use static inlines, but perhaps it's ok.

In this case the macros are small and the overall effect looks good.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__22_Mar_2006_11_16_56_+1100_exQjdk3YxR=DEu3B
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEIJd9FdBgD/zoJvwRAoGDAJ9V4dACwGVGfdpWvQFYvWQqQA19KgCeP0r4
raflHxN7ZUzbavW6XrV51qc=
=/sOF
-----END PGP SIGNATURE-----

--Signature=_Wed__22_Mar_2006_11_16_56_+1100_exQjdk3YxR=DEu3B--
