Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5F1FDDDE23
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 11:11:59 +1100 (EST)
Date: Tue, 6 Jan 2009 11:11:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net/ehea: bitops work on unsigned longs
Message-Id: <20090106111148.90da9b78.sfr@canb.auug.org.au>
In-Reply-To: <20090105.160535.24967514.davem@davemloft.net>
References: <20081231141853.c6d123c4.sfr@canb.auug.org.au>
	<20081230.215156.151347026.davem@davemloft.net>
	<20090106105951.62b0429d.sfr@canb.auug.org.au>
	<20090105.160535.24967514.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__6_Jan_2009_11_11_48_+1100_IRgU9yNttcNMywX1"
Cc: tklein@de.ibm.com, netdev@vger.kernel.org, raisch@de.ibm.com,
	themann@de.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__6_Jan_2009_11_11_48_+1100_IRgU9yNttcNMywX1
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Mon, 05 Jan 2009 16:05:35 -0800 (PST) David Miller <davem@davemloft.net>=
 wrote:
>
> Aha, yes the commit message fooled me :-)  New patch is fine and
> I'll toss this into net-2.6

I will try to do better in the future, thanks.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__6_Jan_2009_11_11_48_+1100_IRgU9yNttcNMywX1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkliocQACgkQjjKRsyhoI8w7HACfYAgOyx9NXyXR5JgRkLniWWNQ
dggAn14ZZDw6CRCpQVf9wRwQXjzYolqE
=B87q
-----END PGP SIGNATURE-----

--Signature=_Tue__6_Jan_2009_11_11_48_+1100_IRgU9yNttcNMywX1--
