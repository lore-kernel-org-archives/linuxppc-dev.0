Return-Path: <muli@il.ibm.com>
Date: Mon, 17 Jul 2006 09:31:49 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH] powerpc: simplify dma_ops bug conditions
Message-ID: <20060717063149.GB18291@rhun.ibm.com>
References: <20060713063252.1D35867B58@ozlabs.org>
	<20060713063947.GD5096@rhun.ibm.com>
	<200607171355.10077.jk@ozlabs.org>
	<20060717062825.GA18291@rhun.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060717062825.GA18291@rhun.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 17, 2006 at 01:55:09PM +1000, Jeremy Kerr wrote:

> No, it's not really necessary, more a style thing. The BUG_ON only adds 
> an extra 3 instructions (subfic, addi and tdnei), which should be tiny 
> compared to the indirect branch.

When we were submitting a patch to add a
BUG_ON(!valid_dma_data_direction(dir)) to x86-64's DMA-API, Jeff
Garzik was vehemently opposed to adding a few instructions to "one of
the hottest paths in the kernel".

Cheers,
Muli
