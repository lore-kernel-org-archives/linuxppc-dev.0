Return-Path: <B05799@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A3687B6EF6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Dec 2009 00:55:16 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.14.3/az33egw01) with ESMTP id
	nB9Dt8Ms024599 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 9 Dec 2009 06:55:08 -0700 (MST)
Received: from zin33exm22.fsl.freescale.net (zin33exm22.ap.freescale.net
	[10.232.192.20])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nB9DxHSL020721
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 9 Dec 2009 07:59:18 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] gianfar: Fix build with CONFIG_NET_POLL_CONTROLLER=y
Date: Wed, 9 Dec 2009 19:25:00 +0530
Message-ID: <9F4C7D19E8361D4C94921B95BE08B81BA08A9A@zin33exm22.fsl.freescale.net>
In-Reply-To: <20091209.025245.152622485.davem@davemloft.net>
References: <1260341804.16132.22.camel@pasglop><20091209104427.GA25526@oksana.dev.rtsoft.ru>
	<20091209.025245.152622485.davem@davemloft.net>
From: "Kumar Gopalpet-B05799" <B05799@freescale.com>
To: <avorontsov@ru.mvista.com>
Cc: David Miller <davem@davemloft.net>, linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
>From: Anton Vorontsov <avorontsov@ru.mvista.com>
>Date: Wed, 9 Dec 2009 13:44:27 +0300
>
>> commit 46ceb60ca80fa07703bc6eb8f4651f900dff5a82 ("gianfar: Add=20
>> Multiple group Support") introduced the following build error with=20
>> CONFIG_NET_POLL_CONTROLLER=3Dy:
> ...
>> This patch fixes the issue.
>>=20
>> Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>

Thanks Anton !
