Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8CD93DDF64
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 11:15:07 +1100 (EST)
Date: Thu, 13 Dec 2007 11:14:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 6/8] mpc83xx: timer driver for PM wakeup
Message-Id: <20071213111439.eebba83b.sfr@canb.auug.org.au>
In-Reply-To: <20071212173604.GE5596@loki.buserror.net>
References: <20071212173519.GA5577@loki.buserror.net>
	<20071212173604.GE5596@loki.buserror.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__13_Dec_2007_11_14_39_+1100_V=+/Gm_EMGNPdapy"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__13_Dec_2007_11_14_39_+1100_V=+/Gm_EMGNPdapy
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Scott,

On Wed, 12 Dec 2007 11:36:04 -0600 Scott Wood <scottwood@freescale.com> wro=
te:
>
> +static int __devinit gtm_probe(struct of_device *dev,
> +                               const struct of_device_id *match)
> +{
	.
	.
	.
> +out:

Just for consistency, you probably want
	dev_set_drvdata(&dev->dev, NULL);
here

> +	kfree(priv);
> +	return ret;
> +}

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__13_Dec_2007_11_14_39_+1100_V=+/Gm_EMGNPdapy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHYHlzTgG2atn1QN8RAmg9AKCWmgRVu6KHOJNivmNMznIccQdXIACdFHaL
8o6vrnVE5UwlJw5x9iR7RyQ=
=KrB4
-----END PGP SIGNATURE-----

--Signature=_Thu__13_Dec_2007_11_14_39_+1100_V=+/Gm_EMGNPdapy--
