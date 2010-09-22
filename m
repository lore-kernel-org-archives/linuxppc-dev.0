Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A7EBEB70F1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Sep 2010 15:41:59 +1000 (EST)
Subject: Re: [PATCH] fsldma: add support to 36-bit physical address
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <AANLkTinbjb+uQdby999rs1eF1sqPHY2vXJ1mVrznFv=0@mail.gmail.com>
Date: Wed, 22 Sep 2010 00:41:43 -0500
Message-Id: <492E9153-2D3E-4DA2-AD04-4F92C94DB3A7@kernel.crashing.org>
References: <1285066638-7473-1-git-send-email-leoli@freescale.com>
	<877FD0B5-19A7-4A16-831E-369B80B104EA@kernel.crashing.org>
	<AANLkTimiwtoa6i10OTcgFnvbvcO9N4KWHyt4Poj-yj=T@mail.gmail.com>
	<20100921163456.7e2c9b32@udp111988uds.am.freescale.net>
	<AANLkTine--kry0c0n87WOqYyi3AQOb2KnmNRs-MeXcQt@mail.gmail.com>
	<20100921164944.164ed0af@udp111988uds.am.freescale.net>
	<2C3F2C02-35B6-46AF-82DA-44ACCBFB8362@digitaldans.com>
	<AANLkTinKbBBbC1gmPewhn1f3MW-1MbARtiQZNX4w7Mi+@mail.gmail.com>
	<20100921171746.381f2e89@udp111988uds.am.freescale.net>
	<AANLkTinbjb+uQdby999rs1eF1sqPHY2vXJ1mVrznFv=0@mail.gmail.com>
To: Timur Tabi <timur.tabi@gmail.com>
Cc: "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
	Scott Wood <scottwood@freescale.com>, Dan Malek <ppc6dev@digitaldans.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Dan Williams <dan.j.williams@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 21, 2010, at 5:34 PM, Timur Tabi wrote:

> On Tue, Sep 21, 2010 at 5:17 PM, Scott Wood <scottwood@freescale.com> =
wrote:
>=20
>> It needs to be the actual device that is performing the DMA -- the
>> platform may need to do things such as IOMMU manipulation where
>> knowing the device matters.
>=20
> Ok, this all makes sense.  So it appears that the patch is valid, at
> least in theory.  I would like to see some testing of it, but I
> realize that may be too difficult.  There's no easy way to force an
> allocation above 4GB.

I think the patch is pretty safe w/o testing.  However I agree we need a =
better solution to testing 36-bit addressing.

- k=
