Return-Path: <gear@hyper.cx>
Received: from mail2.zenno.net (mail2.zenno.net [60.32.180.90])
	by ozlabs.org (Postfix) with SMTP id D034BDE07A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Jan 2007 15:16:20 +1100 (EST)
Date: Thu, 25 Jan 2007 13:11:45 +0900
From: gear <gear@hyper.cx>
To: "Li Yang-r58472" <LeoLi@freescale.com>
Subject: Re: MPC8260 I2C Problem
In-Reply-To: <989B956029373F45A0B8AF029708189008734F@zch01exm26.fsl.freescale.net>
References: <78452.12201.qm@web53101.mail.yahoo.com>
	<989B956029373F45A0B8AF029708189008734F@zch01exm26.fsl.freescale.net>
Message-Id: <20070125130251.BB50.GEAR@hyper.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: jimmy liu <jimmyzhmliu@yahoo.com>,
	embedded linuxppc <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi Leo

You must check the platform bus.
My MPC8270 board's tree is follow.

MPC8270:/sys/bus/platform# tree .
=2E
|-- devices
|   |-- fsl-cpm-fcc.1 -> ../../../devices/platform/fsl-cpm-fcc.1
|   |-- fsl-cpm-fcc.2 -> ../../../devices/platform/fsl-cpm-fcc.2
|   |-- fsl-cpm-fcc.3 -> ../../../devices/platform/fsl-cpm-fcc.3
|   |-- fsl-cpm-i2c.1 -> ../../../devices/platform/fsl-cpm-i2c.1
|   |-- fsl-cpm-mcc.1 -> ../../../devices/platform/fsl-cpm-mcc.1
|   |-- fsl-cpm-scc.1 -> ../../../devices/platform/fsl-cpm-scc.1
|   |-- fsl-cpm-scc.2 -> ../../../devices/platform/fsl-cpm-scc.2
|   |-- fsl-cpm-scc.3 -> ../../../devices/platform/fsl-cpm-scc.3
|   |-- fsl-cpm-scc.4 -> ../../../devices/platform/fsl-cpm-scc.4
|   |-- fsl-cpm-smc.1 -> ../../../devices/platform/fsl-cpm-smc.1
|   |-- fsl-cpm-smc.2 -> ../../../devices/platform/fsl-cpm-smc.2
|   |-- fsl-cpm-spi.1 -> ../../../devices/platform/fsl-cpm-spi.1

- hirohata
