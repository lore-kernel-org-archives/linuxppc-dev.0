Return-Path: <sowmini.varadhan@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C904E1A2B03
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 06:09:52 +1100 (AEDT)
Date: Mon, 23 Mar 2015 15:09:38 -0400
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: David Miller <davem@davemloft.net>
Subject: Re: Generic IOMMU pooled allocator
Message-ID: <20150323190938.GL14061@oracle.com>
References: <20150322192726.GB19474@oracle.com>
 <20150323.122922.887448418154237329.davem@davemloft.net>
 <20150323165406.GG14061@oracle.com>
 <20150323.150508.149509757161802782.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150323.150508.149509757161802782.davem@davemloft.net>
Cc: aik@au1.ibm.com, aik@ozlabs.ru, anton@au1.ibm.com, paulus@samba.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (03/23/15 15:05), David Miller wrote:
> 
> Why add performance regressions to old machines who already are
> suffering too much from all the bloat we are constantly adding to the
> kernel?

I have no personal opinion on this- it's a matter of  choosing
whether we want to have some extra baggage in the library to support
old hardware, or keep the code lean-and-mean for the future,
where the model has changed.

I'll let others on this list make the call.

--Sowmini
