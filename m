Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BEA43DE0E7
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Dec 2008 09:21:46 +1100 (EST)
Subject: Re: powerbook VT garbled between rc7 and rc8
From: Johannes Berg <johannes@sipsolutions.net>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <je7i65r42j.fsf@sykes.suse.de>
References: <1229078554.3600.8.camel@johannes.berg>
	<je7i65r42j.fsf@sykes.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-rPSzDL3QA7UOLqo7aVN/"
Date: Fri, 12 Dec 2008 23:21:26 +0100
Message-Id: <1229120486.3565.0.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-rPSzDL3QA7UOLqo7aVN/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-12-12 at 13:05 +0100, Andreas Schwab wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
>=20
> > After upgrading to -rc8 yesterday my powerbook started up today with th=
e
> > screen totally garbled, only occasionally was a word readable.
>=20
> Try 6c34bc2976b30dc8b56392c020e25bae1f363cab (Revert "radeonfb:
> accelerate imageblit and other improvements").

I cherry-picked this and it works again, thanks!

johannes

--=-rPSzDL3QA7UOLqo7aVN/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJQuPjAAoJEKVg1VMiehFYR/sQAMQFTVB5oRLqI4y3Viaah//i
lrKO0H2+Vk+6RSMlK1hc7zWjDSaKBHhXBe70S4zi2cHzDxDZ3YdoreamG/+JTOlg
i3opYGPWPZu79UVJbMUmukYcC56XU+pebVxdx8nJi0QEiwpNMoAZ5HWLVM5tEgEh
U1FIayCyrmzmQ9qhUuD/zZZanZmyNJ2/iLv0bn4M+Ew5EfuGrAa69P0gS80yeW/f
FZ9H0hiG2mDS38rfG2URvalccyJCU7gq+hXZWtt2etVyanpuXxF9MDUYFOYxgFKl
U+7XNd38tqAlEpIYHTcGprxRoL9ANJ22pGfZn3YbF9MPgrbNWynxA5N7977g8qob
s34cDP09GE9uGqG2lLuQwN3ENac1ew/X3bNmou0Coc9FvJliQHERl8NY1TxzciYf
dSOGgK3HUAfAFjmLDkCcrUthzgITqBHgnGAtiOrMtd0ff9rJ5xY9CW3I0QSMHhCD
RVelD9o8ud3x4OnctQN9pmv0xrcyiOhv/gDGB4SikLazmo9tOrrAvNII8JPoH3TM
YOa1bk9JzrTjkOrKsEDgoYR5eNYpChPMxe6K+d6YnkV+S7f1HN2vWCyyzKwdT7ij
bN62d9LX2QoddezovDNfqhP6GQK19+tevu9X1BntIDxyUDwJrXiZt2l6RYk8vdQv
lzU5OKFXzy8OmzkHdqk7
=cZL4
-----END PGP SIGNATURE-----

--=-rPSzDL3QA7UOLqo7aVN/--
