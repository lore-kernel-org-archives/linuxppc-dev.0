Return-Path: <SRS0=1PmZ=FA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DD1C63697
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 17:48:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 332A12053B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 17:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332A12053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Chlbb6F2lzDrM9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2020 04:48:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=pengutronix.de (client-ip=2001:67c:670:201:290:27ff:fe1d:cc33;
 helo=metis.ext.pengutronix.de; envelope-from=ukl@pengutronix.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ChlXg21ZczDrFd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2020 04:45:38 +1100 (AEDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <ukl@pengutronix.de>)
 id 1kiLJw-00062v-QB; Thu, 26 Nov 2020 18:44:40 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1kiLJt-0004bc-N3; Thu, 26 Nov 2020 18:44:37 +0100
Date: Thu, 26 Nov 2020 18:44:35 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Geoff Levand <geoff@infradead.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jens Axboe <axboe@kernel.dk>,
 Jim Paris <jim@jtan.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 2/2] powerpc/ps3: make system bus's remove and shutdown
 callbacks return void
Message-ID: <20201126174435.6ffei52xx7nedkhg@pengutronix.de>
References: <20201126165950.2554997-1-u.kleine-koenig@pengutronix.de>
 <20201126165950.2554997-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w2mbrz5zdzqi2nqy"
Content-Disposition: inline
In-Reply-To: <20201126165950.2554997-2-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linuxppc-dev@lists.ozlabs.org
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--w2mbrz5zdzqi2nqy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[dropped a few lists from Cc: that are off-topic for this mail]

Hello,

while creating this patch series I looked at ps3_system_bus_shutdown().
I think the BUG_ON(!drv) in (now) line 422 can be easily triggered when
there is a device without driver. (Try unbinding via sysfs before
shutdown.)

Also the BUG in (now) line 437 seems possible to trigger. Consider a
driver that doesn't have the two callbacks, e.g. because there is
nothing special to do on shutdown and probe only used devm_* resources.

While at it, I find it surprising that the remove callback is called if
there is no shutdown callback.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--w2mbrz5zdzqi2nqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+/6X8ACgkQwfwUeK3K
7AmYzAf+PpCOuMqD4UBfefCRIUwudxf9ISVnQCjwQzxrdPToB01XUocHoAB1FpN0
WrzyRn+73hK/O1VkUG60nAiNMPTb27hTXOOkPeGdwj7E2XAHuxWGqIWCNghWrRQ/
xwvyPWr0lvk9DcIsYCFbHdmEvvv0VY9ZvwoTPnGsvfIZvXbDwYBAJQpuHmRTBMlh
U2o+R7XONPUh4Qwc0rQwm6ZG88Hv7Ys7P830lq1JKduRYyJp4IUaT20Hi3+PmEZx
BwI5eeFwVbmtDYKZcVgUDt8Wj6usP5/YhZ/k6jv4pbV8657vkQoDtfMVPMCCoMfg
OTMkNSfEyHsYKaxaPrvG0/MQiUA85Q==
=uKOR
-----END PGP SIGNATURE-----

--w2mbrz5zdzqi2nqy--
