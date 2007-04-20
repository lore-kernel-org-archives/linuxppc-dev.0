Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17961.19168.571692.127151@cargo.ozlabs.ibm.com>
Date: Sat, 21 Apr 2007 09:21:04 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: RFC: powerpc: Start splitting up mmu.h by MMU type
In-Reply-To: <20070419065430.GA5862@localhost.localdomain>
References: <20070419065430.GA5862@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson writes:

> This patch makes a start to sorting out the tangled mess of MMU
> related header files in asm-powerpc, and weaning arch/powerpc off the
> remaining asm-ppc headers it uses.

Good...

> Specifically it splits the ppc64 specific (or more strictly, the
> 64-bit hash table specific) parts of asm-powerpc/mmu.h into its own
> file, asm-powerpc/mmu-hash64/mmu.h.  Similarly, PowerPC 44x
> definitions are taken from asm-ppc/mmu.h, trimmed down for use in
> arch/powerpc and place in their own file, asm-powerpc/mmu-44x/mmu.h.

Why do we want to create a directory per mmu type?  What other files
would go in there?

Paul.
