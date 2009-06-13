Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by bilbo.ozlabs.org (Postfix) with ESMTP id A5A03B71BC
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 13 Jun 2009 14:55:00 +1000 (EST)
Date: Sat, 13 Jun 2009 14:54:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: linux-next: origin tree build failure
Message-Id: <20090613145451.07430ad0.sfr@canb.auug.org.au>
In-Reply-To: <20090612134428.GC32105@elte.hu>
References: <20090612102427.32582baa.sfr@canb.auug.org.au>
	<1244768406.7172.1.camel@pasglop> <20090612092054.GB32052@elte.hu>
	<1244799197.7172.106.camel@pasglop>
	<20090612125335.GH31845@elte.hu>
	<1244812224.7172.146.camel@pasglop>
	<20090612134428.GC32105@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__13_Jun_2009_14_54_51_+1000_/1X8baDtHHiWIYw."
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	paulus@samba.org, Linus <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Sat__13_Jun_2009_14_54_51_+1000_/1X8baDtHHiWIYw.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ingo,

On Fri, 12 Jun 2009 15:44:28 +0200 Ingo Molnar <mingo@elte.hu> wrote:
>
> In terms of test coverage, at least for our trees, less than 1% of=20
> the bugs we handle get reported in a linux-next context - and most=20
> of the bugs that get reported (against say the scheduler tree) are=20
> related to rare architectures.

I expect that most bugs get reported and fixed before code gets to
linux-next (in fact one of the prerequisites for being in linux-next is
that code has been tested as well as possible).

> In fact, i checked, there were _zero_ x86 bugs reported against=20
> linux-next and solved against it between v2.6.30-rc1 and v2.6.30:
>=20
>    git log --grep=3Dnext -i v2.6.30-rc1..v2.6.30 arch/x86/
>=20
> Doing it over the full cycle shows one commit altogether - a Xen=20
> build failure. In fact, i just checked the whole stabilization cycle=20
> for the whole kernel (v2.6.30-rc1..v2.6.30-final), and there were=20
> only 5 linux-next originated patches, most of them build failures.

Nice set of figures.  For some other context, between April 6 and June 9
(2.6.30-rc1 to 2.6.30) I sent 50 emails with subjects like "linux-next:
xxx tree build failure".  What results from those emails?  I sometimes
don't even hear back.  Almost all of the failures get fixed.

A lot of these probably also get discovered independently.  I don't
really care as long as they do get fixed.

One of those failures was a sparc build failure due to a change in the
tip-core tree (see commit d2de688891909b148efe83a6fc9520a9cd6015f0).
Another report produced commit 27b19565fe4ca5b0e9d2ae98ce4b81ca728bf445.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__13_Jun_2009_14_54_51_+1000_/1X8baDtHHiWIYw.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkozMRsACgkQjjKRsyhoI8y8tgCcC8NfR2wXQvpqMnNHFnboqJbr
U/4AnRggiQ30EYELKxNIvJWRXfKSGVnO
=VQly
-----END PGP SIGNATURE-----

--Signature=_Sat__13_Jun_2009_14_54_51_+1000_/1X8baDtHHiWIYw.--
