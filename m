Return-Path: <olh@suse.de>
Date: Thu, 11 Aug 2005 22:25:36 +0200
From: Olaf Hering <olh@suse.de>
To: Becky Bruce <becky.bruce@freescale.com>
Message-ID: <20050811202536.GA4220@suse.de>
References: <c237b7e878e0c32f421209fa37b7a156@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <c237b7e878e0c32f421209fa37b7a156@freescale.com>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: RFC: proposed arch/powerpc directory structure
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Wed, Aug 10, Becky Bruce wrote:

> 	boot/
> 		- Pre-kernel execution shims and pre-passes.
> 		- Convert firmware reprensentations (bi_recs, OF Dev-Trees,
> 		 bootx,bd_t) to flat-dev-trees.
> 		- Includes merged files from arch/ppc*/boot/ trees, plus
> 		prom_init.c from arch/ppc64/kernel.

This should live outside the kernel source, in a $mkzimage project.
