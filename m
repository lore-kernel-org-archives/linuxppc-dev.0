Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DA2A2DDFC4
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 02:41:08 +1100 (EST)
Message-ID: <49413487.9030805@freescale.com>
Date: Thu, 11 Dec 2008 09:40:55 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Mark Brown <broonie@sirena.org.uk>
Subject: Re: MPC8610HPCD sound as module
References: <49411308.1050008@fang.fa.gau.hu>
	<ed82fe3e0812110712r4baeea60ied52937aa434f48e@mail.gmail.com>
	<20081211153158.GF30808@sirena.org.uk>
In-Reply-To: <20081211153158.GF30808@sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark Brown wrote:

> ASoC v1 supports loading drivers as modules (and this is fairly heavily
> used), though as you say the MPC8610 drivers don't support that.

Well, at the time I wrote the drivers, I didn't see an easy way to support
modules, since V1 drivers typically have lots of hard-coded references to global
 variables in other files.

-- 
Timur Tabi
Linux kernel developer at Freescale
