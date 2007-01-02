Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 78752DDE45
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 07:42:30 +1100 (EST)
Subject: Re: R_PPC_ADDR16_HI relocs in PPC modules ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Simon Vallet <linux-ppc@castalie.org>
In-Reply-To: <20070102172554.7a94cd37@mlejnas.priv.castalie.org>
References: <20070102172554.7a94cd37@mlejnas.priv.castalie.org>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 07:41:26 +1100
Message-Id: <1167770486.6165.70.camel@localhost.localdomain>
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

On Tue, 2007-01-02 at 17:25 +0100, Simon Vallet wrote:
> Hi,
> 
> I'm currently trying to port a binary-only driver to Linux/PPC using a
> MacOS X driver as a starting point. "Translating" this driver to ELF32
> gives an object that links into a .ko without too much problems.
> 
> However, trying to insmod the resulting object gives the following
> error message:
> 
> unknown ADD relocation: 5

We only add relocation to the kernel loader as we need them... since
this relocation has never been generated so far for in kernel modules it
wasn't added...

BTW. What is this evil^H^H^H^Hbinary driver you are talking about ?

Ben.
