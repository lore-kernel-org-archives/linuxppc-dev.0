Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 6283AB711A
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Aug 2010 10:58:29 +1000 (EST)
Subject: Re: [PATCH] powerpc/kvm/e500_tlb: Fix a minor copy-paste tracing bug
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1282936005-17078-1-git-send-email-Kyle.D.Moffett@boeing.com>
Date: Sat, 28 Aug 2010 02:58:23 +0200
Message-Id: <B3286B71-599C-405E-847F-06B843A46449@suse.de>
References: <1282936005-17078-1-git-send-email-Kyle.D.Moffett@boeing.com>
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


On 27.08.2010, at 21:06, Kyle Moffett wrote:

> The kvmppc_e500_stlbe_invalidate() function was trying to pass too =
many
> parameters to trace_kvm_stlb_inval().  This appears to be a bad
> copy-paste from a call to trace_kvm_stlb_write().

Which kernel is this against? That trace point is already commented out =
in my tree.


Alex
