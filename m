Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B34A4DDDF8
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 11:08:51 +1100 (EST)
Subject: Re: hibernate, suspend and s2both support
From: Johannes Berg <johannes@sipsolutions.net>
To: Tim Dijkstra <newsuser@famdijkstra.org>
In-Reply-To: <20070318234601.3f6cc53b@commensaal.drs.p>
References: <20070318010044.0b0bebf0@commensaal.drs.p>
	<1174208083.13027.36.camel@johannes.berg>
	<20070318144115.00ab8912@commensaal.drs.p>
	<1174228670.13027.46.camel@johannes.berg>
	<20070318234601.3f6cc53b@commensaal.drs.p>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ULMbUU8iGQd8HulV428R"
Date: Mon, 19 Mar 2007 01:09:43 +0100
Message-Id: <1174262983.13027.58.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ULMbUU8iGQd8HulV428R
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2007-03-18 at 23:46 +0100, Tim Dijkstra wrote:

> So maybe the safest algorithm would be
> - If /dev/pmu exists
> 	- Check PMU_IOC_CAN_SLEEP
> 		- Yes -> suspend
> 		- No -> Fail (maybe prevents a crash when we would have tried 'echo mem=
')

That's only when it returns 0/1, when calling it returns an error you
need to assume (for suspend) that /dev/pmu doesn't exist. If I can get
my plan through to deprecate both of the ioctls, that is.

> > have tested the 'platform' powerdown method for suspend to disk support
> > in the kernel and that killed the machine due to a yet unidentified
> > problem.
>=20
> I think this is a know problem, at least it happens on more machines.
> Will have to ask for the details.

You can't even try to do it on powerpc right now afaik, and I am sure
that you can't do it after my patches. So you can't do anything wrong
either, though I'm still trying to figure out what I need to do to be
able to allow it.

johannes

--=-ULMbUU8iGQd8HulV428R
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF/dTH/ETPhpq3jKURAhpXAKC2rvZoLzzvUAMcIa3cAzLEk9YnCwCeP30J
myXgvFx4NhtaQYtX09iCOxk=
=sa2T
-----END PGP SIGNATURE-----

--=-ULMbUU8iGQd8HulV428R--
