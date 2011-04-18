Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 12/15] powerpc/book3e: Use way 3 for linear mapping
	bolted entry
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <7086A97F-A6A6-4D25-9FA7-20959C74E440@kernel.crashing.org>
References: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
	<bbe411555c95e56ba427ebf638d5333b1870af77.1302856271.git.michael@ellerman.id.au>
	<FE1E8891-E134-4559-9F26-BAFC36B258AC@kernel.crashing.org>
	<1303162834.28876.163.camel@pasglop>
	<7086A97F-A6A6-4D25-9FA7-20959C74E440@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Apr 2011 08:44:21 +1000
Message-ID: <1303166661.28876.165.camel@pasglop>
Mime-Version: 1.0
Cc: Michael Ellerman <michael@ozlabs.org>, Jimi Xenidis <jimix@watson.ibm.com>,
	jack@codezen.org, imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> >> Seems like this should have a MMU Feature bit or something for A2.
> > 
> > Too early. We haven't detected the CPU and are establishing the initial
> > TLB entry here.
> 
> How about wrapping with CONFIG_PPC_A2

YUCK :-)

> > Any reason why that wouldn't work on something else anyways ?
> 
> No, I wasn't paying attention to what this code exactly was (not enough
> context in the diff), I see its our initial setup so not a big deal.
>   Was thinking this was run-time exception handler code.

No, it's the boot time bolted entry.

Cheers,
Ben.
