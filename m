Return-Path: <bgat@billgatliff.com>
Received: from venus.billgatliff.com (venus.billgatliff.com [209.251.101.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6FABFDDEF7
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 15:06:41 +1100 (EST)
Message-ID: <48EED4D1.2040506@billgatliff.com>
Date: Thu, 09 Oct 2008 23:06:41 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [RFC 0/6] Proposal for a Generic PWM Device API
References: <cover.1223482372.git.bgat@billgatliff.com>
	<1223608819.8157.127.camel@pasglop>
In-Reply-To: <1223608819.8157.127.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2008-10-08 at 11:43 -0500, Bill Gatliff wrote:
>> This series proposes a "generic PWM" driver API.
>>
>> This proposed API is motivated by the author's need to support
>> pluggable devices; a secondary objective is to consolidate the
>> existing PWM implementations behind an agreeable, consistent,
>> redundancy-reducing interface.
> 
>  .../...
> 
> You should send your patches to the main linux kernel list !

Perhaps.  But it seemed more relevant to this crowd, and the linux-embedded
crowd, and the linux-arm-kernel crowd.

At the very least, it made sense to present it in this sort of venue first.
Given that it's a "global" API proposal, I suppose I'll have to run it by lkml
at some point--- unless one of the aforementioned groups can mainline it themselves.



b.g.
-- 
Bill Gatliff
bgat@billgatliff.com
