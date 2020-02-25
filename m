Return-Path: <SRS0=ugyh=4N=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A97C35E04
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Feb 2020 19:09:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29C6B2082F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Feb 2020 19:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C6B2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48RpPk5vnfzDqft
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Feb 2020 06:08:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=the-dreams.de (client-ip=88.99.104.3; helo=pokefinder.org;
 envelope-from=wsa@the-dreams.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=the-dreams.de
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 48Rnhl4rmVzDqPc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2020 05:36:55 +1100 (AEDT)
Received: from localhost (p5486CE6D.dip0.t-ipconnect.de [84.134.206.109])
 by pokefinder.org (Postfix) with ESMTPSA id D70102C1F2F;
 Tue, 25 Feb 2020 16:00:50 +0100 (CET)
Date: Tue, 25 Feb 2020 16:00:50 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH] macintosh: therm_windtunnel: fix regression when
 instantiating devices
Message-ID: <20200225150050.GI3677@ninjato>
References: <20200225141229.5424-1-wsa@the-dreams.de>
 <0fe4740a-f331-f885-c60a-6735c4c8e1fa@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VkVuOCYP9O7H3CXI"
Content-Disposition: inline
In-Reply-To: <0fe4740a-f331-f885-c60a-6735c4c8e1fa@physik.fu-berlin.de>
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
Cc: Erhard Furtner <erhard_f@mailbox.org>, Mathieu Malaterre <malat@debian.org>,
 debian-powerpc@lists.debian.org, linux-i2c@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--VkVuOCYP9O7H3CXI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2020 at 03:41:22PM +0100, John Paul Adrian Glaubitz wrote:
> Hello!
>=20
> On 2/25/20 3:12 PM, Wolfram Sang wrote:
> > Adding the Debian-PPC List to reach further people maybe willing to
> > test.
>=20
> This might be related [1].

IIUC, this is the same as
https://bugzilla.kernel.org/show_bug.cgi?id=3D199471.

I don't think my patch helps here.


--VkVuOCYP9O7H3CXI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl5VNqIACgkQFA3kzBSg
KbaUZg//cUU9Y+K3KAVvbmdV7d0beRntW+8rVa8q2Xxx30zgb36ZYqVIkHVqQQdz
fhc7oMCuQnnnaJfW6SesxmRguKfNXKEuoEe3U42CN1fMKJVRrN7icuy/x6gpaAfq
XAbpfiNJiHmhQGYlvxqMMmxNtcQC7/cN3ikEiz5jOULc8FbTD47CzvGwNpLTJ2vF
TwgfbibPJlzquHoYXt87KyeN5GhaTvdm2fLMmn+bpshKUKaaw7ctAE/5N/MtC+g/
tmXj5rGrOhPxUbCyAXxJpmK5QIbYy96UrD+sApLodBmI2y/y+rixOL6uetGOzga+
3w+SEozOLC0B7SUbVVRjAm6shi4OKemuvSSnkouf+/w3VL+ww5v1irpUwH3C+U1p
BG/6oMsBcQr2O8W+Ij96UIr2bPw7N0oQhZo0K3ORjp1g1YEsaCLKIi5C8QVb0H4S
3b0Xj48rkxYHhrVjNu7xfAWgNV0szbmvzzcZpd18mpREO2gC3spCyVfodJg1Yezv
7jKNO6+hke84MHX/Y1jKbTABMm9/NX7FCQFoGxASfCW2rVP0cmJtMAWHPhoQtCuL
nVjTo0d5T34BTJEJXh62zMGyqYaL7JHdfU5r35qXTdxr5AFW4WCd7k3Y9W/cJSdW
+CzcDbDNsCCe06elJOpPj96NktLX3d8OYiuic6LkLBlfHArV2WM=
=Tt5A
-----END PGP SIGNATURE-----

--VkVuOCYP9O7H3CXI--
