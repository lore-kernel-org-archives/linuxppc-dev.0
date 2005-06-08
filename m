Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3FE8C679E1
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Jun 2005 02:12:07 +1000 (EST)
In-Reply-To: <20050608102938.023f271f.ajz@cambridgebroadband.com>
References: <20050608102938.023f271f.ajz@cambridgebroadband.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d32482ab845e745a00426671eff86b9e@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 8 Jun 2005 12:12:01 -0400
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: consistent_alloc() on 82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 8, 2005, at 5:29 AM, Alex Zeffertt wrote:

> Does anybody know why it isn't built for 6xx cores?

Because 6xx cores are cache coherent and there shouldn't
be any need for "uncached" memory regions.

> I'm working on the ATM driver and it seems that certain external memory
> areas accessed by the PQII CPM by-pass the cache.

That's news to me, and I've written lots of CPM drivers, including ATM.
Do you have a specific example?

Thanks.

	-- Dan
