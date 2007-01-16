Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 20074DDFA7
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 08:57:55 +1100 (EST)
Subject: RE: [patch][5/5] powerpc: Add the general support for Embedded
	Floating-Point instructions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zhu Ebony-r57400 <ebony.zhu@freescale.com>
In-Reply-To: <32F3CC26D4DAC44E8ECD07155727A46E816D7C@zch01exm20.fsl.freescale.net>
References: <32F3CC26D4DAC44E8ECD07155727A46E816D7C@zch01exm20.fsl.freescale.net>
Content-Type: text/plain
Date: Wed, 17 Jan 2007 08:54:43 +1100
Message-Id: <1168984483.4803.75.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Do you think using SRR0 is safer since it contains the exact effective address
> of the instruction causing the interrupt?

The problem is reading the instruction itself

Ben.
