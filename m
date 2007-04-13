Return-Path: <horms@koto.vergenet.net>
Received: from koto.vergenet.net (koto.vergenet.net [210.128.90.7])
	by ozlabs.org (Postfix) with ESMTP id C2D82DDF1C
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 11:38:35 +1000 (EST)
Date: Fri, 13 Apr 2007 10:34:20 +0900
From: Simon Horman <horms@verge.net.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH kexec-tools] ppc64: use kernels slave loop for purgatory
Message-ID: <20070413013418.GB24097@verge.net.au>
References: <boot-4-00.miltonm@bga.com> <boot-4-kexec-03.miltonm@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <boot-4-kexec-03.miltonm@bga.com>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, fastboot@lists.osdl.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 11, 2007 at 03:30:38AM -0500, Milton Miller wrote:
> 
> Purgatory doesn't really care about the SMP cpus.  But if we leave them
> behind, they end up getting lost when the kernel overwrites purgatory or
> the previous kernel.  The current slave handling in purgatory doesn't
> have any handshaking to make sure the cpus have moved on before leaving.
> 
> Instead of moving the slave cpus up to purgatory and then back down to
> the kernel, just copy bytes 4-255 from the kernel and use it as the
> purgatory start / slave hold block.
> 
> 
> Signed-off-by: Milton Miller <miltonm@bga.com>

Thanks, applied.

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/
