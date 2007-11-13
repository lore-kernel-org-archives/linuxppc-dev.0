Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id B29FADDEA3
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 15:50:46 +1100 (EST)
Date: Mon, 12 Nov 2007 22:51:32 -0600
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC] Silence an annoying boot message
Message-ID: <20071113045132.GA15180@lixom.net>
References: <20071112135339.9a01b115.sfr@canb.auug.org.au>
	<20071112051532.GA28394@lixom.net>
	<1194857556.18185.33.camel@pasglop>
	<20071113154149.ef77d37f.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071113154149.ef77d37f.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 13, 2007 at 03:41:49PM +1100, Stephen Rothwell wrote:
> vmemmap_populate will printk (with KERN_WARNING) for a lot of pages
> if CONFIG_SPARSEMEM_VMEMMAP is enabled (at least it does on iSeries).
> Use pr_debug for it instead.
> 
> Replace the only other use of DBG in this file with pr_debug as well.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
