Return-Path: <vitorio@digitel.com.br>
Received: from hermes.digitel.com.br (hermes.digitel.com.br [200.198.105.36])
	by ozlabs.org (Postfix) with ESMTP id 0CB302BF07
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Jan 2005 02:32:41 +1100 (EST)
Received: from [10.10.10.160] by hermes.digitel.com.br (GMS
	9.01.3158/NU1492.00.9f6ce814) with ESMTP id hkygibaa for
	linuxppc-embedded@ozlabs.org; Mon, 3 Jan 2005 13:27:16 -0200
From: =?ISO-8859-1?Q?Lu=EDs_Vit=F3rio?= Cargnini <vitorio@digitel.com.br>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-2dmQTvC4gijgya6+K0gv"
Date: Mon, 03 Jan 2005 13:20:58 +0000
Message-Id: <1104758458.14925.5.camel@vitorio>
Mime-Version: 1.0
Subject: Making a serial multiplexer (new driver)
Reply-To: vitorio@digitel.com.br
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-2dmQTvC4gijgya6+K0gv
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi i need to write a driver that must multiplex an serial channel my
driver will have  3 interfaces and i must communicate with another
interface  (midleware) like /dev/ttyS2 for example, how could i write a
driver that will communicate with my existing uart ???

i have a component that could be multiplexed in 3 logical channels throw
my single physical channel that are accessed with a normal serial
interface using uart, how could this be possible ?
this is necessary to be transparent to software user level.
--=20
Lu=EDs Vit=F3rio Cargnini <vitorio@digitel.com.br>
Digitel S/A

--=-2dmQTvC4gijgya6+K0gv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB2Ua4yHSZZ0hdDzQRAn3aAJ4pAmVCKaaSnNBMlTXxrUsvSRDsDgCgn1KW
ramVzaVvZTd2l2icH9mpZ5Y=
=Ajh+
-----END PGP SIGNATURE-----

--=-2dmQTvC4gijgya6+K0gv--
