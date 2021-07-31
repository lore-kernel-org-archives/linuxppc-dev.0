Return-Path: <SRS0=4kvs=MX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A86C4338F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 31 Jul 2021 21:42:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3769A60F39
	for <linuxppc-dev@archiver.kernel.org>; Sat, 31 Jul 2021 21:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3769A60F39
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gcd5V1gmTz3cT1
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Aug 2021 07:42:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=pengutronix.de (client-ip=2001:67c:670:201:290:27ff:fe1d:cc33;
 helo=metis.ext.pengutronix.de; envelope-from=ukl@pengutronix.de;
 receiver=<UNKNOWN>)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GcNPw6lW6z301N
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jul 2021 22:10:27 +1000 (AEST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <ukl@pengutronix.de>)
 id 1m9nnU-0007Ot-05; Sat, 31 Jul 2021 14:08:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
 by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <ukl@pengutronix.de>)
 id 1m9nnD-0007eB-Mm; Sat, 31 Jul 2021 14:08:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
 (envelope-from <ukl@pengutronix.de>)
 id 1m9nnD-0001LE-Jt; Sat, 31 Jul 2021 14:08:39 +0200
Date: Sat, 31 Jul 2021 14:08:36 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v1 4/5] PCI: Adapt all code locations to not use struct
 pci_dev::driver directly
Message-ID: <20210731120836.vegno6voijvlflws@pengutronix.de>
References: <20210729203740.1377045-1-u.kleine-koenig@pengutronix.de>
 <20210729203740.1377045-5-u.kleine-koenig@pengutronix.de>
 <2b5e8cb5-fac2-5da2-f87b-d287d2c5ea81@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rawlqk3jhoxts24y"
Content-Disposition: inline
In-Reply-To: <2b5e8cb5-fac2-5da2-f87b-d287d2c5ea81@oracle.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linuxppc-dev@lists.ozlabs.org
X-Mailman-Approved-At: Sun, 01 Aug 2021 07:41:46 +1000
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-pci@vger.kernel.org,
 Alexander Duyck <alexanderduyck@fb.com>, x86@kernel.org,
 oss-drivers@corigine.com, netdev@vger.kernel.org,
 Oliver O'Halloran <oohall@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Jiri Olsa <jolsa@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Taras Chornyi <tchornyi@marvell.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-scsi@vger.kernel.org,
 Sathya Prakash <sathya.prakash@broadcom.com>, qat-linux@intel.com,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Jakub Kicinski <kuba@kernel.org>, Yisen Zhuang <yisen.zhuang@huawei.com>,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
 Fiona Trahe <fiona.trahe@intel.com>, Andrew Donnellan <ajd@linux.ibm.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Ido Schimmel <idosch@nvidia.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Michael Buesch <m@bues.ch>, Jiri Pirko <jiri@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, Juergen Gross <jgross@suse.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 Sreekanth Reddy <sreekanth.reddy@broadcom.com>, xen-devel@lists.xenproject.org,
 Vadym Kochan <vkochan@marvell.com>, MPT-FusionLinux.pdl@broadcom.com,
 linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Zhou Wang <wangzhou1@hisilicon.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-crypto@vger.kernel.org, kernel@pengutronix.de,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Simon Horman <simon.horman@corigine.com>,
 Wojciech Ziemba <wojciech.ziemba@intel.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--rawlqk3jhoxts24y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Boris,

On Fri, Jul 30, 2021 at 04:37:31PM -0400, Boris Ostrovsky wrote:
> On 7/29/21 4:37 PM, Uwe Kleine-K=F6nig wrote:
> > --- a/drivers/pci/xen-pcifront.c
> > +++ b/drivers/pci/xen-pcifront.c
> > @@ -599,12 +599,12 @@ static pci_ers_result_t pcifront_common_process(i=
nt cmd,
> >  	result =3D PCI_ERS_RESULT_NONE;
> > =20
> >  	pcidev =3D pci_get_domain_bus_and_slot(domain, bus, devfn);
> > -	if (!pcidev || !pcidev->driver) {
> > +	pdrv =3D pci_driver_of_dev(pcidev);
> > +	if (!pcidev || !pdrv) {
>=20
> If pcidev is NULL we are dead by the time we reach 'if' statement.

Oh, you're right. So this needs something like:

	if (!pcidev || !(pdrv =3D pci_driver_of_dev(pcidev)))

or repeating the call to pci_driver_of_dev for each previous usage of
pdev->driver.

If there are no other preferences I'd got with the first approach for
v2.

Best regards and thanks for catching,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rawlqk3jhoxts24y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEFPUEACgkQwfwUeK3K
7AlQoAgAidQUuX/L2YhXMvP0F+SSjym4ILhKdbRYnWojo/QbFUE8WbOQueAZA76q
NW0vq2X07i0bUwTfbZoOgqSFvMfXJiETcN9R48epPUGWS2IT17NE8EgtH+/srht0
sGGI7bia2a1L++nruccUllCf1qMfngKRQUhatVOPYqIs2dX3ijjjpSAxHh8L+gjC
nOMgWu7lZm7QQawBjQGfirpYGBUFdAh3odwm/JHN7+cZKC6dbhLYGm2WS8db1bCI
4k4EO2RpSeuZb9XaFPq9DEWy1exgtgjnmKt3Szrp31/xWizjhMEOrZVWfWD1bjUa
rWcmnDR4bm4Fz/MdVFhjJq2XJQoIDw==
=2o5y
-----END PGP SIGNATURE-----

--rawlqk3jhoxts24y--
