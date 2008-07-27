Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id DBF19DDF3F
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 00:23:42 +1000 (EST)
Date: Mon, 28 Jul 2008 00:23:36 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [PATCH] Fix powerpc64 build if CONFIG_EPOLL=n
Message-Id: <20080728002336.4a7883f1.sfr@canb.auug.org.au>
In-Reply-To: <B6E6E232-5793-4BBB-BD82-95B19716ACE4@watson.ibm.com>
References: <B6E6E232-5793-4BBB-BD82-95B19716ACE4@watson.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__28_Jul_2008_00_23_36_+1000_TtuKbjIu577aGtkC"
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__28_Jul_2008_00_23_36_+1000_TtuKbjIu577aGtkC
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jimi,

On Sun, 27 Jul 2008 08:48:09 -0400 Jimi Xenidis <jimix@watson.ibm.com> wrot=
e:
>
> Declate compat_sys_epoll_pwait as a conditional syscall like the rest =20
> of the epoll interfaces.
> We could have put an #ifdef around the entry in include/asm-powerpc/=20
> systbl.h, but IMHO this is ultimately correct patch.

Already in Linus' tree - commit 5f17156fc55abac476d180e480bedb0f07f01b14
"Fix build on COMPAT platforms when CONFIG_EPOLL is disabled"

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__28_Jul_2008_00_23_36_+1000_TtuKbjIu577aGtkC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiMhOgACgkQjjKRsyhoI8yRgwCdFZfyfm9Oijjdp0OrE04lGl64
9jwAoJ9VOA+A2JTAufm1BpkFbFw5Avwr
=L9VU
-----END PGP SIGNATURE-----

--Signature=_Mon__28_Jul_2008_00_23_36_+1000_TtuKbjIu577aGtkC--
