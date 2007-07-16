Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 18CF4DDE1B
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 08:12:21 +1000 (EST)
Subject: RE: [RFC][PATCH 6/8] Walnut DTS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA303067256@az33exm25.fsl.freescale.net>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
	<1184162389.32199.65.camel@weaponx.rchland.ibm.com>
	<4EAC985A-2F04-465D-AB69-C67807310D7B@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA3030669AF@az33exm25.fsl.freescale.net>
	<28A3F6B9-512B-4D86-8E0D-A7680CCE2354@kernel.crashing.org>
	<1184622446.25235.89.camel@localhost.localdomain>
	<9696D7A991D0824DBA8DFAC74A9C5FA303067256@az33exm25.fsl.freescale.net>
Content-Type: text/plain
Date: Tue, 17 Jul 2007 08:12:03 +1000
Message-Id: <1184623923.25235.98.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > I would personally be inclined to define that whatever spec we come up
> > with always require #address-cells/#size-cells for any node that can
> > have either device children or interrupt children, and ban default
> > values alltogether.
> 
> Did you really mean #size-cells here?  Shouldn't it be #interrupt-cells?

Yup, as I said, my fingers got a bit too fast on the keyboard. I means
#interrupt-cells.

Ben.
