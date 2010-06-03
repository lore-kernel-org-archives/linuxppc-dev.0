Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Emulate most Book I instructions in
	emulate_step()
From: Michael Ellerman <michael@ellerman.id.au>
To: Matt Evans <matt@ozlabs.org>
In-Reply-To: <4C0700FD.6060303@ozlabs.org>
References: <20100602112903.GB30149@brick.ozlabs.ibm.com>
	<09904F7B-6319-45FA-ADC4-757A2AD239AB@kernel.crashing.org>
	<20100603004758.GA19618@brick.ozlabs.ibm.com>
	<4C0700FD.6060303@ozlabs.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-8eW06mBHzlFqplAjs9ye"
Date: Thu, 03 Jun 2010 11:43:55 +1000
Message-ID: <1275529435.22020.1.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	"K.Prasad" <prasad@linux.vnet.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-8eW06mBHzlFqplAjs9ye
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-06-03 at 11:10 +1000, Matt Evans wrote:
> Paul Mackerras wrote:
> > [snip]
> > The second alternative -- emulating the lwarx/stwcx and all the
> > instructions in between -- sounds complicated but turns out to be
> > pretty straightforward in fact, since the code for each instruction is
> > pretty small, easy to verify that it's correct, and has little
> > interaction with other code.
>=20
> Easy to verify -- visually or logically?
>=20
> Having had a little experience with interpreters 'invisibly' operating
> behind the scenes I am all for very rigorous testing of these things.
> I have lost at least four of my nine lives to incorrect flag values,
> odd data problems and hideous heisenbugs etc. of such interpreters.
> Looked at another way, you'd be surprised how much one can break in an
> interpreter and still successfully run various programs.
>=20
> Presumably your first pass is completely correct already, but I'm
> thinking that if any future changes are made to it=20
> it would be good to include test code/modes alongside the interpreter
> so others can check alterations.  E.g. include the "run user program
> interpreted" test switch patch, or even better compare the interpreted
> state to real hardware execution.  There are other more directed test
> strategies (e.g. handwritten tests, random code) but these would be a
> good start.

Emphatic nod. We all trust Paulus to get this right, but I for one would
not be game to touch it without a test suite.

It's ripe territory for a boot time selftest IMHO.

cheers

--=-8eW06mBHzlFqplAjs9ye
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkwHCNUACgkQdSjSd0sB4dL7pQCdE+5ptHAiKIInqnFCs54to/hx
JogAnjUZUWNvHE1sN9AEk3MuKFyaUkMg
=X7p1
-----END PGP SIGNATURE-----

--=-8eW06mBHzlFqplAjs9ye--
