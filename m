Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 18A20DDE3C
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 17:07:49 +1100 (EST)
Date: Fri, 23 Feb 2007 17:07:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: Re: [POWERPC] tidy spinlock.h a bit
Message-Id: <20070223170743.9b13566b.sfr@canb.auug.org.au>
In-Reply-To: <20070223144057.27e1e819.sfr@canb.auug.org.au>
References: <20070223144057.27e1e819.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__23_Feb_2007_17_07_43_+1100_+KkoS6FFgXWpX3Pz"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__23_Feb_2007_17_07_43_+1100_+KkoS6FFgXWpX3Pz
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2007 14:40:57 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> _raw_{spin,read,write}relax() are not used anywhere, so remove them.

Forget this one.  (mutter ... damn constructed symbols ... mutter)
--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__23_Feb_2007_17_07_43_+1100_+KkoS6FFgXWpX3Pz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF3oS0FdBgD/zoJvwRAhlEAJ4mlLhuGWxdn81dIA6sGU9Xt2P3aACglSLT
HfEyVWtUlTTF0uv0ihB3aPY=
=ZKqA
-----END PGP SIGNATURE-----

--Signature=_Fri__23_Feb_2007_17_07_43_+1100_+KkoS6FFgXWpX3Pz--
