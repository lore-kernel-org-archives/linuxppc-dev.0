Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Add jump label support
From: Michael Ellerman <michael@ellerman.id.au>
To: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <1289274119.12418.79.camel@gandalf.stny.rr.com>
References: <45fbc3cd7f6ce404d1e25bf01695fb629d86189d.1289189560.git.michael@ellerman.id.au>
	<20101109133517.b6be28bf.sfr@canb.auug.org.au>
	<1289273608.21111.194.camel@concordia>
	<1289274119.12418.79.camel@gandalf.stny.rr.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-IkgJDMo06ESIiYhjjcHt"
Date: Tue, 09 Nov 2010 15:02:56 +1100
Message-ID: <1289275376.21111.227.camel@concordia>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Kumar Gala <kumar.gala@freescale.com>, jbaron@redhat.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Anton Blanchard <anton@samba.org>, "David S. Miller" <davem@davemloft.net>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-IkgJDMo06ESIiYhjjcHt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-11-08 at 22:41 -0500, Steven Rostedt wrote:
> On Tue, 2010-11-09 at 14:33 +1100, Michael Ellerman wrote:
>=20
> > > You don't need this protection in a file that is not exported to user
> > > space.
> >=20
> > Ah true. I'll respin after I've heard if anyone has tested it :)
>=20
> Don't wait for me. I'm stuck debugging some other crap. Getting a 4.5
> PPC compiler working is very low on my priority list, unfortunately. :-(

No worries, testing is for sissies anyway.

There are 4.5.0 crosses on kernel.org, I think they're the same as the
ones I'm using, which seem to work on powerpc at least.

http://kernel.org/pub/tools/crosstool/files/bin/x86_64/4.5.0/

cheers


--=-IkgJDMo06ESIiYhjjcHt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkzYx/AACgkQdSjSd0sB4dIEkgCeL3KbuRYU2OJi8Jw4QVgootyF
gIQAnA1tyXLKJWYDzCo03E3gYEhZk+rd
=/Dt7
-----END PGP SIGNATURE-----

--=-IkgJDMo06ESIiYhjjcHt--
