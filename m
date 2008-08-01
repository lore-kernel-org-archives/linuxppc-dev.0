Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 5D9A5DE121
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 01:41:09 +1000 (EST)
Date: Fri, 1 Aug 2008 11:41:07 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Adrian Bunk" <bunk@kernel.org>
Subject: Re: platforms/44x/warp-nand.c bogosity
Message-ID: <20080801114107.067904f8@lappy.seanm.ca>
In-Reply-To: <20080801151401.GC24735@cs181140183.pp.htv.fi>
References: <20080801151401.GC24735@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 1 Aug 2008 18:14:01 +0300
"Adrian Bunk" <bunk@kernel.org> wrote:

> arch/powerpc/platforms/44x/warp-nand.c was added this year and
> updated quite recently.
> 
> warp-nand.c is empty unless CONFIG_MTD_NAND_NDFC=y.
> 
> MTD_NAND_NDFC depends on !PPC_MERGE.
> 
> !PPC_MERGE can never be true on PPC now that arch/ppc/ got removed.
> 
> So warp-nand.c is dead code, but that does not seem to be
> intentionally?

I use a local copy of ndfc.c that was modified to work with
arch/powerpc. I submitted the patch, but it was never accepted into the
kernel, and to be honest I don't remember why. I will look into this.

So the code is definitely not dead. You can't realistically run a warp
without the NAND.

Cheers,
   Sean
