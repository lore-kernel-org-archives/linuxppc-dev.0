Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 52FF6B7BCA
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Oct 2009 21:13:12 +1000 (EST)
Date: Thu, 1 Oct 2009 21:13:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] perf_event, powerpc: Fix compilation after big
	perf_counter rename
Message-Id: <20091001211302.601f2837.sfr@canb.auug.org.au>
In-Reply-To: <20091001074201.GA6300@elte.hu>
References: <19128.4280.813369.589704@cargo.ozlabs.ibm.com>
	<1253584591.7103.197.camel@pasglop>
	<20090922072834.GA25470@elte.hu>
	<1253606415.7103.216.camel@pasglop>
	<1253620332.10476.4.camel@concordia>
	<20090923124420.GA5525@elte.hu> <1253747995.6110.5.camel@concordia>
	<20090924121423.GB12262@elte.hu>
	<1253798755.16237.4.camel@concordia>
	<20090925095841.8578073a.sfr@canb.auug.org.au>
	<20091001074201.GA6300@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__1_Oct_2009_21_13_02_+1000_Tc3=iddc8h0I6l07"
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__1_Oct_2009_21_13_02_+1000_Tc3=iddc8h0I6l07
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ingo,

On Thu, 1 Oct 2009 09:42:01 +0200 Ingo Molnar <mingo@elte.hu> wrote:
>
> * Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>=20
> > On Thu, 24 Sep 2009 23:25:55 +1000 Michael Ellerman <michael@ellerman.i=
d.au> wrote:
> > >
> > > Give me a day or two, I should be able to add a per-branch setting for
> > > who to send mails to without too much trouble.
> >=20
> > In the mean time I don't now if someone has pointed you at these today:
> >=20
> > http://kisskb.ellerman.id.au/kisskb/branch/12/
>=20
> That's an upstream warning.

When I sent that to you, I was referring to these build results:

http://kisskb.ellerman.id.au/kisskb/buildresult/1307802/

which (as you say) was only a waning in the rest of the kernel but is
turned into an error by the -Werror we use when building arch/powerpc.
The warning came from commit 4765c1db84c73f775eb1822a009117cbae524e9e
("rcu-tiny: The Bloatwatch Edition, v6") in the -tip tree and fixed by
commit 5ef9b8e59c043624fb44e31439cecf7f8b4cd62a ("rcu: Clean up the
warning message about RCU not defined") the next day (in the -tip tree).
So no big problem.  Neither of these commits are upstream.

I was just filling in the role of notifying you of build problems until
Michael can automate it.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__1_Oct_2009_21_13_02_+1000_Tc3=iddc8h0I6l07
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkrEjr4ACgkQjjKRsyhoI8yrlACeOP3p43pl1NTk/I/1QmehQpnQ
FmkAnRIrTU46n6YEjCk10Qe1AAhbphtt
=MLFF
-----END PGP SIGNATURE-----

--Signature=_Thu__1_Oct_2009_21_13_02_+1000_Tc3=iddc8h0I6l07--
