Return-Path: <SRS0=/+OH=4Q=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A13C3F2CD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Feb 2020 17:03:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5FB42467B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Feb 2020 17:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FB42467B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48TbT33xs8zDrNR
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Feb 2020 04:03:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=the-dreams.de (client-ip=88.99.104.3; helo=pokefinder.org;
 envelope-from=wsa@the-dreams.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=the-dreams.de
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 48TbQC3spVzDrHm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Feb 2020 04:00:33 +1100 (AEDT)
Received: from localhost (p54B3301B.dip0.t-ipconnect.de [84.179.48.27])
 by pokefinder.org (Postfix) with ESMTPSA id 185E82C1E8B;
 Fri, 28 Feb 2020 18:00:29 +0100 (CET)
Date: Fri, 28 Feb 2020 18:00:26 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] macintosh: therm_windtunnel: fix regression when
 instantiating devices
Message-ID: <20200228170025.GA1130@ninjato>
References: <20200225141229.5424-1-wsa@the-dreams.de>
 <87imjsu8k2.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <87imjsu8k2.fsf@mpe.ellerman.id.au>
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
Cc: Mathieu Malaterre <malat@debian.org>, Erhard Furtner <erhard_f@mailbox.org>,
 debian-powerpc@lists.debian.org, linuxppc-dev@lists.ozlabs.org,
 linux-i2c@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> I think that would be best, it's more I2C related than powerpc arch
> stuff that I could review.

It is more DT handling than I2C, but I am happy to take this patch.


--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl5ZRyUACgkQFA3kzBSg
KbYafQ//Qh7A67ZsF/34YMOZJS3QdwmEabrYpv7+XymxJ1wCVD+1TB83CCV0jegS
b5Ok+mGt7aFkJTOCoOVr7iuwYljd5pBb0/pngrMnyXtQn7ByUGBKRC3Hi2b3pnws
iAceQXgWuo/fM3z+DCxrs290KYny9TJOHniLiw39YGExA17PZvE5E0Iyr9Cn+BX1
UJ9TPU+T8Rt2Q/b8O9GUIxLBnx5xJyuGye9r2l8m59PzkWYLxFQReKX0TvFQGFDL
QRPmcck6gJrQE8itXEvLnbmMHVQvB6d8YIfNwwWeM1sFQC4yq35qkeBFKMF0NeQb
m84limbwFDokSiHlT3doxyYJ8RosdbmP9xKWsh2dpeDRpKweWqIDI6WlCRWBuaFM
GxYeTsnbIOsTfWOOT5HaXaAY2TREDS24+OzW+vlV+hYfcTnqSHFLxLMWA7rnnc9l
wKjYxCWoZLBA8OStqmLRkTAjUDskiVcWDmnrgYg+oCCI7StpXD0r0uxiyzbbz9Ol
MjJy1SWJWrt8sK4VkzHttrSO83q3T2sktAHvKgecapAK4rupMKJjaF4T4vqJulmP
t2dDeyjrljrQSNBwxi7nLihUnwD2riTEBHULJdjJlurUJqfDZ0Omucw7d3BpTiMP
2UKPN9iHyB2EKMTgdO+cwpUTFhcIyQ8uRFTUGov5EJSzzWcs2j8=
=4G6n
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
