Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0110.outbound.protection.outlook.com [157.56.111.110])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E2B51A0AE6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Oct 2014 05:53:05 +1000 (EST)
Message-ID: <1412365973.13320.430.camel@snotra.buserror.net>
Subject: Re: Pull request: scottwood/linux.git next
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Date: Fri, 3 Oct 2014 14:52:53 -0500
In-Reply-To: <20140922222142.GA8525@home.buserror.net>
References: <20140922222142.GA8525@home.buserror.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-09-22 at 17:21 -0500, Scott Wood wrote:
> Highlights include DMA32 zone support (SATA, USB, etc now works on 64-bit
> FSL kernels), MSI changes, 8xx optimizations and cleanup, t104x board
> support, and PrPMC PCI enumeration.
> 
> The following changes since commit 78eb9094ca08a40b8f9d3e113a2b88e0b7dbad1d:
> 
>   powerpc/t2080rdb: Add T2080RDB board support (2014-07-31 00:11:10 -0500)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next
> 
> for you to fetch changes up to cb0446c1b625326682ec4f9d1dd10779433646bc:
> 
>   Revert "powerpc/fsl_msi: spread msi ints across different MSIRs" (2014-09-19 15:20:42 -0500)

ping

-Scott
