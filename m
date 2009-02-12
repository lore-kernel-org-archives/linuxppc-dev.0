Return-Path: <benh@kernel.crashing.org>
Subject: Re: [RFC patch] powerpc: Add topology_ready to machdep calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <49935F81.7060203@am.sony.com>
References: <49935F81.7060203@am.sony.com>
Content-Type: text/plain
Date: Thu, 12 Feb 2009 15:21:59 +1100
Message-Id: <1234412519.29851.41.camel@pasglop>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-02-11 at 15:30 -0800, Geoff Levand wrote:
> Add a new member topology_ready to the powerpc machdep_calls
> structure.
> 
> The NUMA hot plug memory routines require the NUMA node to have
> been registered via register_one_node() prior to adding memory
> to the node.  The powerpc arch registers NUMA nodes during
> startup in its topology_init() routine.

Just a question.. what's wrong with just using some later kind of
initcall ? You want to get the memory added as early as possible ?

Cheers,
Ben.
