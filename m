Return-Path: <joerg@dorchain.net>
Received: from Redstar.dorchain.net (153-133-088-212.ip-addr.teresto.net
	[212.88.133.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7BCB467A67
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Mar 2005 18:37:30 +1100 (EST)
Date: Mon, 7 Mar 2005 08:37:21 +0100
From: Joerg Dorchain <joerg@dorchain.net>
To: domen@coderock.org
Message-ID: <20050307073721.GB15637@Redstar.dorchain.net>
References: <20050306222256.A3F911F1FF@trashy.coderock.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
In-Reply-To: <20050306222256.A3F911F1FF@trashy.coderock.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: Re: [patch 1/4] delete unused file arch_ppc_kernel_find_name.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 06, 2005 at 11:22:56PM +0100, domen@coderock.org wrote:
> Remove nowhere referenced file. (egrep "filename\." didn't find anything)

To me it looks more like a devloper aid than a kernel file. Ok, it
functionality could be replaced by a grep -C, but really delete it?

Joerg

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCLASxjY4+4PdzvOARAgYhAJwMw2KzHYlsVPC1Or0kP0+ZN1UligCeIIik
oRf0i7ISc4l6KtQ+Q5QmwJo=
=Hrn4
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
