Return-Path: <boqun.feng@gmail.com>
Received: from mail-pf0-x234.google.com (mail-pf0-x234.google.com
 [IPv6:2607:f8b0:400e:c00::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xL3YV35KvzDr2v
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 23:37:50 +1000 (AEST)
Received: by mail-pf0-x234.google.com with SMTP id z129so71928316pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 06:37:50 -0700 (PDT)
Date: Sun, 30 Jul 2017 21:37:47 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dzickus@redhat.com,
 sfr@canb.auug.org.au, linuxarm@huawei.com,
 Nicholas Piggin <npiggin@gmail.com>, abdhalee@linux.vnet.ibm.com,
 sparclinux@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
Message-ID: <20170730133747.anusyacw2l5hhjgx@tardis>
References: <20170727143400.23e4d2b2@roar.ozlabs.ibm.com>
 <20170727124913.GL3730@linux.vnet.ibm.com>
 <20170727144903.000022a1@huawei.com>
 <20170727173923.000001b2@huawei.com>
 <20170727165245.GD3730@linux.vnet.ibm.com>
 <20170728084411.00001ddb@huawei.com>
 <20170728125416.j7gcgvnxgv2gq73u@tardis>
 <20170728145530.GE3730@linux.vnet.ibm.com>
 <20170728184129.GA24364@linux.vnet.ibm.com>
 <20170728190956.GA26640@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fq4swd667bw3cpsc"
In-Reply-To: <20170728190956.GA26640@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--fq4swd667bw3cpsc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 12:09:56PM -0700, Paul E. McKenney wrote:
> On Fri, Jul 28, 2017 at 11:41:29AM -0700, Paul E. McKenney wrote:
> > On Fri, Jul 28, 2017 at 07:55:30AM -0700, Paul E. McKenney wrote:
> > > On Fri, Jul 28, 2017 at 08:54:16PM +0800, Boqun Feng wrote:
>=20
> [ . . . ]
>=20
> > > Even though Jonathan's testing indicates that it didn't fix this
> > > particular problem:
> > >=20
> > > Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >=20
> > And while we are at it:
> >=20
> > Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>=20
> Not because it it fixed the TREE01 issue -- it did not.  But as near
> as I can see, it didn't cause any additional issues.
>=20

Understood.

Still work on waketorture for a test case which could trigger this
problem in a real world. My old plan is to send this out when I could
use waketorture to show this patch actually resolves some potential
bugs, but just put it ahead here in case it may help.

Will send it out with your Tested-by and Acked-by and continue to work
on waketorture.

Regards,
Boqun

> 							Thanx, Paul
>=20

--fq4swd667bw3cpsc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAll94SgACgkQSXnow7UH
+riHPQf/W+gBEetAavrwz1vbSt41MgW/TK1U22OWiL0qFGtzEy7nm6i0Bm2229So
8uMKweTt869MrEFBXrdHwZkUa1ngWuMnKNUz98z4zunFS4a9JJXc6pLsXW+X0kj/
ruup16kWt+YuKU3Ritc0BfuFQBfhDZdhxujU3whRdPalxa2f6FyhiewfNU1FVGMM
Ltj4IUuZd3YiE/1jmkkEdWseygRPO2DWpty8b60blWodCfhoA2SvY3HQ/sAYxa06
fHsYMACnvTzGqEvtGpLp63FeUZfPmcV6AZ4nVsnmcc6Jp9CA/WQPGlcieI9djGlo
gszTV6Kx1NUfOrueiaWcV5Us4UXtMw==
=Klcn
-----END PGP SIGNATURE-----

--fq4swd667bw3cpsc--
