Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3E49BB7CF5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Feb 2010 19:54:56 +1100 (EST)
Date: Fri, 19 Feb 2010 09:54:50 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Ryan <rayan@nucleodyne.com>
Subject: Re: State of PREEMPT_RT in PPC arch
Message-ID: <20100219085450.GA10674@pengutronix.de>
References: <5bbdacc81002172233x64a05ae2m4ecdbddf85dac8c0@mail.gmail.com>
	<20100218131541.GB18514@pengutronix.de>
	<5bbdacc81002182134l64c46bf1mc2a4b4fc268e6eee@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
In-Reply-To: <5bbdacc81002182134l64c46bf1mc2a4b4fc268e6eee@mail.gmail.com>
Cc: ppcdev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 18, 2010 at 09:34:28PM -0800, Ryan wrote:
> On Thu, Feb 18, 2010 at 5:15 AM, Wolfram Sang <w.sang@pengutronix.de> wro=
te:
> >
> > > I'm soliciting comments from the community. Thanks in advance for
> > > sharing your thoughts.
> >
> > Mainline your driver and you are free from such problems :)
>=20
> Shouldn't it be the opposite way? That is, get drivers working first
> then mainline them? I even don't have a working driver with RT patch.

If you have problems getting your driver to mainline, the lists are there to
help. Of course, this implies working with a recent kernel (which also answ=
ers
your initial question a bit). Most people don't want to supprt old kernels =
like
2.6.2x in their freetime. You can get commercial support for such tasks (be=
 it
my employer or other consultants on this list).

> and discussions about them, kinda dedicated to active developers. Is
> there a place that users or not-so-active developers can post
> technical questions and get some relatively quick answers or comments?

The list was apropriate. As all people are busy by default, getting no resp=
onse
is not that exceptional. If you need a fast response, you should consider
commercial support.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkt+UdoACgkQD27XaX1/VRtEwQCgtBJtltOS6KGUwmFVQcWdJsiW
UOgAn1asO9vl7HqYl21pesbNP+SBkHDe
=gmty
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
