Return-Path: <jason.mcmullan@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.197])
	by ozlabs.org (Postfix) with ESMTP id E3759679E7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Jun 2005 05:20:47 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id 13so283602nzp
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Jun 2005 12:20:45 -0700 (PDT)
From: Jason McMullan <jason.mcmullan@gmail.com>
To: vbordug@ru.mvista.com
In-Reply-To: <1119627190.28058.39.camel@jmcmullan.timesys>
References: <1119627190.28058.39.camel@jmcmullan.timesys>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-vcq2mea7rsf+cFfFzZHK"
Date: Fri, 24 Jun 2005 15:20:42 -0400
Message-Id: <1119640843.28058.50.camel@jmcmullan.timesys>
Mime-Version: 1.0
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: PQ2FADS PCI Interrupts
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-vcq2mea7rsf+cFfFzZHK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-06-24 at 11:25 -0400, McMullan, Jason wrote:
> Given your latest MPC82xx PCI patches to the list, PCI support
> is *better*, but interrupts are *not* delivered on the PQ2FADS

Solved my own problem:

	Clear SIUMCR_DPPC11 in immap->im_siu_conf.siu_82xx.sc_siumcr

Otherwise, IRQ6 is not routed to the SIU.

--=20
Jason McMullan <jason.mcmullan@gmail.com>
"Sure, send me the latest Knoppix DVD as an attachment..."

--=-vcq2mea7rsf+cFfFzZHK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCvF0K8/0vJ5szK6kRAp9gAJ4mt6K6rEH8ElADkSKmrUpzH3hLWQCfZanZ
OcUyIgHXMBSpst+AJ+rbn/s=
=nWzE
-----END PGP SIGNATURE-----

--=-vcq2mea7rsf+cFfFzZHK--
