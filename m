Return-Path: <solomon@linux-wlan.com>
Received: from cdptpa-omtalb.mail.rr.com (cdptpa-omtalb.mail.rr.com
	[75.180.132.123])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 035B1B7B5F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 03:54:24 +1000 (EST)
Date: Thu, 20 Aug 2009 13:45:19 -0400
From: Solomon Peachy <solomon@linux-wlan.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] Add support for the ESTeem 195E (PPC405EP) SBC
Message-ID: <20090820174519.GA8860@linux-wlan.com>
References: <1248448916-29473-1-git-send-email-solomon@linux-wlan.com>
	<20090730140630.GD10244@zod.rchland.ibm.com>
	<20090730194506.GA30066@linux-wlan.com>
	<20090730200848.GF10244@zod.rchland.ibm.com>
	<20090817151359.GC8710@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
In-Reply-To: <20090817151359.GC8710@zod.rchland.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2009 at 11:13:59AM -0400, Josh Boyer wrote:
> >There is another way.  Perhaps you could just copy ppcboot.h to a new fi=
le
> >called "hotfoot.h" and just use that.  It's a duplication of ppcboot.h to
> >some degree, but it seems to make sense for your board and it helps pres=
erve
> >the "stock" ppcboot.h for other boards.
>=20
> Solomon, any update on this?  As far as I'm concerned, the ppcboot.h issu=
e is
> the only thing that really needs to be reworked before we bring this patch
> in.

Should I call the new version 'hotfoot.h' or 'ppcboot-hotfoot.h'?=20

 - Solomon
--=20
Solomon Peachy                        solomon@linux-wlan.com
AbsoluteValue Systems                 http://www.linux-wlan.com
721-D North Drive                     +1 (321) 259-0737  (office)
Melbourne, FL 32934                   +1 (321) 259-0286  (fax)

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFKjYuvhinxHf95MjYRAmATAKCCpERvzee/E7EOCMszyvkIRZr4vACfS7Z1
WFJDz33xh9atqLc8KF/uhRg=
=pKoO
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
