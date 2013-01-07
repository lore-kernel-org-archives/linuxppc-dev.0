Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 01E142C0091
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2013 03:42:14 +1100 (EST)
Subject: Re: [PATCH] powerpc/mm: eliminate unneeded for_each_memblock
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1357322760-12197-1-git-send-email-cody@linux.vnet.ibm.com>
Date: Mon, 7 Jan 2013 10:42:02 -0600
Message-Id: <82A31E2D-FA24-44CF-9812-9E8062AFA6F4@kernel.crashing.org>
References: <1357322760-12197-1-git-send-email-cody@linux.vnet.ibm.com>
To: Cody P Schafer <cody@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 4, 2013, at 12:06 PM, Cody P Schafer wrote:

> The only persistent change made by this loop is calling
> memblock_set_node() once for each memblock, which is not useful (and has
> no effect) as memblock_set_node() is not called with any
> memblock-specific parameters.
> 
> Subsistute a single memblock_set_node().
> ---
> arch/powerpc/mm/mem.c | 9 ++-------
> 1 file changed, 2 insertions(+), 7 deletions(-)

Missing a signed-off-by

- k
