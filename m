Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C73A5DDE34
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 14:25:35 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB73PVMk028379
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 22:25:31 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB73PVK6426232
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 22:25:31 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB73PVOn024140
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 22:25:31 -0500
Date: Thu, 6 Dec 2007 21:22:35 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 21/25] powerpc: Adds decoding of 440SPE memory size to
	boot wrapper library
Message-ID: <20071206212235.4ff38139@zod.rchland.ibm.com>
In-Reply-To: <20071206080132.0CCE9DE109@ozlabs.org>
References: <1196927999.714593.205329520306.qpush@grosgo>
	<20071206080132.0CCE9DE109@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 06 Dec 2007 19:00:20 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> This adds a function to the bootwrapper 4xx library to decode memory
> size on 440SPE processors.

Why did you rename the fixup_memsize function?  Could you add that to
the changelog, and perhaps a bit about adding the SDRAM0_{READ,WRITE}
macros.

josh
