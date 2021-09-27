Return-Path: <SRS0=zuPs=OR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37E3C433F5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Sep 2021 21:23:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21E8F60FC2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Sep 2021 21:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 21E8F60FC2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HJFwr5SFbz3btR
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Sep 2021 07:23:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=pengutronix.de (client-ip=2001:67c:670:201:290:27ff:fe1d:cc33;
 helo=metis.ext.pengutronix.de; envelope-from=ukl@pengutronix.de;
 receiver=<UNKNOWN>)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HJFQ06JL8z2yLm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Sep 2021 06:59:51 +1000 (AEST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <ukl@pengutronix.de>)
 id 1mUxik-0003sZ-Tr; Mon, 27 Sep 2021 22:59:30 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
 by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <ukl@pengutronix.de>)
 id 1mUxia-0001cX-8M; Mon, 27 Sep 2021 22:59:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
 (envelope-from <ukl@pengutronix.de>)
 id 1mUxia-0001SG-3t; Mon, 27 Sep 2021 22:59:20 +0200
Date: Mon, 27 Sep 2021 22:59:17 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH v4 0/8] PCI: Drop duplicated tracking of a pci_dev's
 bound driver
Message-ID: <20210927205917.e763q5mojkwk6per@pengutronix.de>
References: <20210927204326.612555-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="upxcpc44c7obtcwt"
Content-Disposition: inline
In-Reply-To: <20210927204326.612555-1-uwe@kleine-koenig.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linuxppc-dev@lists.ozlabs.org
X-Mailman-Approved-At: Tue, 28 Sep 2021 07:22:17 +1000
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
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Alexander Duyck <alexanderduyck@fb.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Sathya Prakash <sathya.prakash@broadcom.com>, oss-drivers@corigine.com,
 netdev@vger.kernel.org, Oliver O'Halloran <oohall@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Paul Mackerras <paulus@samba.org>, Marco Chiappero <marco.chiappero@intel.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-scsi@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>,
 =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, qat-linux@intel.com,
 Christoph Hellwig <hch@lst.de>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-pci@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Yisen Zhuang <yisen.zhuang@huawei.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>, Fiona Trahe <fiona.trahe@intel.com>,
 Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jack Xu <jack.xu@intel.com>,
 Borislav Petkov <bp@alien8.de>, Michael Buesch <m@bues.ch>,
 Jiri Pirko <jiri@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Juergen Gross <jgross@suse.com>, Salil Mehta <salil.mehta@huawei.com>,
 Sreekanth Reddy <sreekanth.reddy@broadcom.com>, xen-devel@lists.xenproject.org,
 Vadym Kochan <vkochan@marvell.com>, MPT-FusionLinux.pdl@broadcom.com,
 linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Mathias Nyman <mathias.nyman@intel.com>, Zhou Wang <wangzhou1@hisilicon.com>,
 linux-crypto@vger.kernel.org, kernel@pengutronix.de,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Simon Horman <simon.horman@corigine.com>,
 Wojciech Ziemba <wojciech.ziemba@intel.com>,
 Tomaszx Kowalik <tomaszx.kowalik@intel.com>, linuxppc-dev@lists.ozlabs.org,
 Taras Chornyi <tchornyi@marvell.com>, linux-perf-users@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--upxcpc44c7obtcwt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Sep 27, 2021 at 10:43:18PM +0200, Uwe Kleine-K=F6nig wrote:
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I sent the series from the wrong email address :-\ I should have used
the above address as sender. Also I failed to add Christoph Hellwig to
Cc: (fixed for this mail). I guess I'll have to send a v5, but I will
wait a bit until the build bots are done with this series.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--upxcpc44c7obtcwt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFSMKIACgkQwfwUeK3K
7AnalQgAlpBrfIgHu7fEFcJYkSR/33uv+V4CLZsCsu9MNXsSeds9vT38r8/y0bJl
rOEKhsH1blIcq3bsV8/AulLrFkmjYRkkih/gA/y9CeoqpbV0/NzhrS4Xo9kMos8z
n+0f+PzRO1qg1RVWyPL7K4pkXR5cMkqWGoie07ihkt3Y9mVY8ItYl9ny3oDxCRcU
r8KFjr7Jw0Vo8eI3Kr9lu62KyFZFByf1DDBurR5crF8ZcWM7e9kOezvJrxOQxGPP
Z82uFafVCkhtIkKaks/6/y9pMmJF9hzDd91ubgKfbkPIMvBjpL7n07Y/Sk4S34vM
5wdHQGNinogsdgdebn8YdZCULLmXSQ==
=/nd3
-----END PGP SIGNATURE-----

--upxcpc44c7obtcwt--
