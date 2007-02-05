Return-Path: <dgibson@ozlabs.org>
Date: Tue, 6 Feb 2007 10:56:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: Re: [PATCH] Missing ifndef __ASSEMBLY__ in include/asm-powerpc/dcr.h
Message-ID: <20070205235639.GB20123@localhost.localdomain>
References: <20070205193310.GA12412@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070205193310.GA12412@Krystal>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 05, 2007 at 02:33:10PM -0500, Mathieu Desnoyers wrote:
> Missing ifndef __ASSEMBLY__ in include/asm-powerpc/dcr.h
> 
> A missing structure forward declaration causes a lot of warnings when
> compiling for a powerpc 405. Because this header is used for assembly
> too, the declaration must be put within #ifndef __ASSEMBLY__, as should
> be the function prototypes.
> 
> This patch applies on 2.6.20.

This is the wrong fix.  The arch/powerpc version of dcr.h, unlike the
arch/ppc version, should never be included in assembler.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
