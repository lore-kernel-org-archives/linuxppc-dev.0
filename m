Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 14556DDFA6
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 14:49:41 +1100 (EST)
Date: Wed, 21 Nov 2007 14:49:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] sys_indirect kernel implementation for PowerPC
Message-Id: <20071121144935.db1c358f.sfr@canb.auug.org.au>
In-Reply-To: <20071121144245.e8abf9e8.sfr@canb.auug.org.au>
References: <18243.41278.72798.100000@cargo.ozlabs.ibm.com>
	<20071121144245.e8abf9e8.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__21_Nov_2007_14_49_35_+1100_/kFagGcelx.cUSUJ"
Cc: linuxppc-dev@ozlabs.org, Ulrich Drepper <drepper@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__21_Nov_2007_14_49_35_+1100_/kFagGcelx.cUSUJ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Nov 2007 14:08:46 +1100 Paul Mackerras <paulus@samba.org> wrote:
>
> +struct indirect_registers32 {

In fact, you should probably call this struct compat_indirect_registers ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__21_Nov_2007_14_49_35_+1100_/kFagGcelx.cUSUJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHQ6rTTgG2atn1QN8RAkQUAJ9RCRFyp1/nfjbZ4HRlya9y280HJgCdEPJG
zz8/FKHYWRsWnt1x04uTKbk=
=l5vU
-----END PGP SIGNATURE-----

--Signature=_Wed__21_Nov_2007_14_49_35_+1100_/kFagGcelx.cUSUJ--
