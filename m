Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A7BA4DDED6
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 19:08:09 +1000 (EST)
Subject: Re: [PATCH 1/8] powerpc: Fix the MODALIAS generation in modpost
	for of devices
From: Johannes Berg <johannes@sipsolutions.net>
To: Sylvain Munaut <tnt@246tNt.com>
In-Reply-To: <11784659351487-git-send-email-tnt@246tNt.com>
References: <11784659324066-git-send-email-tnt@246tNt.com>
	<11784659351487-git-send-email-tnt@246tNt.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-rDM47BdmseEDMIAw7vIf"
Date: Mon, 07 May 2007 11:09:26 +0200
Message-Id: <1178528966.7261.5.camel@johannes.berg>
Mime-Version: 1.0
Cc: PPC dev ML <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-rDM47BdmseEDMIAw7vIf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2007-05-06 at 17:38 +0200, Sylvain Munaut wrote:
> Since the devices may have multiple (or none) compatible properties,
> the uevent generated internally by the kernel may have multiple
> "C..." entries. So the MODALIAS stored in the module must have
> wilcard before and after the compatible entry.
> Also, if the 'compatible' field is not used for matching, there
> will be no 'C' and that must handled as well.

Ack, I really need this patch for aoa now.

johannes

--=-rDM47BdmseEDMIAw7vIf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGPuzG/ETPhpq3jKURAhBeAKCjd4X0tqxuokmFh5B9ds9WKCdnMwCgsjCL
d7K5sTol57kp0Cd+v8YmFVs=
=4UXZ
-----END PGP SIGNATURE-----

--=-rDM47BdmseEDMIAw7vIf--
