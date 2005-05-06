Return-Path: <jason.mcmullan@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 9FCB267B3D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 May 2005 23:04:28 +1000 (EST)
From: Jason McMullan <jason.mcmullan@timesys.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20050505172035.GB3339@logos.cnet>
References: <20050505172035.GB3339@logos.cnet>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-PRRsRIFSGXkma9lKT2Ij"
Date: Fri, 06 May 2005 09:04:24 -0400
Message-Id: <1115384665.9050.22.camel@jmcmullan.timesys>
Mime-Version: 1.0
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx: fix usage of pinned 8Mbyte TLB entries
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-PRRsRIFSGXkma9lKT2Ij
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-05-05 at 14:20 -0300, Marcelo Tosatti wrote:
> [snip snip]
>
> Allocateing from the coherent memory DMA region. Which sits at, I suppose=
,=20
> after initial 8Megs in all configurations (should be always).=20
>


  What if your board (ie the MPC885ADS) only has 8Mb? Soldered on.


--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-PRRsRIFSGXkma9lKT2Ij
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCe2tY8/0vJ5szK6kRAkmnAKCFBfcnSnmCjz606qQNyI78y5cWyQCgz3k8
XPbf0uW5OLOL/Xzhqb6mdoU=
=Mtug
-----END PGP SIGNATURE-----

--=-PRRsRIFSGXkma9lKT2Ij--
