Return-Path: <boqun.feng@gmail.com>
Received: from mail-ig0-x230.google.com (mail-ig0-x230.google.com
 [IPv6:2607:f8b0:4001:c05::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 66B491A028B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 20:27:18 +1100 (AEDT)
Received: by igbif5 with SMTP id if5so16927831igb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 02:27:16 -0700 (PDT)
Date: Wed, 14 Oct 2015 17:26:53 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH RESEND v3 1/6] powerpc: atomic: Make *xchg and *cmpxchg a
 full barrier
Message-ID: <20151014092653.GA29432@fixme-laptop.cn.ibm.com>
References: <1444659246-24769-1-git-send-email-boqun.feng@gmail.com>
 <1444660220-25559-1-git-send-email-boqun.feng@gmail.com>
 <1444781400.12197.4.camel@ellerman.id.au>
 <20151014005134.GE23991@fixme-laptop.cn.ibm.com>
 <20151014080613.GP17308@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
In-Reply-To: <20151014080613.GP17308@twins.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2015 at 10:06:13AM +0200, Peter Zijlstra wrote:
> On Wed, Oct 14, 2015 at 08:51:34AM +0800, Boqun Feng wrote:
> > On Wed, Oct 14, 2015 at 11:10:00AM +1100, Michael Ellerman wrote:
>=20
> > > Thanks for fixing this. In future you should send a patch like this a=
s a
> > > separate patch. I've not been paying attention to it because I assume=
d it was
> >=20
> > Got it. However, here is the thing, in previous version, this fix
> > depends on some of other patches in this patchset. So to make this fix
> > applied cleanly, I reorder my patchset to put this patch first, and the
> > result is that some of other patches in this patchset depends on
> > this(they need to remove code modified by this patch).
> >=20
> > So I guess I'd better to stop Cc stable for this one, and wait until
> > this patchset merged and send a separate patch for -stable tree. Does
> > that work for you? I think this is what Peter want to suggests me to do
> > when he asked me about this, right, Peter?
>=20
> I don't think I had explicit thoughts about any of that, just that it
> might make sense to have this patch not depend on the rest such that it
> could indeed be stuffed into stable.
>=20

Got that. Sorry for misunderstanding you...

> I'll leave the details up to Michael since he's PPC maintainer.

Michael and Peter, rest of this patchset depends on commits which are
currently in the locking/core branch of the tip, so I would like it as a
whole queued there. Besides, I will keep this patch Cc'ed to stable in
future versions, that works for you both?

Regards,
Boqun

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWHh/ZAAoJEEl56MO1B/q4wbEIAI5iUUygtJPKne/zyMlmoGq3
MXynxxNc/blCstIn4Q7I9nIuoy6iXwefnN9TDnLGl/q9vcS4tl5/tnF6ktZglePI
X4CXU1yjAb09nPi8mYWkwZT2QYu/AXlS3eJOtuKcZsG0v58475U8ilJnVeGmvMrt
yJYMAT7qszuYQrW6LPX5OzbAcHzXoCQ5HepQq8G/dgpi37WFMxp35Qy6BC5Sh5AE
8PG323GsRP1KrCrkqEycgUX9i1pADZmcgv5HIuO4AO8b7WOF6M2s/PqQBL6v8YZt
vSMwTSzg+S7Z5G5V34DthdUVhRzLvKwO0mFvOtK01ZJ1lRK3YzAJ1/qtUIYBjo0=
=bPcE
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
