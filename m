Return-Path: <lasaine@lvk.cs.msu.su>
Received: from mail.lvk.cs.msu.su (gate.lvk.cs.msu.su [158.250.17.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.lvk.cs.msu.su", Issuer "CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id AA36CB70DE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Feb 2011 11:02:31 +1100 (EST)
Date: Tue, 8 Feb 2011 03:01:59 +0300
From: Alexander Gordeev <lasaine@lvk.cs.msu.su>
To: tmarri@apm.com
Subject: Re: [PATCH V9 02/10] USB/ppc4xx: Add Synopsys DWC OTG driver framework
Message-ID: <20110208030159.27ce8e32@apollo.gnet>
In-Reply-To: <1297119220-28302-1-git-send-email-tmarri@apm.com>
References: <1297119220-28302-1-git-send-email-tmarri@apm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA256;
	boundary="Sig_/QgYrgqbfxwx=GBBsQ_MDwW/";
	protocol="application/pgp-signature"
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Fushen Chen <fchen@apm.com>, Mark Miesfeld <mmiesfeld@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/QgYrgqbfxwx=GBBsQ_MDwW/
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=D0=92 Mon,  7 Feb 2011 14:53:40 -0800
tmarri@apm.com =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> From: Tirumala Marri <tmarri@apm.com>
>=20
> Platform probing is in dwc_otg_apmppc.c.
> Driver parameter and parameter checking are in dwc_otg_param.c.

You renamed all files but old names are still used here.

> Signed-off-by: Tirumala R Marri <tmarri@apm.com>
> Signed-off-by: Fushen Chen <fchen@apm.com>
> Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
> ---
[snip]


--=20
  Alexander

--Sig_/QgYrgqbfxwx=GBBsQ_MDwW/
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBCAAGBQJNUIf3AAoJEElrwznyooJb0nwH/A8P79eaPoEx4JSvBIiJOtmL
MxKbTXUR7KKbV5xcaNBKbWul7j+TrlEC5mMX/wlhAvCQ4DpwtXWKsMtiEfwa2eXu
fgXPvbBFo74azvnFgLxqdigygLyp0av4/k+tVTAsMR8x4CeMfHy8z6YY4V/oXns/
8j9EAhQaYn583KIAZ7sCHXokcScffVdhuklHtjWVCq9A0+qm5jUQQNRV34N7x73f
HpxmT/RQBcCxar2coc00AMzg7AS71WDbRtj98TvjDb25Fjdo4u3OXVuzvJFpeSdg
XebBxvBgFx5PSZ3Opqea5la2C8yNV/wkv/DVKKny0cq1rNZiGhBJFEYdRBXLPmY=
=k4qH
-----END PGP SIGNATURE-----

--Sig_/QgYrgqbfxwx=GBBsQ_MDwW/--
