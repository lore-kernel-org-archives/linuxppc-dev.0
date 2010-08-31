Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 9B2E2B70FE
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 11:07:49 +1000 (EST)
Subject: Re: [PATCH] powerpc/kvm/e500_tlb: Fix a minor copy-paste tracing bug
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1283182719-4621-1-git-send-email-Kyle.D.Moffett@boeing.com>
Date: Tue, 31 Aug 2010 03:07:43 +0200
Message-Id: <4B040308-883F-4A90-BEA4-034DC6B2C6A6@suse.de>
References: <1282936005-17078-1-git-send-email-Kyle.D.Moffett@boeing.com>
	<1283182719-4621-1-git-send-email-Kyle.D.Moffett@boeing.com>
To: Kyle Moffett <Kyle.D.Moffett@boeing.com>
Cc: linuxppc-dev@ozlabs.org, Kyle Moffett <kyle@moffetthome.net>,
	Liu Yu <yu.liu@freescale.com>, linux-kernel@vger.kernel.org,
	kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 30.08.2010, at 17:38, Kyle Moffett wrote:

> The kvmppc_e500_stlbe_invalidate() function was trying to pass too many
> parameters to trace_kvm_stlb_inval().  This appears to be a bad
> copy-paste from a call to trace_kvm_stlb_write().
> 
> Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>

Thanks, applied.

Alex
