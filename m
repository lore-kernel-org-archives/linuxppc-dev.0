Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id E2EBC679F7
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Mar 2006 03:16:21 +1100 (EST)
Date: Tue, 21 Mar 2006 10:15:15 -0600
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/11] powerpc: Remove unused iommu_off logic from
	pSeries_init_early()
Message-ID: <20060321161515.GA5287@pb15.lixom.net>
References: <1142934351.193140.181086235013.qpush@concordia>
	<20060321094627.44FAC679F9@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060321094627.44FAC679F9@ozlabs.org>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 21, 2006 at 08:45:58PM +1100, Michael Ellerman wrote:
> When iommu_init_early_pSeries() was added, ages ago, we forgot to remove
> the code that checks /chosen/linux,iommu-off in pSeries_init_early(). We
> do it now in iommu_init_early_pSeries().
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Olof Johansson <olof@lixom.net>
