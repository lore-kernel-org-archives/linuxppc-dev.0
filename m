Return-Path: <horms@koto.vergenet.net>
Received: from koto.vergenet.net (koto.vergenet.net [210.128.90.7])
	by ozlabs.org (Postfix) with ESMTP id 04921DDF0D
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 13:57:26 +1000 (EST)
Date: Thu, 12 Apr 2007 12:57:21 +0900
From: Simon Horman <horms@verge.net.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [Fastboot] [PATCH kexec-tools] ppc64: correct @ha relocation
Message-ID: <20070412035719.GB5184@verge.net.au>
References: <boot-4-00.miltonm@bga.com> <boot-4-kexec-02.miltonm@bga.com>
	<20070412032446.GA5184@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070412032446.GA5184@verge.net.au>
Cc: linuxppc-dev@ozlabs.org, fastboot@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 12, 2007 at 12:24:47PM +0900, Simon Horman wrote:
> On Wed, Apr 11, 2007 at 03:30:00AM -0500, Milton Miller wrote:
> > 
> > The @ha relocation is supposed to account for the @l relocation being
> > a signed quantity by adding 1 if the msb of @l is set.
> > 
> > The trick of adding 0x8000 stolen from the linux kernel file
> > arch/powerpc/kernel/module_64.c which credits binutils.
> 
> This and the following patch seem fine to me.
> But I would appreciate a review from someone 
> a little more ppc savy than I.

Sorry, I should have been a little clearer. 
I was refering to the two kexec-tools patches only.
I'm just getting to the kernel ones.

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/
