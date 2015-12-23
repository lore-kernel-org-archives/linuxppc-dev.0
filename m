Return-Path: <boqun.feng@gmail.com>
Received: from mail-io0-x22a.google.com (mail-io0-x22a.google.com
 [IPv6:2607:f8b0:4001:c06::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 355651A09ED
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2015 14:34:09 +1100 (AEDT)
Received: by mail-io0-x22a.google.com with SMTP id o67so205105884iof.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Dec 2015 19:34:09 -0800 (PST)
Date: Wed, 23 Dec 2015 11:33:34 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH powerpc/next v6 0/4] atomics: powerpc: Implement
 relaxed/acquire/release variants
Message-ID: <20151223033334.GA28539@fixme-laptop.cn.ibm.com>
References: <1450189457-10589-1-git-send-email-boqun.feng@gmail.com>
 <1450838405.5036.6.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
In-Reply-To: <1450838405.5036.6.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 23, 2015 at 01:40:05PM +1100, Michael Ellerman wrote:
> On Tue, 2015-12-15 at 22:24 +0800, Boqun Feng wrote:
>=20
> > Hi all,
> >=20
> > This is v6 of the series.
> >=20
> > Link for v1: https://lkml.org/lkml/2015/8/27/798
> > Link for v2: https://lkml.org/lkml/2015/9/16/527
> > Link for v3: https://lkml.org/lkml/2015/10/12/368
> > Link for v4: https://lkml.org/lkml/2015/10/14/670
> > Link for v5: https://lkml.org/lkml/2015/10/26/141
> >=20
> >=20
> > Changes since v5:
> >=20
> > *	rebase on the next branch of powerpc.
> >=20
> > *	pull two fix and one testcase patches out, which are already
> > 	sent separately
> >=20
> > *	some clean up or code format fixing.
> >=20
> >=20
> > Paul, Peter and Will, thank you for your comments and suggestions in th=
e review
> > of previous versions. From this version on, This series is against the =
next
> > branch of powerpc tree, because most of the code touch arch/powerpc/*.
>=20
>=20
> Sorry if we already discussed this, but did we decide how we were going to
> merge this? There's the one patch to generic code and then three powerpc
> patches.
>=20

We might have "discussed" this ;-) As I proposed this would go to the
powerpc next in this mail:

http://marc.info/?l=3Dlinux-kernel&m=3D144660021417639&w=3D2

Regards,
Boqun

> It'd make most sense for it to go via powerpc I think. Given that the cha=
nge to
> generic code is relatively trivial I'll plan to merge this unless someone
> objects.
>=20
> Also it is pretty late in the -next cycle for something like this. But AF=
AICS
> there are no users of these "atomic*relaxed" variants yet other than arm6=
4 code
> and qspinlocks, neither of which are used on powerpc. So adding them shou=
ld be
> pretty harmless.
>=20
> cheers
>=20

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWehYLAAoJEEl56MO1B/q43s8H/iOVE7AOoaZYgy5cke8Tc2DL
tuvP6V+yNcGmqH9zjnF4VUgvZarZdccPXKhaeCJo5DtsCZjOAaecx9lt4/BexiLl
QQfQBRikG53R4kS7jrSKv7SxQ1siS3DWgGzOMNE6NvSKrlJN61d1PI/pVVvdLvtT
lBl7DDoXWqX8uargzZxhUlm33VvsreYPZxc1QnZzCeDIRwjjRa1i72oCDbYijWG7
dzdc3C2yhZP3x2w/YAODLAtYq5Bg6d+Hcu/pDijSRlsI6upj3O22N6sa+RxK3OBc
PvGmXYtPg1KvFWh9l+byXUaJO1GKEK2N6EIqS68k2vOcTJ475nbSV8Z3xZPRipY=
=RMYg
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
