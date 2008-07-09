Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id E3008DDEFB
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 10:53:20 +1000 (EST)
Date: Tue, 8 Jul 2008 20:53:15 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: rework 4xx PTE access and TLB miss
Message-ID: <20080708205315.4e463bdb@lappy.seanm.ca>
In-Reply-To: <20080708055449.EDFDADDEF5@ozlabs.org>
References: <20080708055449.EDFDADDEF5@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 08 Jul 2008 15:54:40 +1000
"Benjamin Herrenschmidt" <benh@kernel.crashing.org> wrote:

> This is some preliminary work to improve TLB management on SW loaded
> TLB powerpc platforms. This introduce support for non-atomic PTE
> operations in pgtable-ppc32.h and removes write back to the PTE from
> the TLB miss handlers. In addition, the DSI interrupt code no longer
> tries to fixup write permission, this is left to generic code, and
> _PAGE_HWWRITE is gone.

Ok, this version booted for me and passed some very rudimentary
regression tests.

Cheers,
   Sean
