Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D0AC10F13
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 22:03:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C1B120880
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 22:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1B120880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dPYY2rXPzDqKN
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 08:02:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=ucw.cz
 (client-ip=195.113.26.193; helo=atrey.karlin.mff.cuni.cz;
 envelope-from=pavel@ucw.cz; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ucw.cz
X-Greylist: delayed 355 seconds by postgrey-1.36 at bilbo;
 Tue, 09 Apr 2019 08:01:23 AEST
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dPWl118xzDqHZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 08:01:22 +1000 (AEST)
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id 02D5380569; Mon,  8 Apr 2019 23:55:07 +0200 (CEST)
Date: Mon, 8 Apr 2019 23:55:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v10 01/18] counter: Introduce the Generic Counter interface
Message-ID: <20190408215515.GA27592@amd>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
 <ad3a8c427a911848373eae1c08e89353ffb6cb6d.1554184734.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <ad3a8c427a911848373eae1c08e89353ffb6cb6d.1554184734.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
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
Cc: mark.rutland@arm.com, benjamin.gaignard@st.com, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, patrick.havelange@essensium.com,
 thierry.reding@gmail.com, pmeerw@pmeerw.net, lars@metafoo.de,
 daniel.lezcano@linaro.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, david@lechnology.com,
 linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, tglx@linutronix.de,
 fabrice.gasnier@st.com, esben@haabendal.dk, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, knaack.h@gmx.de,
 akpm@linux-foundation.org, shawnguo@kernel.org, jic23@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +const char *const counter_count_direction_str[2] =3D {
> +	[COUNTER_COUNT_DIRECTION_FORWARD] =3D "forward",
> +	[COUNTER_COUNT_DIRECTION_BACKWARD] =3D "backward"
> +};
> +EXPORT_SYMBOL_GPL(counter_count_direction_str);
> +
> +const char *const counter_count_mode_str[4] =3D {
> +	[COUNTER_COUNT_MODE_NORMAL] =3D "normal",
> +	[COUNTER_COUNT_MODE_RANGE_LIMIT] =3D "range limit",
> +	[COUNTER_COUNT_MODE_NON_RECYCLE] =3D "non-recycle",
> +	[COUNTER_COUNT_MODE_MODULO_N] =3D "modulo-n"
> +};
> +EXPORT_SYMBOL_GPL(counter_count_mode_str);

Dunno. Exporting const tables saying "forward" and "backward". Can we
=2E.. somehow make it work without need to export this?

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyrw0MACgkQMOfwapXb+vI0fQCeOVJVU9FSIbeRA4WSFP7n6OI7
dq8AnR+Ykf6BWrqHixl+oRJ+LYhLlFau
=/6R+
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
