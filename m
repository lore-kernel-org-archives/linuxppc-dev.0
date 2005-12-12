Return-Path: <dmytro.bablinyuk@rftechnology.com.au>
Received: from mfep6.connect.com.au (fep6.mfe.bur.connect.com.au [203.63.86.6])
	by ozlabs.org (Postfix) with ESMTP id 9FFD56890B
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Dec 2005 17:00:12 +1100 (EST)
Message-ID: <439D120E.9010606@rftechnology.com.au>
Date: Mon, 12 Dec 2005 17:00:46 +1100
From: Dmytro Bablinyuk <dmytro.bablinyuk@rftechnology.com.au>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
References: <439CE3A2.8020603@rftechnology.com.au>
	<dc0620490d9bef30d3a4b629483cd3f9@embeddededge.com>
In-Reply-To: <dc0620490d9bef30d3a4b629483cd3f9@embeddededge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

> 
>> immap->im_intctl.ic_simrh &= ~(0x0800);
> 
> 
> You should not be messing around with this register
> in your code.  The generic 82xx interrupt functions
> will properly manage this for you.
Thank you Dan,
It's working now!

By the way question - shall I program somewhere an edge of the IRQ or it 
always triggers on the rising edge?

Also does anybody knows any source code example of using 82xx General 
Purpose Timer Unit so that it triggers interrupt handler after some period.

Thank you
