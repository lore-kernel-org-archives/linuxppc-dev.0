Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B1FB6B70A6
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Oct 2010 17:14:15 +1100 (EST)
Subject: Re: [PATCH v3 6/7] mtd: m25p80: add a read function to read page by
	page
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <73839B4A0818E747864426270AC332C3057F6138@zmy16exm20.fsl.freescale.net>
Date: Fri, 8 Oct 2010 01:11:49 -0500
Message-Id: <5FE2FD44-A491-4E7C-86E9-5247B9598AD2@kernel.crashing.org>
References: <841976.76219.qm@web180306.mail.gq1.yahoo.com>
	<AANLkTinBDdEyMDt3KoauNdmTCz1ZAJ5mZ23iMWiwsUm4@mail.gmail.com>
	<AANLkTi=GydTyhf3TOzCZOtrme1Jh0UmNDHqTVP59q=LH@mail.gmail.com>
	<20100930150633.GA13741@oksana.dev.rtsoft.ru>
	<73839B4A0818E747864426270AC332C3057F6138@zmy16exm20.fsl.freescale.net>
To: Hu Mingkai-B21284 <B21284@freescale.com>
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, spi-devel-general@lists.sourceforge.net,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 7, 2010, at 9:15 PM, Hu Mingkai-B21284 wrote:

>>>> Yes, I agree with David on this.  If large transfers don't work,
>>>> then it is the SPI master driver that is buggy.
>>>=20
>>> By the way, does this fix your problem?
>>>=20
>>> https://patchwork.kernel.org/patch/184752/
>>=20
>> It shouldn't. AFAIK, eSPI is PIO-only controller, and the overrun fix =
is for the
>> DMA mode.
>>=20
>> Thanks,
>>=20
>> p.s. Btw, in patch 3/7, is_dma_mapped argument of fsl_espi_bufs() is =
unneeded.
>>=20
>=20
> Yes, the is_dma_mapped isn't needed, I'll remove it.
>=20
> Thanks,
> Mingkai

I'd be really nice if we could close on this patchset in time for .37 =
acceptance.  I'm guessing that cutoff is quickly approaching.

- k=
