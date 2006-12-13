Return-Path: <roman.fietze@telemotive.de>
Received: from mail.telemotive.de (mail.telemotive.de [62.206.149.210])
	by ozlabs.org (Postfix) with ESMTP id 7876F67B9F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Dec 2006 20:10:50 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 1EC36183C5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Dec 2006 10:10:43 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Lite5200B I2S driver
References: <BAY122-F11E9828E7994B0E0514B19CAD70@phx.gbl>
In-Reply-To: <BAY122-F11E9828E7994B0E0514B19CAD70@phx.gbl>
MIME-Version: 1.0
Message-ID: <200612131010.42401.roman.fietze@telemotive.de>
Date: Wed, 13 Dec 2006 10:10:38 +0100
Content-Type: multipart/signed; boundary="nextPart1800328.fEp5IaSP9d";
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

--nextPart1800328.fEp5IaSP9d
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Pedro,

On Tuesday 12 December 2006 16:47, Pedro Luis D. L. wrote:

> I=B4m working with a Lite5200B EVB, trying to atach an audio output to
> a PCM 1680 from Texas Instruments.

I've got a fully working GPL ALSA driver for the MPC5200 PSC's using
I2S as well as the ALSA controls for an UDA1380 codec connected via
I2C. This code is written for ALSA 1.0.8 and the 2.4.25 from Wolfgang.

I'm sorry not to be able to provide a patchset for either ALSA nor the
2.6. If you are interested in this code I will post it here.

A question to the mailing pro's: should I post source as attachments
or inlined?


Roman

=2D-=20
Roman Fietze              Telemotive AG B=FCro M=FChlhausen
Breitwiesen                            73347 M=FChlhausen
Tel.: +49(0)7335/18493-45      http://www.telemotive.de


--nextPart1800328.fEp5IaSP9d
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFf8OSp5XY/BK//MIRAlEPAJ9kwCN8+4JFiD7AyuDB3EM+cYYA6gCeOura
4GB6RdZov5ffjARRH3L9GSA=
=3iaT
-----END PGP SIGNATURE-----

--nextPart1800328.fEp5IaSP9d--
