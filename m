Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x22b.google.com (mail-pd0-x22b.google.com
 [IPv6:2607:f8b0:400e:c02::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EC9742C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 18:04:43 +1000 (EST)
Received: by mail-pd0-f171.google.com with SMTP id g10so4539580pdj.30
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 01:04:41 -0700 (PDT)
Date: Tue, 27 Aug 2013 16:04:32 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc/irq: remove the unneeded flag PACA_IRQ_EE_EDGE
Message-ID: <20130827080432.GE15834@pek-khao-d1.corp.ad.wrs.com>
References: <1365643954-20798-1-git-send-email-haokexin@gmail.com>
 <1365643954-20798-2-git-send-email-haokexin@gmail.com>
 <1377590004.3819.120.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3O1VwFp74L81IIeR"
In-Reply-To: <1377590004.3819.120.camel@pasglop>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--3O1VwFp74L81IIeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2013 at 05:53:24PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2013-04-11 at 09:32 +0800, Kevin Hao wrote:
> > In order to support the Book3E external proxy, the flag
> > PACA_IRQ_EE_EDGE was introduced in patch 7230c564 (powerpc: Rework
> > lazy-interrupt handling). But it turns out that this is not needed.
> > And it is also not used by any code in the current kernel. According
> > to the PowerISA 2.0.6, the content of EPR (External Proxy Register)
> > is valid until MSR[EE] is set to 1. Since we never enable the hard irq
> > before replaying a external interrupt. That means we still can get
> > the valid interrupt vector from EPR when replaying irq.
>=20
> I assume you understand why that patch is broken and this is superseeded
> by your more recent series to actually make use of PACA_IRQ_EE_EDGE
> right ? :-)

Yes.

>=20
> (Just making sure I can take that one out of patchwork).

Definitely.

Thanks,
Kevin

--3O1VwFp74L81IIeR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJSHF2QAAoJEJNY7TDerrFxqqgH/0hJgQea48KEWzvcxlJ4Vl66
/n/a+LEhmqZGaJDZJelsBjlg6ri2Muo69CsvyaU68QMaKmpb01YBvvJB1hF1racS
d+26f0NigJy4t37XlP3vLdPmPftW8BHLnCNy747ydUzykkpvJmbc7y6v+oEY5buk
4mE+NFUWfz3mweyiOd+HWM+3MJI/DO9/Zs4G03Sag8T/2rdlmhHrOWAJhk09WV67
BKgJwpqdMa2KYDAQbNvPuwXQAL4JquqGbj+R2ProrokDq8v07t5BTednaHFuDrbI
NY+UcFV06dRDQs4RzwumtW+JJw5cUeB7V+1oR2hkoUI8yiNNoqO5cCdQZSktJpI=
=q8Xz
-----END PGP SIGNATURE-----

--3O1VwFp74L81IIeR--
