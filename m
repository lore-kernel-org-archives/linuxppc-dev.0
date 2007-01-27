Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
From: Michael Ellerman <michael@ellerman.id.au>
To: linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <1169714047.65693.647693675533.qpush@cradle>
References: <1169714047.65693.647693675533.qpush@cradle>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-HTuchxJcH6soTNs88NrL"
Date: Sat, 27 Jan 2007 15:59:59 +1100
Message-Id: <1169873999.2294.8.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, "David S.Miller" <davem@davemloft.net>,
	"Eric W.Biederman" <ebiederm@xmission.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-HTuchxJcH6soTNs88NrL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-01-25 at 19:34 +1100, Michael Ellerman wrote:
> OK, here's a first cut at moving ops based MSI into the generic code. I'm
> posting this now to make sure I'm not heading off into the weeds.

Perhaps I wasn't clear enough here, by "first cut" I mean "work in
progress", "not finished yet", "preliminary", "doesn't work yet" .. etc.
It even says "RFC" in the subject line!

:)

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-HTuchxJcH6soTNs88NrL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFutxOdSjSd0sB4dIRAtoAAJ0Q8DHvvewzCKN5qzG/+uRfCFew1gCgqkBs
wAaCAQb/lUoh2bfTdrs597E=
=pSjt
-----END PGP SIGNATURE-----

--=-HTuchxJcH6soTNs88NrL--
