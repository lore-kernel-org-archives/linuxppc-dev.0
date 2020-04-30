Return-Path: <SRS0=8RrW=6O=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CFBC83000
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2020 14:27:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0AD22074A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2020 14:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0AD22074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Cd4P4YCxzDr9W
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2020 00:27:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=the-dreams.de (client-ip=88.99.104.3; helo=pokefinder.org;
 envelope-from=wsa@the-dreams.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=the-dreams.de
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 49CcwJ1dl7zDr32
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2020 00:20:00 +1000 (AEST)
Received: from localhost (p5486CDDB.dip0.t-ipconnect.de [84.134.205.219])
 by pokefinder.org (Postfix) with ESMTPSA id 7109E2C08FC;
 Thu, 30 Apr 2020 16:19:58 +0200 (CEST)
Date: Thu, 30 Apr 2020 16:19:58 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Jason Yan <yanaijie@huawei.com>
Subject: Re: [PATCH] i2c: powermac: use true,false for bool variable
Message-ID: <20200430141958.GD3355@ninjato>
References: <20200426094228.23829-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VV4b6MQE+OnNyhkM"
Content-Disposition: inline
In-Reply-To: <20200426094228.23829-1-yanaijie@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, linux-i2c@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2020 at 05:42:28PM +0800, Jason Yan wrote:
> In i2c_powermac_register_devices(), variable 'found_onyx' is bool and
> assigned '0' and 'true' in different places. Use 'false' instead of '0'.
> This fixes the following coccicheck warning:
>=20
> drivers/i2c/busses/i2c-powermac.c:318:6-16: WARNING: Assignment of 0/1
> to bool variable
>=20
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied to for-next, thanks!


--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6q3o0ACgkQFA3kzBSg
KbZL7g/+Jx3DwuNXMIDZziy2bjDNXsNXe3zRIKEzNCL2nx1rvSJb8H4V+TeBXxvZ
CFVMrIqx0ZBSnhCPZiIJnQFdWp6EG7ai83+3e2JkJEE7decC3OT0ccwYPc/zb0VK
6/DSHsduSnybuID3uEAh4URl9rMo1R3pAW+BH4s9VKd3mFHiX/ut7YBXtp8WNF+u
QTrl17pTLJkUKZGziIVK20zcp38lmKXDpdlJuNqDFH8NLNofjujvCn9809T1MOgS
u6yr0hAUTeN6jEGwEMKM4mwyiImescsj6ZGCY7gUK38s0Cq4Cm4/T3nTMSyqscfP
GAmOJbqZ5uuwFaj0XClO+kNscv0cCrnK0wSGZDhrqI6pxyxpUGd6atz6HTCMCkB6
/tlsX+JiOIRPgetDoWBRvp6hAUPW7Fgu/SHMR/yw36q8vr4oJbLqq/CIv34tp340
tFrD4L0B0gynE+/wK1qTGS2kWhvuIU3m6ckO9hE/2Iz/S57UUJKt0aFq91uuWDOV
Jf0KsWTtJLHlKRPp9HlQDhQT1dIWIk9kaqqjgQU3oa6oCq3TvdvC5DfUPl1xzgxT
h9VIXW0Hy7x4JMGdmrqbHL5Wo0WPN/FzEp/7HYOrFlLKnLCncIujv/7oJSdQ43at
cQcR2BqBcwYKYyS0SQuhm66GIeYmZ4xO5fQ5dL3RTE0wCPP/WPQ=
=Hy2w
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--
