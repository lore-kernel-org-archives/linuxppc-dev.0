Message-Id: <200107030801.KAA16173@frodo.gams.co.at>
From: Bernd Petrovitsch <bernd@gams.at>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [linuxppc-embedded:] Re: NFS mount root problem 
In-Reply-To: Your message of "Tue, 03 Jul 2001 03:57:44 EDT."
             <3B417AF8.DDC7F300@engmail.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1030911116P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 03 Jul 2001 10:01:51 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--==_Exmh_1030911116P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

In message <3B417AF8.DDC7F300@engmail.uwaterloo.ca>, Tim Woo wrote:
>(08:00:3e:2d:35:ab) via eth0
>Jul  3 03:57:23 linuxnanpa mountd[998]: refused mount request from
>linuxbrd for /tftpboot/linuxbrd (/): no export entry

Apparently the hostname of your board is "linuxbrd". And now it wants
to mount it's root directory from the above path.

	Bernd

-- =

Bernd Petrovitsch                              Email : bernd@gams.at
g.a.m.s gmbh                                  Fax : +43 1 205255-900
Prinz-Eugen-Stra=DFe 8                    A-1040 Vienna/Austria/Europe
                     LUGA : http://www.luga.at



--==_Exmh_1030911116P
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.2 06/23/2000

iQBVAwUBO0F776/rvrblD00BAQJwvAIAqA58/tfDiFi0mBLT3ecKOKq+Vl9GX/h7
xYmgr284Pkh0ijO49KWcenZosg/qUOncsj89qZ1aJFlq9ZhhEoal5g==
=uDxo
-----END PGP MESSAGE-----

--==_Exmh_1030911116P--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
