Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E368DDDDD5
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 00:20:24 +1100 (EST)
Subject: Re: [RFC] PMU: replace information ioctls and schedule for removal
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18232.56988.723620.912943@cargo.ozlabs.ibm.com>
References: <1194523351.6294.11.camel@johannes.berg>
	<1194814546.6510.20.camel@pasglop>
	<1194885218.5229.47.camel@johannes.berg>
	<18232.56988.723620.912943@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Ws1qcSMkbWtuhh3yeEaM"
Date: Tue, 13 Nov 2007 14:20:43 +0100
Message-Id: <1194960043.9116.55.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Ws1qcSMkbWtuhh3yeEaM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Tue, 2007-11-13 at 10:15 +1100, Paul Mackerras wrote:
> Johannes Berg writes:
>=20
> > Does anybody need that? I'm not against adding it but we never showed i=
t
> > and I haven't seen anyone ask for it.
>=20
> pmud uses the PMU version, but I think it gets it by issuing a PMU
> command.

Yeah, it probably has to since I don't see us exporting it anywhere. Do
we want to change pmud to read it from elsewhere? I guess I'll just add
it to sysfs and it can use it if it wants.

johannes

--=-Ws1qcSMkbWtuhh3yeEaM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARzmkqqVg1VMiehFYAQJ7BA/+LDMUYjMhxQqgY5CEZ5hQ+Cx7QhO8S8gN
Ssf+9kDVnLgjSwb5Ij49c2o4aQQ1eHWnhTnpYjSPZaeXisiCDkkkXQG5J5uAOVZ1
wq7kkOE5zPdkeTRMJYDG9Kj5gtL/3DcN2maa2dHkQaGsA1A8qn4qz8SzpnJSxZV2
pfWEq3E12Xn90L06oWij+hG4qa7IuBBYtWnMnmcDXV6Zl4TEUigXpilE4eeJi26g
0V7nZZR9rT72Bcdi28oHADx1HPlzX+FE4GmKxPJmhWZC7TuFDNao/2ekIiKvKIoY
VCd6/3QOlttXSA3i+3NfV/yU1B6Ao0D3MKtkXA9+3tcZ9GTuCJ2Ftwf9UCTQ9Ma0
u7xxUXQwx8c6er1KI2cIWJgIuRFaOjk5KNdrGayP46dpI2eZ8TjixlWhV6Kat3CD
BLBd0eOyQMS8o0FrIaKd/8zVYx9eLHwo4DbnwNFkP+wacggHr1E0jkZ/mUuNZ2nr
5S1FYh/3TeH7aktXh4sLbq4WubKAp27TctLiePm7gObFlvle2GxUavUwkVjxrxdm
GhDuoIr0YsGddIDa0SrNnW31UXhFqtb98WYnnuAvGNemn9+nhVKCBM2bu61mqlVS
gB9Rk4awgG23Dkm5zXTf06/EWALPYgthPd8tebR/j4g7ju8eQIpCo1ktV1GYZ3fq
YOUn6SlOGWE=
=amsF
-----END PGP SIGNATURE-----

--=-Ws1qcSMkbWtuhh3yeEaM--
