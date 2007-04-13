Return-Path: <horms@koto.vergenet.net>
Received: from koto.vergenet.net (koto.vergenet.net [210.128.90.7])
	by ozlabs.org (Postfix) with ESMTP id A0D70DDF1C
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 11:38:34 +1000 (EST)
Date: Fri, 13 Apr 2007 10:35:01 +0900
From: Simon Horman <horms@verge.net.au>
To: Mohan Kumar M <mohan@in.ibm.com>
Subject: Re: [PATCH kexec-tools] ppc64: correct @ha relocation
Message-ID: <20070413013459.GC24097@verge.net.au>
References: <boot-4-00.miltonm@bga.com> <boot-4-kexec-02.miltonm@bga.com>
	<20070412081716.GE4281@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070412081716.GE4281@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Vivek Goyal <vgoyal@in.ibm.com>,
	fastboot@lists.osdl.org, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 12, 2007 at 01:47:16PM +0530, Mohan Kumar M wrote:
> On Wed, Apr 11, 2007 at 03:30:00AM -0500, Milton Miller wrote:
> > 
> > The @ha relocation is supposed to account for the @l relocation being
> > a signed quantity by adding 1 if the msb of @l is set.
> > 
> > The trick of adding 0x8000 stolen from the linux kernel file
> > arch/powerpc/kernel/module_64.c which credits binutils.
> > 
> > Signed-off-by: Milton Miller <miltonm@bga.com>
> >
> Acked-by: Mohan Kumar M <mohan@in.ibm.com>
> 
> 
> Cross checked with PPC64 ELF ABI also.

Thanks Milton. Thanks Mohan. I've applied this to kexec-tools-testing.

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/
