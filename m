Return-Path: <mike@compulab.co.il>
Received: from sa2.bezeqint.net (sa2.bezeqint.net [192.115.104.16])
	by ozlabs.org (Postfix) with ESMTP id 80471DDDF3
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 18:08:35 +1100 (EST)
Message-ID: <47525130.2000205@compulab.co.il>
Date: Sun, 02 Dec 2007 08:31:12 +0200
From: Mike Rapoport <mike@compulab.co.il>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: CPM2 USB host driver
References: <200711301145.52926.laurentp@cse-semaphore.com>
	<200711301330.25100.laurentp@cse-semaphore.com>
	<20071130124801.GA13141@localhost.localdomain>
	<200711301628.33526.laurentp@cse-semaphore.com>
In-Reply-To: <200711301628.33526.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 
>> I tried to forward-port FHCI from Freescale 2.6.11 kernels. Twice.
>> But these efforts always stumbled over more important tasks.
> 
> Do you think I start from the FHCI driver provided by Freescale for 2.6.11, 
> from the cpm2usb driver or from scratch ?

The cmp2usb is old and crappy, and I had no time at all to update it. So if the
choice was to start from cpm2usb or from scratch, I'd choose to start from scratch.

> Both the cpm2usb and FHCI drivers seem to use the packet-level interface. Is 
> there any reason not to use the transaction-level interface ?


> Best regards,
> 

-- 
Sincerely yours,
Mike.
