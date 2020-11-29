Return-Path: <SRS0=3W5+=FD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701ACC3E8C5
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Nov 2020 17:35:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 618E42080C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Nov 2020 17:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618E42080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ckb916JxXzDrSp
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Nov 2020 04:35:01 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Ckb733ZPczDrSB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2020 04:33:18 +1100 (AEDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <ukl@pengutronix.de>)
 id 1kjQYS-0006zE-4U; Sun, 29 Nov 2020 18:32:08 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1kjQYH-0003Mg-0E; Sun, 29 Nov 2020 18:31:57 +0100
Date: Sun, 29 Nov 2020 18:31:53 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Takashi Iwai <tiwai@suse.de>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc/ps3: make system bus's remove and shutdown
 callbacks return void
Message-ID: <20201129173153.jbt3epcxnasbemir@pengutronix.de>
References: <20201126165950.2554997-1-u.kleine-koenig@pengutronix.de>
 <20201126165950.2554997-2-u.kleine-koenig@pengutronix.de>
 <s5hv9dphnoh.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q5fwi2prasbljs5f"
Content-Disposition: inline
In-Reply-To: <s5hv9dphnoh.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>,
 Paul Mackerras <paulus@samba.org>, linux-scsi@vger.kernel.org,
 Alan Stern <stern@rowland.harvard.edu>, Jakub Kicinski <kuba@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Geoff Levand <geoff@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Jim Paris <jim@jtan.com>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--q5fwi2prasbljs5f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Michael,

On Sat, Nov 28, 2020 at 09:48:30AM +0100, Takashi Iwai wrote:
> On Thu, 26 Nov 2020 17:59:50 +0100,
> Uwe Kleine-K=F6nig wrote:
> >=20
> > The driver core ignores the return value of struct device_driver::remove
> > because there is only little that can be done. For the shutdown callback
> > it's ps3_system_bus_shutdown() which ignores the return value.
> >=20
> > To simplify the quest to make struct device_driver::remove return void,
> > let struct ps3_system_bus_driver::remove return void, too. All users
> > already unconditionally return 0, this commit makes it obvious that
> > returning an error code is a bad idea and ensures future users behave
> > accordingly.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> For the sound bit:
> Acked-by: Takashi Iwai <tiwai@suse.de>

assuming that you are the one who will apply this patch: Note that it
depends on patch 1 that Takashi already applied to his tree. So you
either have to wait untils patch 1 appears in some tree that you merge
before applying, or you have to take patch 1, too. (With Takashi
optinally dropping it then.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--q5fwi2prasbljs5f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/D2wYACgkQwfwUeK3K
7AmmxQf+IiMtqhw/kONuYhwVAdprYhlgZyY9iZSe5xHA/6/1zNmBbfhPRm6PfStb
RRMTewx97J4joVbCv7OhlZBsoA7lnpUKJD05Qt7eXIEMdnuscbTx8YZr/z94s9/Y
/ElFT8e2Wx6crnEbjWeFcYVTLkGgf1pnUhpFmTq4LwQqqV5lQWUu6JMnS8THMhay
RCwTJR+P84Nw4wv39uvWN4LFmuDeM5hjnPjoEFBbnAeUtQr62AAh7itX8pTNEyZp
t6M09QdoxpJWDPe/vRxYZSZdsuE+vXsCuMWH5Kyo0hodOX9m6JpOhsPm/YiaCK5B
IW1LSeEeHe9uPQSACw7mkNft9x6Zfg==
=TO3P
-----END PGP SIGNATURE-----

--q5fwi2prasbljs5f--
