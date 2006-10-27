Return-Path: <roman.fietze@telemotive.de>
Received: from mail.telemotive.de (mail.telemotive.de [62.206.149.210])
	by ozlabs.org (Postfix) with ESMTP id F283D67CBF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Oct 2006 21:15:22 +1000 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 66D6B1C6C7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Oct 2006 13:15:19 +0200 (CEST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 (Board: PM520) I2C Problem
References: <F05B338A1B21D9119FFF0004761A51136AB28E@exchange-server.ow.ks>
	<4541B547.1010908@varma-el.com>
In-Reply-To: <4541B547.1010908@varma-el.com>
MIME-Version: 1.0
Message-ID: <200610271315.19077.roman.fietze@telemotive.de>
Date: Fri, 27 Oct 2006 13:15:15 +0200
Content-Type: multipart/signed; boundary="nextPart1678259.MSirqsEZZq";
	protocol="application/pgp-signature"; micalg=pgp-sha1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart1678259.MSirqsEZZq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

On Friday 27 October 2006 09:29, Andrey Volkov wrote:

> Revision of MPC5200? (third string engraved on the MPC)
> If L25R then check this doco:
>    http://www.freescale.com/files/32bit/doc/errata/MPC5200E.pdf
> (if be short - I2C didn't work on this revision chips)

We have an "MPC5200CBV400 L25R Rev 2" on our boards, and we
successfully drive a PCF8563 real time clock and an UDA1380 Codec on
the same line.

The problems described in the errata are an arbitration loss problem
and, depending on teh chp's Rev, a clock noise problem.

Probably your problem is related to the connected I2C client?


Roman

=2D-=20
Roman Fietze              Telemotive AG B=FCro M=FChlhausen
Breitwiesen                            73347 M=FChlhausen
Tel.: +49(0)7335/18493-45      http://www.telemotive.de


--nextPart1678259.MSirqsEZZq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFQepHp5XY/BK//MIRAktfAJ0SHZB9gAswXNIi4krXPT1tNwpBCgCfWuTZ
Ytl0PFXkDB5xncvRRhCDqxw=
=1Yte
-----END PGP SIGNATURE-----

--nextPart1678259.MSirqsEZZq--
