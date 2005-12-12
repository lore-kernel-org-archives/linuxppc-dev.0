Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C0EA468909
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Dec 2005 16:35:52 +1100 (EST)
In-Reply-To: <439CE3A2.8020603@rftechnology.com.au>
References: <439CE3A2.8020603@rftechnology.com.au>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <dc0620490d9bef30d3a4b629483cd3f9@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 12 Dec 2005 00:01:26 -0500
To: Dmytro Bablinyuk <dmytro.bablinyuk@rftechnology.com.au>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 82xx IRQ handling
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Dec 11, 2005, at 9:42 PM, Dmytro Bablinyuk wrote:

> immap->im_intctl.ic_simrh &= ~(0x0800);

You should not be messing around with this register
in your code.  The generic 82xx interrupt functions
will properly manage this for you.

> request_irq(IRQ,	
>             &irq_handler,	/* our handler */
>             irq_flags,
>             "interrupt_test",
>             NULL);

This is all you should do.

Thanks.

	-- Dan
