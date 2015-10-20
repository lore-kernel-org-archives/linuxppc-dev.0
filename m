Return-Path: <boqun.feng@gmail.com>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CACAE1A05D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 01:21:10 +1100 (AEDT)
Received: by pabrc13 with SMTP id rc13so23033583pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2015 07:21:08 -0700 (PDT)
Date: Tue, 20 Oct 2015 22:20:40 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Message-ID: <20151020142040.GD17714@fixme-laptop.cn.ibm.com>
References: <20151007132317.GK16065@arm.com>
 <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
 <20151008111638.GL3816@twins.programming.kicks-ass.net>
 <20151008125937.GH16807@arm.com>
 <20151008221716.GF3910@linux.vnet.ibm.com>
 <20151009095129.GF26278@arm.com>
 <20151009174327.GV3910@linux.vnet.ibm.com>
 <20151009183328.GV26278@arm.com>
 <20151012233048.GK3910@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
In-Reply-To: <20151012233048.GK3910@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2015 at 04:30:48PM -0700, Paul E. McKenney wrote:
> On Fri, Oct 09, 2015 at 07:33:28PM +0100, Will Deacon wrote:
> > On Fri, Oct 09, 2015 at 10:43:27AM -0700, Paul E. McKenney wrote:
> > > On Fri, Oct 09, 2015 at 10:51:29AM +0100, Will Deacon wrote:
[snip]
>=20
> > > > We could also include a link to the ppcmem/herd web frontends and y=
our
> > > > lwn.net article. (ppcmem is already linked, but it's not obvious th=
at
> > > > you can run litmus tests in your browser).
> > >=20
> > > I bet that the URLs for the web frontends are not stable long term.
> > > Don't get me wrong, PPCMEM/ARMMEM has been there for me for a goodly
> > > number of years, but professors do occasionally move from one institu=
tion
> > > to another.  For but one example, Susmit Sarkar is now at University
> > > of St. Andrews rather than at Cambridge.
> > >=20
> > > So to make this work, we probably need to be thinking in terms of
> > > asking the researchers for permission to include their ocaml code in =
the
> > > Linux-kernel source tree.  I would be strongly in favor of this, actu=
ally.
> > >=20
> > > Thoughts?
> >=20
> > I'm extremely hesitant to import a bunch of dubiously licensed, academic
> > ocaml code into the kernel. Even if we did, who would maintain it?
> >=20
> > A better solution might be to host a mirror of the code on kernel.org,
> > along with a web front-end for people to play with (the tests we're tal=
king
> > about here do seem to run ok in my browser).
>=20
> I am not too worried about how this happens, but we should avoid
> constraining the work of our academic partners.  The reason I was thinking
> in terms of in the kernel was to avoid version-synchronization issues.
> "Wait, this is Linux kernel v4.17, which means that you need to use
> version 8.3.5.1 of the tooling...  And with these four patches as well."
>=20

Maybe including only the models' code(arm.cat, ppc.cat, etc.) into
kernel rather than the whole code base could also solve the
version-synchronization in some degree, and avoid maintaining the whole
tool code? I'm assuming modifying the verifier's code other than the
models' code will unlikely change the result of a litmus test.

Regards,
Boqun

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWJk20AAoJEEl56MO1B/q4ZhgIAIJNKrEF8I4MaF7LblwtWQzy
ZUULOT+HNdB8QIEjg2jg0eimdW4BjsI+ISr0330Hu6x2gSjmgPVUaSz0xniAXpCC
pfytWZFIxQC8KX5i5AceCKpmaaBEVWjMR8zjc20VXffNCyI7Jnt/UlMy+vPIgh8m
qN4G4GToiNQAltlNKJs0tikoAz75uS0WKpgzvQrc5kGUa03HYcXG9w0jGpfs7lEN
W38loU2QFBqMlWJU/XKSTF0JeJqtLxMc/4YOZlcMUCWy/6nEM1BhO+jqbKkWgCYl
gWn57Z+Vv6uHWcL1ojbOm6/9KJ3DQwa7aZTzUy10xBlsa3uY9jIkJ/0CtDH+o9Y=
=aig7
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--
