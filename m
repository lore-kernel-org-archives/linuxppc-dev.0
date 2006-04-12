Return-Path: <tony.luck@intel.com>
Received: from fmsmga101-1.fm.intel.com (mga01.intel.com [192.55.52.88])
	by ozlabs.org (Postfix) with ESMTP id 3557B67C41
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 01:56:28 +1000 (EST)
Date: Wed, 12 Apr 2006 08:46:33 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Mel Gorman <mel@skynet.ie>
Subject: Re: [PATCH 0/6] [RFC] Sizing zones and holes in an architecture
	independent manner
Message-ID: <20060412154633.GA10589@agluck-lia64.sc.intel.com>
References: <20060411103946.18153.83059.sendpatchset@skynet>
	<20060411222029.GA7743@agluck-lia64.sc.intel.com>
	<Pine.LNX.4.64.0604112352230.6624@skynet.skynet.ie>
	<20060412000500.GA8532@agluck-lia64.sc.intel.com>
	<Pine.LNX.4.64.0604121001590.24819@skynet.skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0604121001590.24819@skynet.skynet.ie>
Cc: linuxppc-dev@ozlabs.org, ak@suse.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	davej@codemonkey.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 12, 2006 at 11:50:31AM +0100, Mel Gorman wrote:

Patch got corrupted in transit and won't apply (looks like something stripped
trailing spaces from empty lines).  E.g.

> diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc1-104-x86_64_use_init_nodes/arch/ia64/Kconfig linux-2.6.17-rc1-105-ia64_use_init_nodes/arch/ia64/Kconfig
> --- linux-2.6.17-rc1-104-x86_64_use_init_nodes/arch/ia64/Kconfig	2006-04-03 04:22:10.000000000 +0100
> +++ linux-2.6.17-rc1-105-ia64_use_init_nodes/arch/ia64/Kconfig	2006-04-11 23:31:38.000000000 +0100
> @@ -352,6 +352,9 @@ config NUMA
>   	  Access).  This option is for configuring high-end multiprocessor
>   	  server systems.  If in doubt, say N.
> 
> +config ARCH_POPULATES_NODE_MAP
> +	def_bool y
> +
>   # VIRTUAL_MEM_MAP and FLAT_NODE_MEM_MAP are functionally equivalent.
>   # VIRTUAL_MEM_MAP has been retained for historical reasons.
>   config VIRTUAL_MEM_MAP
