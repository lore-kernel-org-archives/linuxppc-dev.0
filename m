Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7ED6867A33
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Apr 2006 13:06:15 +1000 (EST)
Date: Wed, 5 Apr 2006 13:05:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch of powerpc
Message-Id: <20060405130553.3240e5ea.sfr@canb.auug.org.au>
In-Reply-To: <1E1C6A02-5C4D-4A3A-8483-8D5E2773680B@kernel.crashing.org>
References: <Pine.LNX.4.44.0604041612320.30113-100000@gate.crashing.org>
	<20060405102837.66b44c43.sfr@canb.auug.org.au>
	<1E1C6A02-5C4D-4A3A-8483-8D5E2773680B@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__5_Apr_2006_13_05_53_+1000_pXShg8Y1kSkbxYU1"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__5_Apr_2006_13_05_53_+1000_pXShg8Y1kSkbxYU1
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

On Tue, 4 Apr 2006 20:23:23 -0500 Kumar Gala <galak@kernel.crashing.org> wr=
ote:
>
> We need the irq rework before I'd be willing to do this.  The main =20
> dependancy between asm-ppc and asm-powerpc is the static IRQs we =20
> currently have.  I'd rather spend time on fixing up the IRQ handling =20
> to parse the flat dev tree.

I agree entirely.  To clrify, I was referring to header files that only
exist in include/asm-ppc and are trivial to move.

Patches following ...
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__5_Apr_2006_13_05_53_+1000_pXShg8Y1kSkbxYU1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEMzQSFdBgD/zoJvwRAkFUAJ44xAkco6RX1R9+lw8g46s+/3tBCACfTWL8
J/eVgu5VQ3KZto+WaMsLZi8=
=Qv15
-----END PGP SIGNATURE-----

--Signature=_Wed__5_Apr_2006_13_05_53_+1000_pXShg8Y1kSkbxYU1--
