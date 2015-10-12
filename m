Return-Path: <boqun.feng@gmail.com>
Received: from mail-ob0-x233.google.com (mail-ob0-x233.google.com
 [IPv6:2607:f8b0:4003:c01::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 78B391A025F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 20:38:23 +1100 (AEDT)
Received: by obbrx8 with SMTP id rx8so1936428obb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 02:38:21 -0700 (PDT)
Date: Mon, 12 Oct 2015 17:38:00 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC v2 1/7] atomics: Add test for atomic operations with
 _relaxed variants
Message-ID: <20151012093800.GG27351@fixme-laptop.cn.ibm.com>
References: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
 <1442418575-12297-2-git-send-email-boqun.feng@gmail.com>
 <20151012093033.GC16124@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3oCie2+XPXTnK5a5"
In-Reply-To: <20151012093033.GC16124@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--3oCie2+XPXTnK5a5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2015 at 10:30:34AM +0100, Will Deacon wrote:
> On Wed, Sep 16, 2015 at 04:49:29PM +0100, Boqun Feng wrote:
> > Some atomic operations now have _{relaxed, acquire, release} variants,
> > this patch then adds some trivial tests for two purpose:
> >=20
> > 1.	test the behavior of these new operations in single-CPU
> > 	environment.
> > 2.	make their code generated before we actually use them somewhere,
> > 	so that we can examine their assembly code.
> >=20
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  lib/atomic64_test.c | 91 ++++++++++++++++++++++++++++++++++-----------=
--------
> >  1 file changed, 59 insertions(+), 32 deletions(-)
>=20
> FWIW: this was useful to me whilst developing the arm64 relaxed atomic

Glad to know.

> implementation. Could you extend it to include the recently queued inc/dec
> variants too?
>=20

Already include them in upcoming V3 ;-)

Regards,
Boqun

--3oCie2+XPXTnK5a5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWG39zAAoJEEl56MO1B/q4yL0H/jhtDQMC15kqQkhe4d5icmty
GTTo6+l8iaCMUZEULyO03+szZMxhcXALiCt6cJ6x7kaRGvNJGQe0hmgfEQh7HCb7
gTVJferVf9Q2sNFWt0vucmbXffHUx2FedODRmRB1LLlOpsGs4WDlUdN69jk6Es5I
ZxhiylYTVU0sL5l4FjbEHydwsno7m2lhEjKrVblp39pg5p5kk6e1Gn5N0uHP2sY/
BodO6ZDnX8Tz27YBdDO0hmZY36AyOWf7lGATgUdbJKPX9RWb4U/54/2iPQ0fAvP9
KQg4kyY00m7XA5Xxi3w/P2a1UPerkLZXHiZNrScRLrjRvNgU3K+7zsR+d3cSqiQ=
=pn10
-----END PGP SIGNATURE-----

--3oCie2+XPXTnK5a5--
