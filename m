Return-Path: <boqun.feng@gmail.com>
Received: from mail-ig0-x232.google.com (mail-ig0-x232.google.com
 [IPv6:2607:f8b0:4001:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6A2CD1A03C3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 12:22:47 +1100 (AEDT)
Received: by igbdj2 with SMTP id dj2so25325622igb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2015 17:22:45 -0800 (PST)
Date: Wed, 4 Nov 2015 09:22:13 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>
Subject: Re: [RESEND, tip/locking/core, v5, 1/6] powerpc: atomic: Make
 _return atomics and *{cmp}xchg fully ordered
Message-ID: <20151104012213.GA11056@fixme-laptop.cn.ibm.com>
References: <1445854536-22645-1-git-send-email-boqun.feng@gmail.com>
 <20151027023347.6178D140E31@ozlabs.org>
 <20151027030652.GB26372@fixme-laptop.cn.ibm.com>
 <20151030005633.GA2792@fixme-laptop.cn.ibm.com>
 <20151102012033.GA965@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
In-Reply-To: <20151102012033.GA965@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2015 at 09:22:40AM +0800, Boqun Feng wrote:
> > On Tue, Oct 27, 2015 at 11:06:52AM +0800, Boqun Feng wrote:
> > > To summerize:
> > >=20
> > > patch 1(split to two), 3, 4(remove inc/dec implementation), 5, 6 sent=
 as
> > > powerpc patches for powerpc next, patch 2(unmodified) sent as tip pat=
ch
> > > for locking/core.
> > >=20
> > > Peter and Michael, this works for you both?
> > >=20
> >=20
> > Thoughts? ;-)
> >=20
>=20
> Peter and Michael, I will split patch 1 to two and send them as patches
> for powerpc next first. The rest of this can wait util we are on the
> same page of where they'd better go.
>=20

I'm about to send patch 2(adding trivial tests) as a patch for the tip
tree, and rest of this series will be patches for powerpc next.

Will, AFAIK, you are currently working on variants on arm64, right? I
wonder whether you depend on patch 3 (allow archictures to provide
self-defined __atomic_op_*), if so I can also send patch 3 as a patch
for tip tree and wait until it merged into powerpc next to send the
rest.=20

Thanks and Best Regards,
Boqun

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWOV3BAAoJEEl56MO1B/q41dUH/iDGDJrNWi69wupX2/ESnTYZ
0fF+EBl7aPwm+5WlzrfGzkeimuhaxMOIHOCvhtSoBk08kGmWecjPfA8+TzEgwLO/
GUMgR72qFU+EiD/aor42PDFUV6xrBPOGX7L9U5HyAm2SifsIiMGkCAFcidV75FpP
N9zgT9dGK0GwvHH/FsuSsPsWKVXTllknyAr8p9pxx/tw6ZqXdJiqNZNdE8fIXNVa
4AY4zXhfzlg06SHYVJOZR7fCRZxU9eS7+qCEwLg7xAKGrpJjpu7sJQMYtqu+LCVZ
FHP+2kaKj5lBG/vupBCOHReD7RAW+9bqAO3X//uG9HTyZucJnf7waWwE0BX+NlA=
=q/rr
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
