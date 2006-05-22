Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH][resend] udbg_printf() formatting attribute
From: Michael Ellerman <michael@ellerman.id.au>
To: Jimi Xenidis <jimix@watson.ibm.com>
In-Reply-To: <68EF7C38-A8DB-445A-BC7F-439102E19BB9@watson.ibm.com>
References: <E1FgORv-0001dS-Hu@heater.watson.ibm.com>
	<1147908963.7360.1.camel@localhost.localdomain>
	<34FAC3E5-F717-4640-B094-312C8773852E@watson.ibm.com>
	<1147967806.8469.10.camel@localhost.localdomain>
	<68EF7C38-A8DB-445A-BC7F-439102E19BB9@watson.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-31xXs3L+Wdgscunkh0iq"
Date: Mon, 22 May 2006 16:33:39 +1000
Message-Id: <1148279619.24345.22.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-31xXs3L+Wdgscunkh0iq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-05-18 at 12:52 -0400, Jimi Xenidis wrote:
> On May 18, 2006, at 11:56 AM, Michael Ellerman wrote:
> >
> > I'm actually hoping to get rid of udbg_printf(), but if I can't we
> > should stick this in I guess. The real problem IMHO is that debug
> > printks rot because they're rarely compiled, not sure what to do about
> > that.
>=20
> Yeah, debug code always has that problem.  But I must say, whenever I =20
> work with the x86 guys and I see how long they are _blind_ when they =20
> boot it blows my mind.  Lets hope we don't go there.

Yeah nuts. Don't worry, when I say "get rid of udbg_printf()" I mean
"replace with printk".

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-31xXs3L+Wdgscunkh0iq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEcVtDdSjSd0sB4dIRAuEBAKDB5mw+pqWnVfudq4GuhViVcSiH1QCfUqoo
GDqugYc3pj9qB0VTjogLPis=
=x+Lf
-----END PGP SIGNATURE-----

--=-31xXs3L+Wdgscunkh0iq--
