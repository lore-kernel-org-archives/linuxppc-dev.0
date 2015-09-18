Return-Path: <boqun.feng@gmail.com>
Received: from mail-oi0-x229.google.com (mail-oi0-x229.google.com
 [IPv6:2607:f8b0:4003:c06::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D91E41A2D9A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 19:59:31 +1000 (AEST)
Received: by oibi136 with SMTP id i136so24028985oib.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 02:59:29 -0700 (PDT)
Date: Fri, 18 Sep 2015 17:59:05 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>,
 Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH] powerpc: Kconfig: remove BE-only platforms from LE
 kernel build
Message-ID: <20150918095905.GA20458@fixme-laptop.cn.ibm.com>
References: <1441583880-17824-1-git-send-email-boqun.feng@gmail.com>
 <20150918002208.GB1300@fixme-laptop.cn.ibm.com>
 <1442569796.5528.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
In-Reply-To: <1442569796.5528.1.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2015 at 07:49:56PM +1000, Michael Ellerman wrote:
> On Fri, 2015-09-18 at 08:22 +0800, Boqun Feng wrote:
> > Ping ;-)
>=20
> Hi Boqun,
>=20

Hello,

> We keep track of patches in patchwork:
>=20
>   http://patchwork.ozlabs.org/project/linuxppc-dev/list/?submitter=3D67102
>=20

Good to know ;-)

> So your patch won't be forgotten.
>=20
> I tend to start taking patches for next after rc2, which should come out =
on
> Sunday. So I'll probably merge this patch next week, when I do you'll get=
 an
> email.
>=20

Understood. Thank you!

Regards,
Boqun

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV++BlAAoJEEl56MO1B/q4B5IH/1NvCzcrDttyoOb9n4GmZ+V6
IMxzxezbxnynM3Z6clpZlHNi8uh4lXs2GEsGVPLOvB/tR7BcLaGw7yOzx8gyM+Be
UnA9Az1d/TQQJk0WGwbDlhbe1Aaod/dX1Dqt1khtaAn2ULLtmAK1OTfHDm5AlEtg
sSyZn3G58j2xHeb4yHBzzb4HTCKYte/DrhfxRb7k5SDsAmyUJdEOHAtj8mLnm5CV
7oZN+KDFtY5zmgmkJmqOegsvqodHiuJBlUTmviUO2qMtZOt4TF9ykPyUT/HvpS2w
1HZcvdPL8/8fSYFNIAsKC0BuLuSfIvauIFK20/JMp1Qni4qZr+ufX8Uddx88bkk=
=McqE
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
