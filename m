Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17651.50176.455224.734372@cargo.ozlabs.ibm.com>
Date: Tue, 29 Aug 2006 14:35:12 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kallol Biswas <Kallol_Biswas@pmc-sierra.com>
Subject: Re: PPC 2.6.11.4 kernel panics while doing insmod (store fault with d
	cbst in icache_flush_range)
In-Reply-To: <478F19F21671F04298A2116393EEC3D5540A32@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
References: <478F19F21671F04298A2116393EEC3D5540A32@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
Cc: Ronald Lee <Ronald_Lee@pmc-sierra.com>, linuxppc-dev@ozlabs.org,
	Radjendirane Codandaramane <Radjendirane_Codandaramane@pmc-sierra.com>,
	Shawn Jin <Shawn_Jin@pmc-sierra.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kallol Biswas writes:

>         mr      r6,r3
> 1:      dcbst   0,r3
>         addi    r3,r3,L1_CACHE_LINE_SIZE
>         bdnz    1b
> 
> The instruction takes a store fault (DST bit, bit 8 of ESR gets
> set), kernel panics with oops (signal 11).

What processor are you using?

Which instruction takes a store fault?

Paul.
