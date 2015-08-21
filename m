Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AAB5F1A0220
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 13:23:48 +1000 (AEST)
Received: by pawq9 with SMTP id q9so42141167paw.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 20:23:46 -0700 (PDT)
Date: Fri, 21 Aug 2015 11:23:34 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/8] jump_label: introduce
 DEFINE_STATIC_KEY_{TRUE,FALSE}_ARRAY macros
Message-ID: <20150821032334.GB12451@pek-khao-d1.corp.ad.wrs.com>
References: <1440072876-8321-1-git-send-email-haokexin@gmail.com>
 <1440072876-8321-4-git-send-email-haokexin@gmail.com>
 <20150820183158.GB3161@worktop.event.rightround.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
In-Reply-To: <20150820183158.GB3161@worktop.event.rightround.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2015 at 08:31:58PM +0200, Peter Zijlstra wrote:
> On Thu, Aug 20, 2015 at 08:14:31PM +0800, Kevin Hao wrote:
> > These are used to define a static_key_{true,false} array.
>=20
> Yes but why...
>=20
> there might have been some clue in the patches you didn't send me, but
> since you didn't send them, I'm left wondering.

Sorry for the confusion. In order to use jump label for the
{cpu,mmu}_has_feature() functions on powerpc, we need to declare an array of
32 or 64 static_key_true (one static_key_true for each cpu or mmu feature).
The following are the two patches which depends on this patch.
  https://lkml.org/lkml/2015/8/20/355
  https://lkml.org/lkml/2015/8/20/356

So far only DEFINE_STATIC_KEY_TRUE_ARRAY macro is used, but I think it may =
seem
canonical to define the macros for both true or false keys at the same time.

Thanks,
Kevin

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1pm2AAoJEJNY7TDerrFxgGoH/AzZdWnV6lQPEj0HihJa4Dfv
lMEgt4lyG96JqJ3pMnmT5abP353nk7LJBKd1Sy6I0PKyfcSzKVR9qkAiAE1rdOt1
/uXF1KDtZdrEKi2zo9a7e5JncxQwePPNljTA7OF0xNfzuvChgPMLLp5cWlbUZUoy
QqUYpWQouWE8S9gt5FqQhy8kusHrHkXHRYsaA8w9jA5ejOLPXYuZ8pEdHLiwp7sc
czHpe4deCYWMVruDrmnLJYyRM9Y8joLidDIdTQMkGnfx2Cl5FN7Rmdqu3OcjOkH1
kwhcwaerDlUb6lFD5VShIfm3ieNFdr42iJijbEdtOFbw4SNkrWz2s5p0nwhHGUQ=
=AVsk
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
