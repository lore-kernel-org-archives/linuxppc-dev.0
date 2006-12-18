Return-Path: <roman.fietze@telemotive.de>
Received: from mail.telemotive.de (mail.telemotive.de [62.206.149.210])
	by ozlabs.org (Postfix) with ESMTP id B93E467BE2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Dec 2006 01:46:15 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 284D81A76A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Dec 2006 15:46:10 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Lite5200B I2S driver
References: <BAY122-F958549D2AE5C2CEC3F7EDCAD60@phx.gbl>
	<200612131356.50092.roman.fietze@telemotive.de>
	<45869C06.5020507@gersys.de>
In-Reply-To: <45869C06.5020507@gersys.de>
MIME-Version: 1.0
Message-ID: <200612181546.09884.roman.fietze@telemotive.de>
Date: Mon, 18 Dec 2006 15:46:06 +0100
Content-Type: multipart/signed; boundary="nextPart3176283.L2XoIpSQzo";
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

--nextPart3176283.L2XoIpSQzo
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Stefan,

On Monday 18 December 2006 14:47, Stefan Strobl wrote:

> What I am wondering is, how many DMA tasks do you run besides Audio?
> I am already using DMA for IDE and FEC so Audio would be my third
> DMA task. I remember that it used to be difficult to get more than
> two tasks running at the same time.

As of my curret knowledge it is definitely a problem to run IDE-DMA
together with any access to the LocalPlus on the old B2 mask of the
MPC5200. We did not have problems using the BestComm concurrently for
IDE, FEC and the PSC (I2S+SPI codec mode) on either mask.


> Would you send me or post your bestcomm sources since I'm not that
> proficient in kernel programming.

No problem, I will mail you the same tar fiel I sent to Wolfgang. This
includes the BestComm code and once more the drivers. It's derived
work and GPL'd.


Roman

=2D-=20
Roman Fietze              Telemotive AG B=FCro M=FChlhausen
Breitwiesen                            73347 M=FChlhausen
Tel.: +49(0)7335/18493-45      http://www.telemotive.de


--nextPart3176283.L2XoIpSQzo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFhqmxp5XY/BK//MIRAu3vAJ9L/8QQCJCn5Bt5dI69nT9ZNQt2NQCfbCef
M6zSdeO8Kfgn8gBgWm6t9XE=
=bZNW
-----END PGP SIGNATURE-----

--nextPart3176283.L2XoIpSQzo--
