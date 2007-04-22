Return-Path: <benh@kernel.crashing.org>
Subject: Re: RFC: powerpc: Start splitting up mmu.h by MMU type
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17961.19168.571692.127151@cargo.ozlabs.ibm.com>
References: <20070419065430.GA5862@localhost.localdomain>
	<17961.19168.571692.127151@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Sun, 22 Apr 2007 10:35:13 +1000
Message-Id: <1177202113.6080.28.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Specifically it splits the ppc64 specific (or more strictly, the
> > 64-bit hash table specific) parts of asm-powerpc/mmu.h into its own
> > file, asm-powerpc/mmu-hash64/mmu.h.  Similarly, PowerPC 44x
> > definitions are taken from asm-ppc/mmu.h, trimmed down for use in
> > arch/powerpc and place in their own file, asm-powerpc/mmu-44x/mmu.h.
> 
> Why do we want to create a directory per mmu type?  What other files
> would go in there?

Especially if we're ever going to get a different MMU type on 64 bits, I
would really like to try to be able to build a kernel supporting both
(if realistic).

Ben.
