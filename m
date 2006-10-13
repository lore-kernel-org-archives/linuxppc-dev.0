Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 92CC467C23
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Oct 2006 07:21:20 +1000 (EST)
Date: Sat, 14 Oct 2006 01:21:05 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "Rune Torgersen" <runet@innovsys.com>
Subject: Re: preempt crash in 2.6.18
Message-ID: <20061014012105.6ca4ff05@localhost.localdomain>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B07B397@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B07B397@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_1I_Oqfr7SyGFX/F4.MBR2+s";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_1I_Oqfr7SyGFX/F4.MBR2+s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Oct 2006 09:16:52 -0500
Rune Torgersen wrote:

>=20
> This is from a Freescale 8265 running 2.6.18
> Anyone have any idea what this is and how to fix it?
>=20
Yes. Actually, I recall alike thing and used to fix with proper spin-lockin=
g if the=20
cascade PCI irq, which apparently does do_irq that seems to confuse preempt=
 counters.

Just a pure guess.

Hope it helps.

-Vitaly

--Sig_1I_Oqfr7SyGFX/F4.MBR2+s
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFMANCuOg9JvQhSEsRAs37AKCDRptEGSiZoZAKx/MsP96KVBnBLwCbBD/h
dbrxTvZya9kRsehEElfWW5w=
=r4Dc
-----END PGP SIGNATURE-----

--Sig_1I_Oqfr7SyGFX/F4.MBR2+s--
