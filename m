Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7447EDDEBC
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 22:17:01 +1100 (EST)
Date: Fri, 30 Nov 2007 14:16:38 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: CPM2 USB host driver
Message-ID: <20071130141638.4e00258d@kernel.crashing.org>
In-Reply-To: <200711301145.52926.laurentp@cse-semaphore.com>
References: <200711301145.52926.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, mike@compulab.co.il
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 30 Nov 2007 11:45:49 +0100
Laurent Pinchart wrote:

> Hi everybody,
> 
> Linux USB host support for the CPM, CPM2 and CPM2 pro is far from
> complete. Many people showed interest on this list (and on
> linuxppc-embedded) in the past, but nobody managed to complete a
> driver and get it merged.
> 
that is mainly because of its semi-software nature. However, any approach
would be helpful I beleive. 

> As I need USB host support on my MPC8248 (CPM2), I decided to scratch
> the itch and try to get a working driver that could be merged
> upstream. This mail describes my plans to make sure the code I write
> will be useful for other people.
> 
> The driver will be based on the cpm2usb project
> (http://cpm2usb.sf.net/). As I don't own any CPM1-based platform, I
> will convert the driver to use the CPM2 transaction-level interface,
> thus making it incompatible with the CPM1. CPM1 support could be
> added back later. There is no planned release date, and more urgent
> projects could put this development on hold.
> 
> Comments are welcome (and contributions too, especially in the form
> of a working driver :-)).
> 

I may have some WIP material left, will try to dig it out...

> Best regards,
> 


-- 
Sincerely, Vitaly
