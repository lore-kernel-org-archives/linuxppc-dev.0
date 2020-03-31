Return-Path: <SRS0=kug9=5Q=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6E8C2D0F1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2020 15:43:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC0F20786
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2020 15:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC0F20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48sDB90vjczDqTP
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2020 02:43:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=the-dreams.de (client-ip=88.99.104.3; helo=pokefinder.org;
 envelope-from=wsa@the-dreams.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=the-dreams.de
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 48sCz21FHKzDqsb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2020 02:33:30 +1100 (AEDT)
Received: from localhost (p54B3321E.dip0.t-ipconnect.de [84.179.50.30])
 by pokefinder.org (Postfix) with ESMTPSA id 8785E2C1EED;
 Tue, 31 Mar 2020 17:33:26 +0200 (CEST)
Date: Tue, 31 Mar 2020 17:33:23 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v2] macintosh: convert to i2c_new_scanned_device
Message-ID: <20200331153323.GA5709@ninjato>
References: <20200326113819.7761-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20200326113819.7761-1-wsa+renesas@sang-engineering.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2020 at 12:38:19PM +0100, Wolfram Sang wrote:
> Move from the deprecated i2c_new_probed_device() to the new
> i2c_new_scanned_device(). No functional change for this driver because
> it doesn't check the return code anyhow.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to for-next, thanks!


--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6DYr8ACgkQFA3kzBSg
KbaRrQ/+NkT1leu18nmq9wUmVuXHs4jwgNIrw3w+V7G7J7jdi1G5SLFdwNgCoQSW
qRuK6Oq9+8nKYBFfnLS/XsU9jzpsRTyVKUaEr0OeomaR/LiL8ouAUYWsR0pnMstR
qLRBI2MUa0w638fXxOf08/hHWb9h4d5CNjuo3clkaW1JhdFhWngAYgrIBg7HQn0U
NVaN5fn/d4rxtUsIdoLgI8OPZEnFf7ZJ03Oidrm4bV8q4MZ0XNC5wAnf4+aHlo5T
pu5Krq+8nAHFZUITeqjQcE1Rw0PUuMxfUXT7eix9W/xo7cVgRLEYHwOlyLi4l5It
ABX9JPDpod6Jgw6PKY7HN35O+xgwAsSw9LS/pFJzmihWSb7lUYEiVYSbgnq08x3Y
YnE/pNYluRzBt8Xp6XoUQQNNxig0gKZXC/54r0AmIno/TAmRpMest1OqUJpVDqDU
G+F9dXgaakTAfIXm43C+N2ltZU/nbKF2XrX/cGFZZNjqxJZH2k7WF0gpyxzCHOQX
JSEqzgzyTDsAgfvPiDfy+y5VUSyky+my2eBFDHxt8+T6S+EWZsV3aTTrPyG7YycZ
n9cHNEfc4Hhl7gxvYgJXQR6QgoX3U7feJ9nqPqROsilPyrTUkkJa6i8VTSN9DCAN
5JCYLbkJRsWxQ0iQK3NDkRSHObqxaqywdMWIysZ2TUhnLhnG8Gs=
=96EW
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
