Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE4EC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 12:26:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15E482084D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 12:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E482084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RTX063HPzF3RF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 22:26:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=the-dreams.de
 (client-ip=88.99.104.3; helo=pokefinder.org; envelope-from=wsa@the-dreams.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=the-dreams.de
X-Greylist: delayed 549 seconds by postgrey-1.36 at bilbo;
 Fri, 05 Oct 2018 22:24:32 AEST
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 42RTTX30NdzF3R0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 22:24:32 +1000 (AEST)
Received: from localhost (p54B3360B.dip0.t-ipconnect.de [84.179.54.11])
 by pokefinder.org (Postfix) with ESMTPSA id AE5602C7EC3;
 Fri,  5 Oct 2018 14:15:19 +0200 (CEST)
Date: Fri, 5 Oct 2018 14:15:19 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] i2c: Convert to using %pOFn instead of device_node.name
Message-ID: <20181005121519.GF5433@kunai>
References: <20180928224947.19058-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/aVve/J9H4Wl5yVO"
Content-Disposition: inline
In-Reply-To: <20180928224947.19058-1-robh@kernel.org>
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
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Peter Rosin <peda@axentia.se>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 28, 2018 at 05:49:47PM -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>=20
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: linux-i2c@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to for-next (with Peter's tag from v1), thanks!


--/aVve/J9H4Wl5yVO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu3Vc8ACgkQFA3kzBSg
KbZbGA//TSsle8Y0hbsCLheqkV1zbEMBpC5F5/eaqcwxg20jF/6pD+9q5L2xPbCW
PcaAC9SB5ftn/C9gJKk6wB5jKxoDU57rczj0csUN/tb0b066FkJVqx08vPQtNbXZ
X9fr/rhwr/K88d384wFxailAR41r88BmIJoaNYmcbUcsBBYQC3USOQKmzd0lup+i
1MeKAanXqQnCeEXJkf3in1u/dLEI+yI1e6/EEzo/glFw1l8tBFQJ4D6/VAnSX2He
SfL4LRkJkw06PKRWuRMvox2nNuT6rUVqa81qlNLhrrfE/VzRAM9I5U6l5LbgZYdg
LSzLPQNOyuLBkdxsxNjpoEV4HHvtM4ultHy+SBQzevJ9BsiZ78FyxugB4hg+1hxf
qHlHAT1gCvzNfvGHPekYbP7c0iDa2N9JlznW5oNmT4tNt/gNAUGJr6rr64FO2rVI
DIaYKIScjKAMAIixr3fIDr5sxmaxb8ewdva9Jro23QnNUjOAuVSwzmlZBa16Nn48
t02PycWUlhXp4y3KFXVdPHZjXpcQCf2UaF6nkVXuZ9U9KRRo8C9mc/Q96XErM7vl
oFxuZpWaiBXTWQzp3lER7aFY5AI91MxdlkcPVklq/9J5W/HXuJBSe+sOUi5DxH6d
74p4Ki5FzP7HguGw+x5EcuIvKUPkr3RvBI5DNIOh7SVMuBhUvN4=
=tLIh
-----END PGP SIGNATURE-----

--/aVve/J9H4Wl5yVO--
