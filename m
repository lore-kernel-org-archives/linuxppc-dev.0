Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id DD8B0DDF5D
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 22:04:43 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: "Leon Woestenberg" <leon.woestenberg@gmail.com>
Subject: Re: Floating inputs on unused GPIO pins
Date: Mon, 13 Oct 2008 13:04:41 +0200
References: <200810131156.59477.laurentp@cse-semaphore.com>
	<c384c5ea0810130308q5cfa2c2ld8ea5eafec99bba3@mail.gmail.com>
In-Reply-To: <c384c5ea0810130308q5cfa2c2ld8ea5eafec99bba3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1296436.mzcYet2qAg";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200810131304.41435.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1296436.mzcYet2qAg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Leon,

On Monday 13 October 2008, Leon Woestenberg wrote:
> Hello Laurent,
>=20
> On Mon, Oct 13, 2008 at 11:56 AM, Laurent Pinchart
> <laurentp@cse-semaphore.com> wrote:
> > our hardware engineer asked me to make sure all unused GPIO pins are
> > configured as outputs to avoid floating inputs. He got theory on his si=
de
> > (floating inputs can lead to higher current consumption, metastability =
or
> > even permanent damage), but I'd like to ask the list for practical
> > feedback.   =20
> >
> Ideally, configure them as inputs or tri-state (both mean high
> impedance), and do use pull-down or -up resistors.

As I explained in my mail to Geert, that's not really an option. The GPIO p=
ins are connected to an optional expansion module. When the module is plugg=
ed in the pins have dedicated functions. When the module is not present the=
y are by default floating inputs. That's the case our hardware engineer is =
concerned about.

> Now, the answer might be different when your pins are not connected.
> Check on the processor if internal pull resistors are present. If so,
> use as input. If not, then your h/w engineer *may* have a point, not
> sure on that though.

There are no internal pull-up or pull-down resistors on the MPC8248 GPIO pi=
ns. I know our hardware engineer has a valid point theoretically. Does the =
point stand practically, or does the MPC8248 "state-of-the-art"(tm)(c)(what=
ever) technology make floating inputs safe ?

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1296436.mzcYet2qAg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjzK0kACgkQ8y9gWxC9vpeNgQCg3rWmoJjnooykfi8m8aZSRqig
FpoAoLGzVClm6F8lesGvwKaeszolEHC1
=fP1L
-----END PGP SIGNATURE-----

--nextPart1296436.mzcYet2qAg--
