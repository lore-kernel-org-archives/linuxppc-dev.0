Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 09D26DDE01
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 20:37:31 +1100 (EST)
Subject: Re: 2.6.24-rc1-git15 Kernel build fails on powerpc - Unrecognized
	opcode: `dssall'
From: Johannes Berg <johannes@sipsolutions.net>
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <20071106154439.GK5080@shadowen.org>
References: <47304343.2010709@linux.vnet.ibm.com>
	<661de9470711060246s3040f68drf0a6310aeec4e1e8@mail.gmail.com>
	<1194346486.4066.13.camel@johannes.berg>
	<20071106.031001.189578769.davem@davemloft.net>
	<47304FE5.2010309@linux.vnet.ibm.com>
	<47306E9C.4090202@linux.vnet.ibm.com>
	<20071106154439.GK5080@shadowen.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-yyWM7j9Zq7eK+k39kw1Q"
Date: Wed, 07 Nov 2007 10:38:43 +0100
Message-Id: <1194428323.4055.3.camel@johannes.berg>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, sam@ravnborg.org,
	David Miller <davem@davemloft.net>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-yyWM7j9Zq7eK+k39kw1Q
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



> So that sounds like a Kconfig problem then?  That HIBERATION requires
> ALITIVEC and yet does not depend on it or set it.

Yes. I'm guessing that it broke with Rafael's hibernation/suspend
Kconfig changes but will take a look. I think it used to depend on
powermac.

johannes

--=-yyWM7j9Zq7eK+k39kw1Q
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARzGHoqVg1VMiehFYAQJYNA/+Mx3H4kj3FC7hYVt24kvlgrUPQR7JnR7B
9gBirtakOE3Zjq/GhQiX3z5JxYDMIjIeWkAZdPmZ2uIE+sqb6nzA+7gJcdq8/0vs
QcJfwa0QZiQU3OCflFK/gTiNHNNLCVBDIOZgpIlwG7tWtNo1MJ/FFJltndkOnqpf
gxnB5TDKRio4c6K7L9L6IQSZiLsPmHnbP/ez7r7i6JKq8EoKkm/ZXehaeVjU0DwE
rM4ySRmsQhsMBMqLtymLy06AS8vSMfiZvFLZh54KTGo6kDbMqWf6lI/W6LtL59nD
EBjTlNkML8xLGswEQTo/IWgUFdGO0vhfriqICM2zfbOi8NmQIwBLqOO6CfZOgXFV
e6vO+vdrHOlyjTpwoXdfPoC68PNmdASappPIl5718kTRzJ78jcPkQhJJ0PxA382T
SvFzDXjs6xPgOvWYDuVsqROkrzTAAzv6XlHul7KDi4yK4EvBMqbDZHeB7RAWeP+l
ibLuyb7KjHTfSD5NOWgKJay2/mykqKYWW9SQhakN4Rw7v3NLpnKq9DNza3PJ7M5Y
VN1S2FmIVpNiWjqdqD7SReKfigkOC+8JZp3SZvJYq2cC9TzA6mzBn7MQyQukJzr2
aE5M+LEyaetvLFwjdrfkKN4ePH1m6NsdLB+LgyRDM8uXLt3IPwtSwcoS5Q3jy05x
D/bTbZCUliM=
=EVAc
-----END PGP SIGNATURE-----

--=-yyWM7j9Zq7eK+k39kw1Q--
