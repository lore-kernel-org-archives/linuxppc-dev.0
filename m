Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 762EEDDF15
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 17:01:34 +1000 (EST)
Date: Thu, 24 Apr 2008 00:01:31 -0700 (PDT)
Message-Id: <20080424.000131.193689574.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: LMB regression...
From: David Miller <davem@davemloft.net>
In-Reply-To: <18448.12058.743037.267216@cargo.ozlabs.ibm.com>
References: <20080423.232419.193712136.davem@davemloft.net>
	<18448.12058.743037.267216@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Thu, 24 Apr 2008 16:56:26 +1000

> David Miller writes:
> 
> > Specifically, you removed the aligning of the size argument given to
> > lmb_add_region() in the lmb allocators, and that is critical when
> > allocating many small chunks, we run out of LMB slots otherwise
> > and allocations start failing.
> 
> Sorry.  It's still there in lmb_alloc_nid_unreserved but I lost the
> one in __lmb_alloc_base.  Are you going to send a fix to Linus, or
> will I include it in the pull request I'm going to send tomorrow?

I've got it, see my other email.
