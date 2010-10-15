Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC PATCH] ppc: don't override CONFIG_PPC_PSERIES_DEBUG
From: Michael Ellerman <michael@ellerman.id.au>
To: Nishanth Aravamudan <nacc@us.ibm.com>
In-Reply-To: <1287078495-11722-1-git-send-email-nacc@us.ibm.com>
References: <1287078495-11722-1-git-send-email-nacc@us.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-c9/6FOcWQNQAeEXitdHD"
Date: Fri, 15 Oct 2010 11:14:23 +1100
Message-ID: <1287101663.4194.5.camel@concordia>
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, Frans Pop <elendil@planet.nl>,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, Linas Vepstas <linasvepstas@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-c9/6FOcWQNQAeEXitdHD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-10-14 at 10:48 -0700, Nishanth Aravamudan wrote:
> These files undef DEBUG, but I think they were added before the ability
> to control this from Kconfig.=20

Perhaps. Some people, *cough*, have a tendency to merge those back in
again from time to time :)

> It's really annoying to only get some of the debug messages!

True, but ..

> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
>=20
> ---
> Because the lpar and pci_dlpar code is pretty low-level & verbose,
> perhaps it makes sense to add another Kconfig variable for really
> low-level stuff? But it's annoying to have DEBUG *somewhat* effective,
> especially in the EEH area when doing PCI stuff.

I really don't think you want to enable the lpar debug by default. Have
you tried it? It can make for a pretty unusable system, just because of
the console spam.

Also these days there is CONFIG_DYNAMIC_DEBUG which is much smarter than
all this, but requires setup at runtime.

cheers


--=-c9/6FOcWQNQAeEXitdHD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAky3nNwACgkQdSjSd0sB4dLpcgCgyIHkaqdl+HA3iyvu+1EQ7qkk
bNwAn3gAE1UJk1EmtgirjzaDTcUNJkRt
=mpvj
-----END PGP SIGNATURE-----

--=-c9/6FOcWQNQAeEXitdHD--
