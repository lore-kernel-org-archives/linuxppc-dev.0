Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH] powerpc: Use rtas query-cpu-stopped-state in smp
	spinup
From: Michael Ellerman <michael@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20060404124248.GA26436@krispykreme>
References: <20060404112459.C9170679EB@ozlabs.org>
	<20060404124248.GA26436@krispykreme>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-E31hYS3/gDQcTxPZetTP"
Date: Tue, 04 Apr 2006 14:46:04 +0200
Message-Id: <1144154764.7679.1.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-E31hYS3/gDQcTxPZetTP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-04-04 at 22:42 +1000, Anton Blanchard wrote:
> Hi,
>=20
> > Currently we use a cpumask called of_spin_map to keep track of which th=
reads
> > have been spun up. We basically guess that OF has spun up all even numb=
ered
> > threads, and so all the odd numbered threads need to be brought up.
> >=20
> > That's a bit of a dicey assumption at best, and is totally incorrect fo=
r
> > kexec. Luckily we have an rtas call which can tell us whether a cpu is =
up
> > or not, so let's use it?
>=20
> I have a bad feeling its broken on some older (POWER3) machines.

Ok, we'll have to see _how_ it's broken. But if it falsely reports that
the thread is started that will suck. I haven't been able to test on my
Power3 because of another breakage *cough benh cough*. I'll try it
sometime.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-E31hYS3/gDQcTxPZetTP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEMmqMdSjSd0sB4dIRAu+kAKC3BjuJNDkhuOFKHI2imdiUBYrypQCgmcuF
u/3Z8JD+JBZXlsG74JxiuTk=
=0Gnk
-----END PGP SIGNATURE-----

--=-E31hYS3/gDQcTxPZetTP--
