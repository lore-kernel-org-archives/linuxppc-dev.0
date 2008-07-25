Return-Path: <jochen@scram.de>
Message-ID: <4889942C.4040800@scram.de>
Date: Fri, 25 Jul 2008 10:51:56 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
References: <488982B5.4070102@grandegger.com>
In-Reply-To: <488982B5.4070102@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Wolfgang,

> The I2C driver for the MPC currently uses a fixed speed hard-coded into
> the driver. This patch adds the FDT properties "fdr" and "dfsrr" for the
> corresponding I2C registers to make the speed configurable via FDT, 
> e.g.:
> 
>     i2c@3100 {
>         compatible = "fsl-i2c";
>         reg = <0x3100 0x100>;
>         interrupts = <43 2>;
>         interrupt-parent = <&mpic>;
>         dfsrr = <0x20>;
>         fdr = <0x03>;
>     };


Would it be possible to use the standard property "clock-frequency" for this
and calculate the register settings in the driver?

Thanks,
Jochen
