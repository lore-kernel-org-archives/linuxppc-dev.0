Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 3/8] pseries: phyp dump: reserve-release proof-of-concept
From: Michael Ellerman <michael@ellerman.id.au>
To: linasvepstas@gmail.com
In-Reply-To: <3ae3aa420801071649w6a8d3939y176dc389d68f4870@mail.gmail.com>
References: <4782C1A8.3050804@austin.ibm.com>
	<200801080126.51897.arnd@arndb.de>
	<3ae3aa420801071649w6a8d3939y176dc389d68f4870@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-OIEinUS2DnDlgGN4/O+n"
Date: Tue, 08 Jan 2008 12:13:57 +1100
Message-Id: <1199754837.7518.71.camel@concordia>
Mime-Version: 1.0
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, lkessler@us.ibm.com,
	strosake@us.ibm.com, Arnd Bergmann <arnd@arndb.de>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-OIEinUS2DnDlgGN4/O+n
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-01-07 at 18:49 -0600, Linas Vepstas wrote:
> On 07/01/2008, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 08 January 2008, Manish Ahuja wrote:
> >
> > > Initial patch for reserving memory in early boot, and freeing it late=
r.
> > > If the previous boot had ended with a crash, the reserved memory woul=
d contain
> > > a copy of the crashed kernel data.
> > >
> > > Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>
> > > Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> >
> > I think the signed-off-by chain needs to be modified. The way it appear=
s,
> > you handled the patch first, then sent it to Linas, who forwarded it
> > to whoever will take the patches from the list.

> > This obviously isn't true, since you are actually the one who is sendin=
g
> > out the patches. Moreover, I believe that the linas@austin.ibm.com
> > address is now dead, and shouldn't be used for this any more.
>=20
> Hmm. I wanted to indicate that the work was done while I was at IBM;
> clearly, no one is going through git and changing old, expired email
> addrs, and so submission based on the old addr seemed appropriate.
>=20
> I'm taking the Signed-off-by line as a quasi-legal thing: a fancy ID stri=
ng,
> identifying the author(s),  rather than a new way to manage email
> address books.

No one's changing the git history (you can't), but it seems silly to
submit a patch with an address that is already dead. There is a general
expectation that if/when someone finds a bug in the code they can email
the signed-off-by addresses and get a real person.

As far as indicating it was written at IBM, that should be covered by
the copyright notices.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-OIEinUS2DnDlgGN4/O+n
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHgs5VdSjSd0sB4dIRAsqEAJ905lNzFFMKscKdq4OeqOkHvjRZ7QCdHvhU
4if0hwJ+ZMcrf39BzLnb9AM=
=QT5w
-----END PGP SIGNATURE-----

--=-OIEinUS2DnDlgGN4/O+n--
