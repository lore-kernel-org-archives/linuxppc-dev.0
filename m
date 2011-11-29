Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1CCE7B6F7B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 03:38:27 +1100 (EST)
Subject: Re: [PATCH 2/6] powerpc/85xx: consolidate of_platform_bus_probe calls
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4ED50633.4020506@freescale.com>
Date: Tue, 29 Nov 2011 10:38:18 -0600
Message-Id: <2C30517A-CF00-455A-ABE4-CA92A8856C70@kernel.crashing.org>
References: <1321552581-29773-1-git-send-email-dbaryshkov@gmail.com>
 <1321552581-29773-2-git-send-email-dbaryshkov@gmail.com>
 <CAOZdJXXZG38v-tgA2Ty7-uxJ3AxoFCmNxMO3dKJnJYQtJFb9DA@mail.gmail.com>
 <38BAFE03-DB17-4442-8CC2-E386E46FEB19@kernel.crashing.org>
 <4ED5058F.90004@freescale.com> <4ED50633.4020506@freescale.com>
To: Timur Tabi <timur@freescale.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 29, 2011, at 10:20 AM, Timur Tabi wrote:

> Timur Tabi wrote:
>=20
>> If I move the "fsl,eloplus-dma" into mpc85xx_common_ids[], then =
everything works.
>>=20
>> I suspect there's some kind of state machine in =
of_platform_bus_probe() that allows it to find the DMA channel nodes if =
it's scanned everything else first.  I'm trying to debug it now.
>=20
> So why do we need mpc85xx_common_ids[] at all?  Why can't =
of_platform_bus_probe() just scan the entire tree?

Ben would probably have to answer that.  I can't remember why he wanted =
it.  I'm sure he has a good reason.

- k=
