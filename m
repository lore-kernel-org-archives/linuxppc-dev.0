Return-Path: <Paul.Hampson@Pobox.com>
Received: from mail.cbit.net.au (betty.cbit.net.au [202.55.154.10])
	by ozlabs.org (Postfix) with ESMTP id 8D15CDDDCA
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 18:20:16 +1100 (EST)
Date: Fri, 16 Mar 2007 18:20:10 +1100
From: Paul TBBle Hampson <Paul.Hampson@Pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Make sure we populate the initroot filesystem late enough
Message-ID: <20070316072010.GB30892@keitarou>
References: <1172448057.3971.9.camel@shinybook.infradead.org>
	<1172518068.15970.6.camel@localhost>
	<20070226222724.GA13182@keitarou>
	<1172558897.11949.43.camel@localhost.localdomain>
	<3ac1a55a11baddefb903f24b988566fe@kernel.crashing.org>
	<1172644987.11949.90.camel@localhost.localdomain>
	<1172657584.3452.51.camel@pmac.infradead.org>
	<1172709056.5852.6.camel@concordia.ozlabs.ibm.com>
	<20070312230137.GA8304@keitarou>
	<1173769429.24454.61.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
In-Reply-To: <1173769429.24454.61.camel@localhost.localdomain>
Cc: john stultz <johnstul@us.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2007 at 08:03:49AM +0100, Benjamin Herrenschmidt wrote:

>> Hmm. The crash came back after I booted into Mac OS X and back. It was h=
owever
>> a different crash, I believe it was coming from the USB modules (as it w=
ould
>> keep going when it happened, and get another crash, which tended to scro=
ll away
>> too fast for me to capture) but I believe it was still getting down into=
 the
>> slab code and actually dying there.

> Have you tried, instead, to apply
> 38f3323037de22bb0089d08be27be01196e7148b ? (That is revert
> 39d61db0edb34d60b83c5e0d62d0e906578cc707).

That's working fine at the moment, and has even survived a trip to Mac
OS X and back.

Thankyou.

--=20
-----------------------------------------------------------
Paul "TBBle" Hampson, B.Sc, LPI, MCSE
On-hiatus Asian Studies student, ANU
The Boss, Bubblesworth Pty Ltd (ABN: 51 095 284 361)
Paul.Hampson@Pobox.Com

Of course Pacman didn't influence us as kids. If it did,
we'd be running around in darkened rooms, popping pills and
listening to repetitive music.
 -- Kristian Wilson, Nintendo, Inc, 1989

License: http://creativecommons.org/licenses/by/2.1/au/
-----------------------------------------------------------

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF+kUqexDuohKLFuARAkOhAJ96GHCCINsGMm2uNjnHnYevyj9sOQCfaX0A
4v0y+0rBJ4ipO5PqzR3LOqI=
=Wn4+
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
