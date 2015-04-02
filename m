Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FBE21A078D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 07:22:38 +1100 (AEDT)
Message-ID: <1428006142.20500.246.camel@kernel.crashing.org>
Subject: Re: [PATCH v8 RFC 0/3] Generic IOMMU pooled allocator
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Date: Fri, 03 Apr 2015 07:22:22 +1100
In-Reply-To: <20150402.122133.402067811944670903.davem@davemloft.net>
References: <551B4502.1020603@oracle.com>
 <20150331.231224.402909066860518278.davem@davemloft.net>
 <20150402125152.GA17528@oracle.com>
 <20150402.122133.402067811944670903.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@au1.ibm.com, sowmini.varadhan@oracle.com, anton@au1.ibm.com,
 paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-04-02 at 12:21 -0400, David Miller wrote:
> From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
> Date: Thu, 2 Apr 2015 08:51:52 -0400
> 
> > do I need to resubmit this without the RFC tag? Perhaps I should
> > have dropped that some time ago.
> 
> I want to hear from the powerpc folks whether they can positively
> adopt the new generic code or not.

Oh yes, I'm fine with it, it's basically our code slightly refactored,
but I still have a few minor review comments on Swomini's patch I
started to put together yesterday but didn't finish. I'll send them
today.

Cheers,
Ben.
