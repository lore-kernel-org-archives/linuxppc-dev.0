Return-Path: <Kallol_Biswas@pmc-sierra.com>
Received: from father.pmc-sierra.bc.ca (father.pmc-sierra.com [216.241.224.13])
	by ozlabs.org (Postfix) with SMTP id F22A767A3D
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 14:59:57 +1000 (EST)
Message-ID: <478F19F21671F04298A2116393EEC3D50196DA@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
From: Kallol Biswas <Kallol_Biswas@pmc-sierra.com>
To: "'Paul Mackerras'" <paulus@samba.org>
Subject: RE: PPC 2.6.11.4 kernel panics while doing insmod (store fault wi
	th d cbst in icache_flush_range)
Date: Mon, 28 Aug 2006 21:59:51 -0700
MIME-Version: 1.0
Content-Type: text/plain
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

Processor: PPC440
Dcbst takes the store fault.

-----Original Message-----
From: Paul Mackerras [mailto:paulus@samba.org] 
Sent: Monday, August 28, 2006 9:35 PM
To: Kallol Biswas
Cc: linux-kernel@vger.kernel.org; linuxppc-dev@ozlabs.org; Ronald Lee; Radjendirane Codandaramane; Shawn Jin
Subject: Re: PPC 2.6.11.4 kernel panics while doing insmod (store fault with d cbst in icache_flush_range)

Kallol Biswas writes:

>         mr      r6,r3
> 1:      dcbst   0,r3
>         addi    r3,r3,L1_CACHE_LINE_SIZE
>         bdnz    1b
> 
> The instruction takes a store fault (DST bit, bit 8 of ESR gets set), 
> kernel panics with oops (signal 11).

What processor are you using?

Which instruction takes a store fault?

Paul.
