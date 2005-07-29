Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 05C2B67D71
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Jul 2005 03:42:59 +1000 (EST)
In-Reply-To: <42EA60E1.7040804@parks.com.br>
References: <20050729013303.33814.qmail@web40712.mail.yahoo.com>	<42EA2A2E.5040708@parks.com.br>	<20050729144015.09fec9fe.ajz@cambridgebroadband.com>	<42EA34A1.7060600@parks.com.br>
	<20050729154359.1ac8f488.ajz@cambridgebroadband.com>
	<42EA60E1.7040804@parks.com.br>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b50c9dbfb13d8e2f5a82c2a299e46240@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 29 Jul 2005 13:43:09 -0400
To: "Tiago Dall'Agnol" <tdallagnol@parks.com.br>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: request_8xxirq
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jul 29, 2005, at 1:01 PM, Tiago Dall'Agnol wrote:

> Am I wrong? I didn't understand when that function request_irq is used.

At some point I don't remember and against all of my wishes, the code
was changed from using request_8xxirq to using request_irq using
an ugly hack to add some offset to the 8xx interrupt vector number.
I didn't see any bug that needed fixing, but people with the power to
ignore my maintainer status decided to change it anyway.  So, now you
have to modify your drivers to call request_irq() with some nonsensical
interrupt number.  No value added, just confusion.

Thanks.

	-- Dan
