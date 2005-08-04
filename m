Return-Path: <michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc64-dev@ozlabs.org
Date: Thu, 4 Aug 2005 10:17:50 +1000
References: <1123064479.417492.649639846705.qpatch@concordia>
	<1123095705.8638.14.camel@cashmere.sps.mot.com>
In-Reply-To: <1123095705.8638.14.camel@cashmere.sps.mot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2765443.OdJ5MfRWk2";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200508041017.54208.michael@ellerman.id.au>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 0/10] Cleanup iSeries msChunks handling, and lmb code.
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2765443.OdJ5MfRWk2
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thu, 4 Aug 2005 05:01, Jon Loeliger wrote:
> On Wed, 2005-08-03 at 05:21, Michael Ellerman wrote:
> > This series of patches cleans up the iSeries msChunks structure, and
> > associated macros and functions.
> >
> > It also removes CONFIG_MSCHUNKS from the lmb code, and eventually remov=
es
> > CONFIG_MSCHUNKS entirely.
> >
> > The final patch rely's on Stephen's FW_FEATURE_ISERIES patches.
> >
> > Booted on Power3, G5, Power5 LPAR and iSeries.
>
> Excellent.  This patch, especially the LMB simplification
> and removal of the physbase bits, greatly simplifies the
> notion of merging LMB form 64 land and the mem_pieces.

Cool. I wasn't really thinking of 32 <-> 64 merging when I did the patches,=
=20
but it's good to be heading in the right direction.

> I have previously submitted patches against the ppc32 code
> that enhance the mem_pieces towards the LMB structure as well.
>
> Given an eventual merger of the two bodies of code, I'd
> like to make the merger of these two structures more complete.
> I'll work towards that goal if that's a Good Idea.

I don't know the ppc32 code (guess I'll need to soon), so I can't comment o=
n=20
specifics, but it sounds like a "Good Idea" to me.

cheers

=2D-=20
Michael Ellerman
IBM OzLabs

email: michael:ellerman.id.au
inmsg: mpe:jabber.org
wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--nextPart2765443.OdJ5MfRWk2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC8V6ydSjSd0sB4dIRApNMAJ9HVtaaMFaZyPLg93rBB0TTwMAkugCfSDmQ
E0zBTx2HEJDhYhU1Rg9tmMc=
=CIJ9
-----END PGP SIGNATURE-----

--nextPart2765443.OdJ5MfRWk2--
