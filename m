Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 345EB67A3E
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 12:11:57 +1000 (EST)
Date: Wed, 9 Aug 2006 12:11:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Zang Roy-r61911" <tie-fei.zang@freescale.com>
Subject: Re: Perhaps git-update-server-info needs to be run
	on.../paulus/powerpc.git?
Message-Id: <20060809121150.6ee17129.sfr@canb.auug.org.au>
In-Reply-To: <7EA18FDD2DC2154AA3BD6D2F22A62A0E19D489@zch01exm23.fsl.freescale.net>
References: <20060808193555.301bc229.kim.phillips@freescale.com>
	<7EA18FDD2DC2154AA3BD6D2F22A62A0E19D489@zch01exm23.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__9_Aug_2006_12_11_50_+1000_UH7cS=UZBrMG8TWi"
Cc: linuxppc-dev@ozlabs.org, Kim.Phillips@freescale.com, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__9_Aug_2006_12_11_50_+1000_UH7cS=UZBrMG8TWi
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Aug 2006 09:30:13 +0800 "Zang Roy-r61911" <tie-fei.zang@freescale=
.com> wrote:
>
> > Linus' tree clones fine, paulus' doesn't:
> >=20
> I have the same issue.

Have you tried using the git protocol ("git://" instead of "http://")? Or
cloning Linus tree and then fetching Paulus tree into it?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__9_Aug_2006_12_11_50_+1000_UH7cS=UZBrMG8TWi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE2URwFdBgD/zoJvwRAib7AKCVu1srOnLeu5gOTRSI7OxEVpv0TACgmKSC
vsixgjJS8gakL4ra5c0/Ctc=
=PJNd
-----END PGP SIGNATURE-----

--Signature=_Wed__9_Aug_2006_12_11_50_+1000_UH7cS=UZBrMG8TWi--
