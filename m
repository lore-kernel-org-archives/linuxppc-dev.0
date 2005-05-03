Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E1556679E3
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 May 2005 04:47:40 +1000 (EST)
In-Reply-To: <20050502204259.GB4065@logos.cnet>
References: <20050502204259.GB4065@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d81a525fa15c1adfc6774a1e445dde8c@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 3 May 2005 14:47:28 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: CONFIG_PIN_TLB experiments
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 2, 2005, at 4:42 PM, Marcelo Tosatti wrote:

> I've been testing the CONFIG_PIN_TLB option under v2.6, results are 
> not good.

As you pointed out before, the implementation looks incorrect,
so I'll take a look at it and verify with tests.  I'm currently 
debugging
some hardware problems with a new 8xx board, when I get over
that I'll look at it.

Thanks.


	-- Dan
