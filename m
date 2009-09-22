Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] perf_event, powerpc: Fix compilation after big
	perf_counter rename
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1253606415.7103.216.camel@pasglop>
References: <19128.4280.813369.589704@cargo.ozlabs.ibm.com>
	<1253584591.7103.197.camel@pasglop>  <20090922072834.GA25470@elte.hu>
	<1253606415.7103.216.camel@pasglop>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-Vp5S5YL/PSnSyWsEdaX9"
Date: Tue, 22 Sep 2009 21:52:12 +1000
Message-Id: <1253620332.10476.4.camel@concordia>
Mime-Version: 1.0
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-Vp5S5YL/PSnSyWsEdaX9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-09-22 at 18:00 +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2009-09-22 at 09:28 +0200, Ingo Molnar wrote:
> >=20
> > Nevertheless you are right that i should have caught this particular=20
> > PowerPC build bug - i missed it - sorry about that!
> >=20
> Allright. Well, to help in general, we are setting up a build-bot
> here too that will build -tip HEAD for at least powerpc daily with
> a few configs too.

Results here:

http://kisskb.ellerman.id.au/kisskb/branch/12/

cheers

--=-Vp5S5YL/PSnSyWsEdaX9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkq4umgACgkQdSjSd0sB4dKs0gCfdkt5/dnFd6/SYu7ksFZWX4Vn
e5wAn3goUGRJQidvvBpiugwLpnsq9HRm
=aF3y
-----END PGP SIGNATURE-----

--=-Vp5S5YL/PSnSyWsEdaX9--
