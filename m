Return-Path: <jason.mcmullan@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.194])
	by ozlabs.org (Postfix) with ESMTP id 5994967B4A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 00:33:56 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id 13so41513nzp
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Jun 2005 07:33:55 -0700 (PDT)
From: Jason McMullan <jason.mcmullan@gmail.com>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <2731d19a2e3b9413db32be59726a4c82@freescale.com>
References: <42AFDEFE.2040508@ru.mvista.com>
	<2731d19a2e3b9413db32be59726a4c82@freescale.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-qKpMdJsFBFNQdA8GoRJj"
Date: Wed, 15 Jun 2005 10:33:53 -0400
Message-Id: <1118846034.7564.113.camel@jmcmullan.timesys>
Mime-Version: 1.0
Cc: "Gala Kumar K.-galak" <galak@freescale.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC: cpm2_devices.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-qKpMdJsFBFNQdA8GoRJj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-06-15 at 09:25 -0500, Kumar Gala wrote:
> Yes, I removed the fcc_regs_c since its not always true.  Please don't=20
> rename the file to cpm2_.  I think I'm going to end up renaming them to=20
> pq2_ since that is the most appropriate name.  I'd say we are about 80%=20

 PQ2_? But all these devices are on PQ3 also!

--=20
Jason McMullan <jason.mcmullan@gmail.com>
"Sure, send me the latest Knoppix DVD as an attachment..."

--=-qKpMdJsFBFNQdA8GoRJj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCsDxR8/0vJ5szK6kRArmVAJ4rLj7ocuoDPUjfPCdI3wmFpO0sPACgkWvc
sZBVaI9e037z0Fs4oloZv80=
=qjwF
-----END PGP SIGNATURE-----

--=-qKpMdJsFBFNQdA8GoRJj--
