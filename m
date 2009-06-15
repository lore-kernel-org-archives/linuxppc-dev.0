Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8CF57B718C
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 17:12:32 +1000 (EST)
Subject: Re: [PATCH 10/33] powerpc/cell: Extract duplicated IOPTE_* to
	<asm/iommu.h>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200906150905.30744.arnd@arndb.de>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-11-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1245030085.19217.5.camel@pasglop> <200906150905.30744.arnd@arndb.de>
Content-Type: text/plain
Date: Mon, 15 Jun 2009 17:12:22 +1000
Message-Id: <1245049942.19217.57.camel@pasglop>
Mime-Version: 1.0
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-06-15 at 09:05 +0200, Arnd Bergmann wrote:
> Good point, that file does not contain hardware specific definitions
> but
> only interfaces.
> 
> Geert, how about putting them into
> arch/powerpc/include/asm/cell-regs.h
> instead?

I've put the patch in powerpc-next for now. But you may want to send
another patch later on to move things.

Cheers,
Ben.
