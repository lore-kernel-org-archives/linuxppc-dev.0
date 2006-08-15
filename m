Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 66EAB67B5A
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 13:12:43 +1000 (EST)
Date: Tue, 15 Aug 2006 13:12:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: [PATCH] powerpc: Instrument Hypervisor Calls
Message-Id: <20060815131231.5501178b.sfr@canb.auug.org.au>
In-Reply-To: <20060815023224.GA3622@monkey.ibm.com>
References: <20060814232144.GG3213@w-mikek2.ibm.com>
	<20060815110319.5f34417a.sfr@canb.auug.org.au>
	<20060815023224.GA3622@monkey.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__15_Aug_2006_13_12_31_+1000_HZAWX=tpNVX6TDqX"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__15_Aug_2006_13_12_31_+1000_HZAWX=tpNVX6TDqX
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Aug 2006 19:32:24 -0700 Mike Kravetz <kravetz@us.ibm.com> wrote:
>
> My intention was to detect the presence of PURR in the display (debugfs)
> code.  If there is no PURR, then no PURR values are displayed.  My thought
> is that it doesn't matter what values are in the field if we don't display
> them. =20
>=20
> Unfortunately, I left that bit of code out of the patch.
>=20
> How does that sound?  Suppose I can also put all the 'calculate PURR delt=
a'
> code in the FTR_SECTION to save a few cycles.

That sounds good (as long as you also suppress the display).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__15_Aug_2006_13_12_31_+1000_HZAWX=tpNVX6TDqX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE4TufFdBgD/zoJvwRAsJHAKCh3bsB3poG822XTY1yGTWfveSfyQCfb1Ij
Jz+JJ9eEOJl+QQIndrULb3E=
=DEd0
-----END PGP SIGNATURE-----

--Signature=_Tue__15_Aug_2006_13_12_31_+1000_HZAWX=tpNVX6TDqX--
