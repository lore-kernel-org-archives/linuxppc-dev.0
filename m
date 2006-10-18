Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id DD0D767C1D
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 11:19:40 +1000 (EST)
Date: Wed, 18 Oct 2006 11:19:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 2/2] viocons: make powerpc allmodconfig build
Message-Id: <20061018111935.a143164c.sfr@canb.auug.org.au>
In-Reply-To: <20061017095003.c447d88a.randy.dunlap@oracle.com>
References: <20061017095003.c447d88a.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__18_Oct_2006_11_19_35_+1000_9_8+ax9gNo9x3Y6w"
Cc: ppcdev <linuxppc-dev@ozlabs.org>, paulus <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__18_Oct_2006_11_19_35_+1000_9_8+ax9gNo9x3Y6w
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 17 Oct 2006 09:50:03 -0700 Randy Dunlap <randy.dunlap@oracle.com> wrote:
>
> From: Randy Dunlap <randy.dunlap@oracle.com>
>
> Make allmodconfig .config build successfully by making VIOCONS
> available only if VT=n.
> Using PPC_ISERIES in VT prevents kconfig "recursive" warning.

The problem with this is that we are moving toward being able to build a
single kernel with PPC_PSERIES and PPC_ISERIES (and others) all defined,
and this patch will stop Virtual terminal being built in that case.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__18_Oct_2006_11_19_35_+1000_9_8+ax9gNo9x3Y6w
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFNYEoFdBgD/zoJvwRAkiEAJ9GY4h2h6npSKpwk9FSNYJe3n8ziwCdHOpc
r/uchDt5P9mhlYTSxV3g3CQ=
=Tizs
-----END PGP SIGNATURE-----

--Signature=_Wed__18_Oct_2006_11_19_35_+1000_9_8+ax9gNo9x3Y6w--
