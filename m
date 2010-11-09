Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Add jump label support
From: Michael Ellerman <michael@ellerman.id.au>
To: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <1289225915.12418.2.camel@gandalf.stny.rr.com>
References: <45fbc3cd7f6ce404d1e25bf01695fb629d86189d.1289189560.git.michael@ellerman.id.au>
	<1289225915.12418.2.camel@gandalf.stny.rr.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-w3D+0pu8VLtSMSPL4b+4"
Date: Tue, 09 Nov 2010 14:33:00 +1100
Message-ID: <1289273580.21111.193.camel@concordia>
Mime-Version: 1.0
Cc: Kumar Gala <kumar.gala@freescale.com>, linux-kernel@vger.kernel.org, "David
	S.Miller" <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	Anton Blanchard <anton@samba.org>, jbaron@redhat.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-w3D+0pu8VLtSMSPL4b+4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-11-08 at 09:18 -0500, Steven Rostedt wrote:
> On Mon, 2010-11-08 at 15:12 +1100, Michael Ellerman wrote:
> > This patch adds support for the new "jump label" feature.
>=20
> Darn it! I wanted to port this!!!
>=20
> ;-)

Sorry! I've been locked in a dark room for ages and this was a nice
chance to work on some upstream code for a change :)

> > Built for 64 & 32 bit, tested on 64 bit. Survives a kernel build under
> > perf with all tracepoints enabled, and manual inspection of the patched
> > code looks right. But still, lightly tested, YMMV.
> >=20
> > Unlike x86 and sparc we just merrily patch the code with no locks etc,
> > as far as I know this is safe, but I'm not really sure what the x86/spa=
rc
> > code is protecting against so maybe it's not.
>=20
> Thanks, I'll give it a test on my electra as soon as I get a gcc 4.5.1
> cross compiler working.

Thanks.

cheers



--=-w3D+0pu8VLtSMSPL4b+4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkzYwOwACgkQdSjSd0sB4dIvgQCgpN+7/z9m/ALqbxEBCzJjwx0h
Cx8AmgKd1c5SmvuY8GraTVP9KUxAdrMf
=a/t3
-----END PGP SIGNATURE-----

--=-w3D+0pu8VLtSMSPL4b+4--
