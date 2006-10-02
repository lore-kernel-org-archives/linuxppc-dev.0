Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17696.59682.815576.910102@cargo.ozlabs.ibm.com>
Date: Mon, 2 Oct 2006 20:25:38 +1000
From: Paul Mackerras <paulus@samba.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 5/7] [POWERPC] Allow combined iSeries and MULTIPLATFORM
	build
In-Reply-To: <20060926133910.23948614.sfr@canb.auug.org.au>
References: <20060926133413.8ca8142e.sfr@canb.auug.org.au>
	<20060926133548.43afd711.sfr@canb.auug.org.au>
	<20060926133651.897ad602.sfr@canb.auug.org.au>
	<20060926133756.071a981f.sfr@canb.auug.org.au>
	<20060926133910.23948614.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell writes:

> -config PPC_MULTIPLATFORM
> -	bool "Generic desktop/server/laptop"
> -	help
> -	  Select this option if configuring for an IBM pSeries or
> -	  RS/6000 machine, an Apple machine, or a PReP, CHRP,
> -	  Maple or Cell-based machine.

What have you got against my powerbook? :P

With this patch, I only get the option of building an EMBEDDED6xx
kernel - PPC_MULTIPLATFORM has disappeared for 32-bit, and the 32-bit
powermac kernel build with it.

Paul.
