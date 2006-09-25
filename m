Return-Path: <roubert@df.lth.se>
Received: from df.lth.se (mail.df.lth.se [194.47.250.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 92B8067B83
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Sep 2006 03:18:02 +1000 (EST)
Date: Mon, 25 Sep 2006 19:17:54 +0200
From: Fredrik Roubert <roubert@df.lth.se>
To: Matthew McClintock <msm@freescale.com>
Subject: Re: How to move from /ppc/ to /powerpc/
Message-ID: <20060925171754.GB21204@igloo.df.lth.se>
References: <20060912153316.GC16340@igloo.df.lth.se>
	<20060912105830.3923d537.kim.phillips@freescale.com>
	<20060913132817.GD18263@igloo.df.lth.se>
	<20060921160808.GB4828@igloo.df.lth.se>
	<1159202991.5485.0.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
In-Reply-To: <1159202991.5485.0.camel@localhost>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 25 Sep 18:49 CEST 2006, Matthew McClintock wrote:

> It looks like you already have your chosen node in your DTS file. With
> my u-boot patches the appropriate chosen node is added to the flat tree
> based off the u-boot environment.

Ah, that's true, in ft_setup(), I didn't see that. Thanks! (I'd been
thinking about how the command line should be passed from U-Boot, but
decided to postpone that investigation until I solved the serial console
problem.)

However, the code in ft_setup() doesn't assign "linux,stdout-path", so
if I remove the chosen node from my DTS, then I get no print-out on the
serial console at all. (But the rest of the system appears to run fine
and I can log in using SSH.) Can this be a clue to someone as to what
could be the problem with my serial console?

Cheers // Fredrik Roubert

--=20
Visserij 192  |  +32 473 344527 / +46 708 776974
BE-9000 Gent  |  http://www.df.lth.se/~roubert/

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (SunOS)

iQCVAwUBRRgPQsRKuLhQMn35AQIrDgP/X0n9NqdMKk7lee/FjjNeBLo83V6CfUoJ
gZd4oZopgfjqDlse0EhC9a68r4nK0sT8OOj9NI1gJfQepyn6hbLgKbTkWWYlU2id
N9gdQYLTowNASGIXcuOvu7Bd4qkJrF35Yb6HrmrbDp7RjyWOsoB89yhi9+MrJ38q
Wp6UwHZcbPI=
=5OP6
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
