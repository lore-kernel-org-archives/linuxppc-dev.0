Return-Path: <benh@kernel.crashing.org>
Subject: RE: [PATCH] powerpc: document new interrupt-array property
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A597F5@az33exm25.fsl.freescale.net>
References: <200702212325.l1LNPBwL007793@ld0164-tx32.am.freescale.net>
	<A31D7159-8C25-445D-A21D-85F04C1FDC45@kernel.crashing.org>
	<20070222011811.GA18364@localhost.localdomain>
	<45b623f395654fc4f4920b9553794def@kernel.crashing.org>
	<20070222103410.GB11014@localhost.localdomain>
	<b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A592C7@az33exm25.fsl.freescale.net>
	<259dc2545888e6588a8a0707ad2e84b0@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A59732@az33exm25.fsl.freescale.net>
	<1fb51bd63da9a7de836f3037908be52e@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A597F5@az33exm25.fsl.freescale.net>
Content-Type: text/plain
Date: Sat, 24 Feb 2007 07:42:09 +0100
Message-Id: <1172299329.1902.24.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Maybe:
>        interrupts        = < a 1 4   b 1 4   0 4   1 4   2 4 >
>        interrupt-parents = <&UIC0 &UIC0 &UIC1 &UIC1 &UIC1>
> 
> You don't know how many cells per interrupt until you traverse up to
> the interrupt parent.
> 
> I understand some properties only make sense together, but only
> can be parsed together seems ugly.

That's already the case with interrupt-map's anyway. I don't have a firm
preference between the options of interrupt-array and interrupt-parents,
they both have strenghts, though I tend to grow on segher's approach
here.

Ben.
