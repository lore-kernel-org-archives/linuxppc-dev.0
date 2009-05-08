Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1E2C3DDF95
	for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2009 00:20:58 +1000 (EST)
Message-Id: <059F23E3-64CF-4F9A-B35F-D271A666AFC2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090502021659.GF18281@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 6/6] powerpc/85xx: Add STMicro M25P40 serial flash support
	for MPC8569E-MDS
Date: Fri, 8 May 2009 09:13:51 -0500
References: <20090502021611.GA17570@oksana.dev.rtsoft.ru>
	<20090502021659.GF18281@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 1, 2009, at 9:16 PM, Anton Vorontsov wrote:

> For serial flash support we need to:
>
> - Add QE Par IO Bank E device tree node, a GPIO from this bank is
>  used for SPI chip-select line;
> - Add serial-flash node;
> - Add proper module alias into of/base.c.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8569mds.dts |   26 +++++++++++++++++++++++---
> drivers/of/base.c                    |    1 +
> 2 files changed, 24 insertions(+), 3 deletions(-)

applied to next

- k
