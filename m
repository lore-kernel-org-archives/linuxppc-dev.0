Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C85BCDF05D
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 01:06:14 +1000 (EST)
Message-Id: <02DA4660-D8BF-4B0D-99C0-F5059A9B2F69@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200804171702.59562.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] rtc-pcf8563: Add device ids table
Date: Thu, 17 Apr 2008 10:05:54 -0500
References: <200804171702.59562.laurentp@cse-semaphore.com>
Cc: a.zummo@towertech.it, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 17, 2008, at 10:02 AM, Laurent Pinchart wrote:
> Hi,
>
> here's a patch against 2.6.25-rc8-mm2 that adds support for device  
> tree names
> to the rtc-pcf8563 driver.
>
> Is the new-style driver conversion patch in 2.6.25-rc8-mm2 scheduled  
> for
> 2.6.26 ?

Should probably include the rtc & i2c mailing list on such patches/ 
questions.

- k
