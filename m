Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0577EDDEC2
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 00:22:20 +1000 (EST)
Message-ID: <46CC4694.4000503@freescale.com>
Date: Wed, 22 Aug 2007 09:22:12 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Patches added to powerpc.git for-2.6.24 branch
References: <18124.1591.112487.322248@cargo.ozlabs.ibm.com>
	<46CC2FB3.4000200@freescale.com>
	<C3CB0CDB-AA2B-4D24-AEA6-1A7305B5B311@kernel.crashing.org>
In-Reply-To: <C3CB0CDB-AA2B-4D24-AEA6-1A7305B5B311@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> I think the clrsetbits macros needs some further cleanup.  I think 
> Stephen mentioned doing something like we do for DEF_MMIO_OUT_BE() to 
> only have one 'actual' macro.

Yeah I saw that one, but on IRC a few people said they don't like ##, so I 
decided against it.  Are you saying I should change it anyway?

> The immap_86xx.h will go through me since its FSL code.

I was thinking some more about that file this morning.  If you want, I can 
rename it to guts.h since it only has one structure in it, and then also 
update a few other files that use the global utilities registers to use that 
structure instead of using macros.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
