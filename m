Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1EF49DDE05
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 Oct 2007 23:52:48 +1000 (EST)
Date: Sat, 13 Oct 2007 17:52:42 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "Charles Krinke" <ckrinke@istor.com>
Subject: Re: I2C support for 8541
Message-ID: <20071013175242.040cb371@ru.mvista.com>
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1F9@MERCURY.inside.istor.com>
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1F4@MERCURY.inside.istor.com>
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1F9@MERCURY.inside.istor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.LFl7k9Xzl+LLzwnDoI3.z8";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: Randy Brown <rbrown@istor.com>, Chris Carlson <ccarlson@istor.com>,
	Kevin Smith <ksmith@istor.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Sig_/.LFl7k9Xzl+LLzwnDoI3.z8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Charles,

On Mon, 30 Apr 2007 09:25:28 -0700
Charles Krinke wrote:

> Assuming I have the external IRQ's understood, the next issue is the
> hardware clock on our board with the linux-2.6.17.11 kernel. We are
> using a "DS1338U", which is an I2C RTC.
>=20
> I am trying to identify the relevant source for the 8541/8555 I2C
> interface in the source base which reads/writes I2MOD, I2ADD, II2BRG,
> I2COM, I2CER & I2CMR.
>=20
> I can find a few references to MPC85xx_CPM_I2C in
> ../syslib/mpc85xx_devices.c, but nothing close in drivers/i2c/...
>=20
> Can someone help me understand the completeness of the I2C source in the
> 2.6.17.11 kernel, please.
>=20

i2c-mpc.c is prolly responsible to care of 8xxx i2c stuff...

HTH
> Charles Krinke
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

--Sig_/.LFl7k9Xzl+LLzwnDoI3.z8
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHEM2qe8XNc4YXvvgRApSnAJ0Tq/Ik9DzLs/GzHGnfijd2S2Dv1gCdF81X
XrVdR83+1AHN4mE3IL+P8aw=
=Nfjs
-----END PGP SIGNATURE-----

--Sig_/.LFl7k9Xzl+LLzwnDoI3.z8--
