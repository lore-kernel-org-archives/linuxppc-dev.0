Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (unknown [IPv6:2406:a000:f000:9500::1])
	by ozlabs.org (Postfix) with ESMTP id E6DC8B6F90
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jun 2011 10:42:00 +1000 (EST)
Date: Thu, 16 Jun 2011 09:12:45 +0900
From: Simon Horman <horms@verge.net.au>
To: Suzuki Poulose <suzuki@in.ibm.com>
Subject: Re: [RFC][PATCH] kexec-tools: powerpc: Use the #address-cells
	information to parsememory/reg - V2
Message-ID: <20110616001244.GJ28947@verge.net.au>
References: <4DEF18FF.6070206@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4DEF18FF.6070206@in.ibm.com>
Cc: linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	David Laight <David.Laight@ACULAB.COM>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 08, 2011 at 12:08:55PM +0530, Suzuki Poulose wrote:
> Hi,
> 
> This is version 2 of the patch
> 
> Changes from Version 1 :
>  : Changed the interface for read_memory_region_limits to use 'int fd'
> 	instead of FILE*.
>  : Use sizeof(variable) for read(, instead of sizeof(type).
> 
> 
> ---
> 
> Fix parsing of the memory region information from the device-tree.
> 
> The format of memory/reg is based on the #address-cells,#size-cells. Currently,
> the kexec-tools doesn't use the above values in parsing the memory/reg values.
> Hence the kexec cannot handle cases where #address-cells, #size-cells are
> different, (for e.g, PPC440X ).
> 
> This patch introduces a read_memory_region_limits(), which parses the
> memory/reg contents based on the values of #address-cells and #size-cells.
> 
> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>

Hi,

this does not seem to apply to the master branch of
git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
