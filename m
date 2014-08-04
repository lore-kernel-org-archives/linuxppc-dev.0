Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0139.outbound.protection.outlook.com [207.46.163.139])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1579F1A00C5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 07:53:11 +1000 (EST)
Message-ID: <1407189176.10311.12.camel@snotra.buserror.net>
Subject: Re: spi, spi_fsl-spi.c not working?
From: Scott Wood <scottwood@freescale.com>
To: <hs@denx.de>
Date: Mon, 4 Aug 2014 16:52:56 -0500
In-Reply-To: <53C79351.2080406@denx.de>
References: <53C79351.2080406@denx.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Andreas Larsson <andreas@gaisler.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Anton
 Vorontsov <avorontsov@ru.mvista.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-07-17 at 11:11 +0200, Heiko Schocher wrote:
> Hello all,
> 
> I just tried a mpc83xx based board (similiar to the mpc8313erdb)
> with linux v3.16-rc4 using the drivers/spi/spi-fsl-spi.c driver.
> DT nodes for spi are the same as in arch/powerpc/boot/dts/mpc8313erdb.dts:
> 
>                  spi@7000 {
>                          cell-index = <0>;
>                          compatible = "fsl,spi";
>                          reg = <0x7000 0x1000>;
>                          interrupts = <16 0x8>;
>                          interrupt-parent = <&ipic>;
>                          mode = "cpu";
>                  };
> 
> Bootlog shows:
> 
> [    1.341411] fsl_spi f0007000.spi: master is unqueued, this is deprecated
> [    1.554405] ------------[ cut here ]------------
> [    1.559080] WARNING: at c023a958 [verbose debug info unavailable]

If you haven't already resolved this, could you enable verbose debug
info (or use gdb) to get the line number?

I don't see the WARNING when booting mpc8379rdb with SPI enabled (though
I do see the "master is unqueued" message).  I don't have easy access to
an mpc8313erdb to test on.

-Scott
