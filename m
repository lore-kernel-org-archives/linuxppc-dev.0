Return-Path: <SRS0=s+PL=G7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6841BC433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 20:10:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C09D64DF6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 20:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C09D64DF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kleine-koenig.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DRWmf6406zDrQg
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Jan 2021 07:10:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kleine-koenig.org (client-ip=94.130.110.236;
 helo=antares.kleine-koenig.org; envelope-from=uwe@kleine-koenig.org;
 receiver=<UNKNOWN>)
X-Greylist: delayed 80289 seconds by postgrey-1.36 at bilbo;
 Fri, 29 Jan 2021 07:08:54 AEDT
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org
 [94.130.110.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DRWkt6JjMzDrQg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2021 07:08:48 +1100 (AEDT)
Received: from antares.kleine-koenig.org (localhost [127.0.0.1])
 by antares.kleine-koenig.org (Postfix) with ESMTP id 2969DAE1E57;
 Thu, 28 Jan 2021 21:08:43 +0100 (CET)
Received: from antares.kleine-koenig.org ([94.130.110.236])
 by antares.kleine-koenig.org (antares.kleine-koenig.org [94.130.110.236])
 (amavisd-new, port 10024)
 with ESMTP id NYAo-JJQbWWS; Thu, 28 Jan 2021 21:08:40 +0100 (CET)
Received: from taurus.defre.kleine-koenig.org (unknown
 [IPv6:2a02:8071:b5ad:20fc:2b29:ca75:841e:b14c])
 by antares.kleine-koenig.org (Postfix) with ESMTPSA;
 Thu, 28 Jan 2021 21:08:40 +0100 (CET)
Subject: Re: [PATCH] vio: make remove callback return void
To: Sukadev Bhattiprolu <sukadev@linux.ibm.com>
References: <20210127215010.99954-1-uwe@kleine-koenig.org>
 <20210128190750.GA490196@us.ibm.com>
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Message-ID: <f3655d10-26ba-5f9f-761e-2f48d13d0b11@kleine-koenig.org>
Date: Thu, 28 Jan 2021 21:08:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210128190750.GA490196@us.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0WS2s8Dj7oAQDuvcAexs4Jz4r6U02PT15"
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
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>,
 Cristobal Forno <cforno12@linux.ibm.com>, sparclinux@vger.kernel.org,
 target-devel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 =?UTF-8?Q?Breno_Leit=c3=a3o?= <leitao@debian.org>,
 Peter Huewe <peterhuewe@gmx.de>, Jiri Slaby <jirislaby@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-scsi@vger.kernel.org,
 Nayna Jain <nayna@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Michael Cyr <mikecyr@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, "James E.J. Bottomley" <jejb@linux.ibm.com>,
 linux-block@vger.kernel.org, Lijun Pan <ljp@linux.ibm.com>,
 Matt Mackall <mpm@selenic.com>, Jens Axboe <axboe@kernel.dk>,
 Steven Royer <seroyer@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Jarkko Sakkinen <jarkko@kernel.org>, linux-crypto@vger.kernel.org,
 netdev@vger.kernel.org, Dany Madden <drt@linux.ibm.com>,
 Paulo Flabiano Smorigo <pfsmorigo@gmail.com>, linux-integrity@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0WS2s8Dj7oAQDuvcAexs4Jz4r6U02PT15
Content-Type: multipart/mixed; boundary="C8P4GGVXo3CFpsOyigcYdiPTK9L9mB3i8";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Sukadev Bhattiprolu <sukadev@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>,
 Jens Axboe <axboe@kernel.dk>, Matt Mackall <mpm@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Peter Huewe <peterhuewe@gmx.de>,
 Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Haren Myneni <haren@us.ibm.com>, =?UTF-8?Q?Breno_Leit=c3=a3o?=
 <leitao@debian.org>, Nayna Jain <nayna@linux.ibm.com>,
 Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
 Steven Royer <seroyer@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cristobal Forno <cforno12@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>,
 Dany Madden <drt@linux.ibm.com>, Lijun Pan <ljp@linux.ibm.com>,
 Tyrel Datwyler <tyreld@linux.ibm.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Michael Cyr <mikecyr@linux.ibm.com>, Jiri Slaby <jirislaby@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
 netdev@vger.kernel.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org
Message-ID: <f3655d10-26ba-5f9f-761e-2f48d13d0b11@kleine-koenig.org>
Subject: Re: [PATCH] vio: make remove callback return void
References: <20210127215010.99954-1-uwe@kleine-koenig.org>
 <20210128190750.GA490196@us.ibm.com>
In-Reply-To: <20210128190750.GA490196@us.ibm.com>

--C8P4GGVXo3CFpsOyigcYdiPTK9L9mB3i8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Sukadev,

On 1/28/21 8:07 PM, Sukadev Bhattiprolu wrote:
> Slightly off-topic, should ndo_stop() also return a void? Its return va=
lue
> seems to be mostly ignored and [...]

I don't know enough about the network stack to tell. Probably it's a=20
good idea to start a separate thread for this and address this to the=20
netdev list only.

Best regards
Uwe



--C8P4GGVXo3CFpsOyigcYdiPTK9L9mB3i8--

--0WS2s8Dj7oAQDuvcAexs4Jz4r6U02PT15
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmATGcQACgkQwfwUeK3K
7AljPggAhaj+JnoGN++1YO/4Nz81FEvRKFR9Eky+A4TCDGs8NvV1eVbhztqchotk
bm71ZlCLS23+/m5xoA/4bjOHPxc0ETs8V37z86n9Tcf/QTiwI1eN4UYU0l7cPqGO
cxuT/eLxm7WQ/kKwlJucUUHREWVCXH5NNTw4/zH9r+qc3MVQ++uUrKjtF94cnkGa
iOO8nW+fhP+e8bVENm+gcTwONaL45UG+qABpFj9mXiWMrA7L0kSEyqG4wUMgeKb3
YUtPKsAuS8xpUhT5C/zEQJ6qWI3rXkGCPEMUMcpWk+ut4McB9mE+TP6XWC36nfFy
uq8ofa7nTpO48ZQIj/PU3d+UIzp2eQ==
=XsiK
-----END PGP SIGNATURE-----

--0WS2s8Dj7oAQDuvcAexs4Jz4r6U02PT15--
