Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1546867C5A
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 10:37:10 +1100 (EST)
Date: Thu, 16 Nov 2006 02:36:49 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/5] [POWERPC] 8xx: generic 8xx code arch/powerpc port
Message-ID: <20061116023649.769b77ec@localhost.localdomain>
In-Reply-To: <20061115182316.GA20719@lst.de>
References: <20061114012504.17455.13833.stgit@localhost.localdomain>
	<20061114012816.17455.12059.stgit@localhost.localdomain>
	<20061115182316.GA20719@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_f5xBznTLS0KR0ma_1+/E6CO";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_f5xBznTLS0KR0ma_1+/E6CO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

As a short disclaimer, the patch under consideration is a direct copy from =
arch/ppc (since the aim is to move the migration
forward). Apparently it looks like it's a good time to clean it up, and may=
be move to /lib so that we have central stuff to deal with non-cache-cohere=
nt targets. But I have to say I don't know much about other arch's approach=
es to consider what
we have below ppc-specific or not.

All your notes make sense so I'll clean up and will remove ifdeffed section.
But as for generic approach, my opinion is that it should be carefully cons=
idered, and I suggest to get back to it once  the 8xx framework will get in=
.=20

Thanks for your time!

--
Sincerely, Vitaly

--Sig_f5xBznTLS0KR0ma_1+/E6CO
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFW6SSuOg9JvQhSEsRAuxEAJ0eX57H06zC9FfaPGSfAvJUtCbXlgCeKdTj
UF7wewsz4laAHLvDPJOHLf8=
=x2XI
-----END PGP SIGNATURE-----

--Sig_f5xBznTLS0KR0ma_1+/E6CO--
