Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D06E8679FE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 May 2005 06:32:27 +1000 (EST)
In-Reply-To: <428CF693.5030100@mrv.com>
References: <20050518170949.GA6766@gate.ebshome.net> <428CD40C.201@mrv.com>
	<2376d87e3df664106a6cf626f9575d90@embeddededge.com>
	<428CEA55.1040904@mrv.com>
	<5e493590088edcf959e30390363e798d@embeddededge.com>
	<428CF693.5030100@mrv.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e6669029335470188ab956f01c30e82b@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 19 May 2005 16:32:37 -0400
To: Guillaume Autran <gautran@mrv.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: fix cpm_uart_int() missing interrupts
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 19, 2005, at 4:26 PM, Guillaume Autran wrote:

> You are right, moving the event clearing statement is much easier and 
> cleaner. Let the interrupt be the loop.

I also just had the thought we could check the events for non-zero,
clear them, and process only the ones we wanted.  That would save
the interrupt overhead if we had high speed ports (which I really
don't like for normal RS-232 anyway :-)).

I'll move this patch ahead.

Thanks.


	-- Dan
