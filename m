Return-Path: <davem@davemloft.net>
Received: from outer-richmond.davemloft.net
	(dsl027-180-204.sfo1.dsl.speakeasy.net [216.27.180.204])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 56E4367F73
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2005 14:02:32 +1000 (EST)
Date: Tue, 16 Aug 2005 20:33:12 -0700 (PDT)
Message-Id: <20050816.203312.77701192.davem@davemloft.net>
To: paulus@samba.org
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <17154.38156.13295.731022@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.61.0508161700050.5751@nylon.am.freescale.net>
	<17154.38156.13295.731022@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	galak@freescale.com
Subject: Re: [PATCH] ppc32: removed usage of <asm/segment.h> 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Wed, 17 Aug 2005 11:38:20 +1000

> Kumar Gala writes:
> 
> > Made <asm/segment.h> a dummy include like it is in ppc64 and removed any
> > users if it in arch/ppc.
> 
> Why can't we just delete asm-ppc/segment.h (and asm-ppc64/segment.h
> too, for that matter) entirely?

I concur, in fact we should really kill that thing off entirely.
