Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8BB33DE5AD
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 23:55:29 +1000 (EST)
Message-Id: <34687519-FB41-4447-9575-68EB1DC2D3EC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20090423225611.d569764c.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH v2] powerpc: fix for long standing bug noticed by gcc 4.4.0
Date: Thu, 23 Apr 2009 08:55:12 -0500
References: <20090423160656.fac84e3f.sfr@canb.auug.org.au>
	<20090423103336.GA3825@zod.rchland.ibm.com>
	<20090423225611.d569764c.sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 23, 2009, at 7:56 AM, Stephen Rothwell wrote:

> Previous gcc versions didn't notice this because one of the preceding
> #ifs always evaluated to true.
>
> gcc 4.4.0 produced this error:
>
> arch/powerpc/mm/tlb_nohash_low.S:206:6: error: #elif with no  
> expression
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> ---
> arch/powerpc/mm/tlb_nohash_low.S |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
> v2: fixed up commit message, added Josh'd Ack.

applied to merge.  Picking this up as I'm touching tlb_nohash_low.S w/ 
another "fix".

- k
