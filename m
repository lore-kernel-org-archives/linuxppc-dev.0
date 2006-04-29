Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C6A0E679EF
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 11:31:06 +1000 (EST)
Date: Sat, 29 Apr 2006 11:30:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: sign extension for 32bit syscalls on ppc64
Message-Id: <20060429113059.150cadd6.sfr@canb.auug.org.au>
In-Reply-To: <17490.42497.351114.712494@cargo.ozlabs.ibm.com>
References: <20060428131254.GA507@lst.de>
	<17490.42497.351114.712494@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__29_Apr_2006_11_30_59_+1000_IFZ7g+N.BCZa.Wlh"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__29_Apr_2006_11_30_59_+1000_IFZ7g+N.BCZa.Wlh
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 29 Apr 2006 09:32:17 +1000 Paul Mackerras <paulus@samba.org> wrote:
>
> However, it's debatable whether file descriptor arguments really need
> to be sign-extended.  Although they are typed as int, negative values
> are not generally valid (although there are one or two cases where
> they are), and an fd value of 4294967295 will generate an EBADF error
> just as well as -1 will.

They do need to be sign extended for the new *at syscalls where you can pass
a sepecial value AT_FDCWD (-10) to represent the current directory ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__29_Apr_2006_11_30_59_+1000_IFZ7g+N.BCZa.Wlh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEUsHTFdBgD/zoJvwRAg6xAKCcyW8r4cJ0ug4Wy1fzSAw8cxfCPQCfX2e2
8eyQ7tkPCiAd7ovvptE3nwc=
=mH+K
-----END PGP SIGNATURE-----

--Signature=_Sat__29_Apr_2006_11_30_59_+1000_IFZ7g+N.BCZa.Wlh--
