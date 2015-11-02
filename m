Return-Path: <boqun.feng@gmail.com>
Received: from mail-ob0-x22d.google.com (mail-ob0-x22d.google.com
 [IPv6:2607:f8b0:4003:c01::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 009791A0401
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2015 12:23:10 +1100 (AEDT)
Received: by obctp1 with SMTP id tp1so83089151obc.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2015 17:23:07 -0800 (PST)
Date: Mon, 2 Nov 2015 09:22:41 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Waiman Long <waiman.long@hp.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Peter Zijlstra <peterz@infradead.org>,
 Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>
Subject: Re: [RESEND, tip/locking/core, v5, 1/6] powerpc: atomic: Make
 _return atomics and *{cmp}xchg fully ordered
Message-ID: <20151102012033.GA965@fixme-laptop.cn.ibm.com>
References: <1445854536-22645-1-git-send-email-boqun.feng@gmail.com>
 <20151027023347.6178D140E31@ozlabs.org>
 <20151027030652.GB26372@fixme-laptop.cn.ibm.com>
 <20151030005633.GA2792@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
In-Reply-To: <20151030005633.GA2792@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2015 at 08:56:33AM +0800, Boqun Feng wrote:
> On Tue, Oct 27, 2015 at 11:06:52AM +0800, Boqun Feng wrote:
> > On Tue, Oct 27, 2015 at 01:33:47PM +1100, Michael Ellerman wrote:
> > > On Mon, 2015-26-10 at 10:15:36 UTC, Boqun Feng wrote:
> > > > This patch fixes two problems to make value-returning atomics and
> > > > {cmp}xchg fully ordered on PPC.
> > >=20
> > > Hi Boqun,
> > >=20
> > > Can you please split this into two patches. One that does the cmpxchg=
 change
> > > and one that changes PPC_ATOMIC_ENTRY_BARRIER.
> > >=20
> >=20
> > OK, make sense ;-)
> >=20
> > > Also given how pervasive this change is I'd like to take it via the p=
owerpc
> > > next tree, so can you please send this patch (which will be two after=
 you split
> > > it) as powerpc patches. And the rest can go via tip?
> > >=20
> >=20
> > One problem is that patch 5 will remove __xchg_u32 and __xchg_64
> > entirely, which are modified in this patch(patch 1), so there will be
> > some conflicts if two branch get merged, I think.
> >=20
> > Alternative way is that all this series go to powerpc next tree as most
> > of the dependent patches are already there. I just need to remove
> > inc/dec related code and resend them when appropriate. Besides, I can
> > pull patch 2 out and send it as a tip patch because it's general code
> > and no one depends on this in this series.
> >=20
> > To summerize:
> >=20
> > patch 1(split to two), 3, 4(remove inc/dec implementation), 5, 6 sent as
> > powerpc patches for powerpc next, patch 2(unmodified) sent as tip patch
> > for locking/core.
> >=20
> > Peter and Michael, this works for you both?
> >=20
>=20
> Thoughts? ;-)
>=20

Peter and Michael, I will split patch 1 to two and send them as patches
for powerpc next first. The rest of this can wait util we are on the
same page of where they'd better go.

Regards,
Boqun

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWNrrdAAoJEEl56MO1B/q44Y0H/jfulTN4uqaus0czsLZhP1K1
04eg1Am+HLXyox4zq7cG3Up3jmhQwD6p7TgP2/M1XaJDamnG3BbYz0Lh3nNaaH/r
Q9WKUHU3OWMHsaGQHhrZA99Jm9h1HOZ9yaWa+EdWLApIyBp9+Lg5eQo06JZytAxV
5cxuK2b+Z8aArRev6wv6gGqrkNf/JTGx5jA7O5Iml5r6zhpKHdVmHAO/0DBzYjTT
Cg2kgyWwpjDQR2Au3Ju9Xgx52yo/CC9e1Qtwa6j3vaWyan0k0QpOiyv0cLf49kTK
xf8+hTLQkbSaflX4FU9kQUi6EOML33fz/76z2I/dx8JcujjpFb/Fe18YoTqC/AM=
=Ab9s
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
