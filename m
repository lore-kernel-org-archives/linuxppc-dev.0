Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5075267A3A
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 17:22:10 +1000 (EST)
Subject: RE: [PATCH] Directly reference i8259@4d0 nodes in mpc8641_hpcn.dts.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
In-Reply-To: <2176B872C0407E44887F07CCAA8692930F6005@zch01exm21.fsl.freescale.net>
References: <2176B872C0407E44887F07CCAA8692930F6005@zch01exm21.fsl.freescale.net>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 17:21:45 +1000
Message-Id: <1155885706.5803.35.camel@localhost.localdomain>
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

On Fri, 2006-08-18 at 13:54 +0800, Zhang Wei-r63237 wrote:
> Is it a good idea? Why we can not endure the "linux,phandle = <4d0>" in
> i8259 node? And besides, this node was already referenced by the other
> entries.

Because magic numbers are evil and nice names are better ? :)

> Using "&/soc8641@f8000000/pci@8000/i8259@4d0" or label seems so verbose
> and weird.
