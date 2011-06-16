Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (unknown [IPv6:2406:a000:f000:9500::1])
	by ozlabs.org (Postfix) with ESMTP id 623EDB6F7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 08:00:57 +1000 (EST)
Date: Fri, 17 Jun 2011 07:00:43 +0900
From: Simon Horman <horms@verge.net.au>
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: Re: [PATCH v2] kexec-tools: powerpc: Use the #address-cells
	information to parsememory/reg
Message-ID: <20110616220043.GA2434@verge.net.au>
References: <20110616104441.8065.46187.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110616104441.8065.46187.stgit@suzukikp.in.ibm.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	David Laight <David.Laight@ACULAB.COM>,
	linux ppc dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 16, 2011 at 04:15:13PM +0530, Suzuki K. Poulose wrote:
> The format of memory/reg is based on the #address-cells,#size-cells. Currently,
> the kexec-tools doesn't use the above values in parsing the memory/reg values.
> Hence the kexec cannot handle cases where #address-cells, #size-cells are
> different, (for e.g, PPC440X ).
> 
> This patch introduces a read_memory_region_limits(), which parses the
> memory/reg contents based on the values of #address-cells and #size-cells.

Thanks, applied.
